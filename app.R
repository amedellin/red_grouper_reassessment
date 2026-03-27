library(shiny)
library(ggplot2)
library(gridExtra)

# Función logística
logistic <- function(L, L50, L95) {
  1 / (1 + exp(-log(19) * (L - L50) / (L95 - L50)))
}

# Función de selectividad en forma de domo
dome_selectivity <- function(L, SL50, SL95, SR50, SR95) {
  asc <- logistic(L, SL50, SL95)
  desc <- logistic(L, SR50, SR95)
  asc * (1 - desc)
}

# Función para ejecutar la simulación LBSPR
run_lbspr_simulation <- function(linf, cv_linf, mk, l50, l95, 
                                  sel_type, sl50, sl95, sr50, sr95, fm) {
  
  # Configuración de longitudes
  bin_width <- linf / 20
  max_L <- 1.3 * linf
  lengths <- seq(bin_width / 2, max_L, by = bin_width)
  
  # Calcular selectividad
  if (sel_type == "asymptotic") {
    selectivity <- logistic(lengths, sl50, sl95)
  } else {
    selectivity <- dome_selectivity(lengths, sl50, sl95, sr50, sr95)
  }
  
  # Calcular madurez
  maturity <- logistic(lengths, l50, l95)
  
  # Configuración de grupos de crecimiento (GTG)
  sd_linf <- cv_linf * linf
  max_sd <- 2
  ngtg <- 13
  gtg_linfs <- linf - max_sd * sd_linf + 
    (0:(ngtg - 1)) / (ngtg - 1) * (2 * max_sd * sd_linf)
  
  # Distribución de reclutas
  rec_p <- exp(-0.5 * ((gtg_linfs - linf) / sd_linf)^2)
  rec_p_norm <- rec_p / sum(rec_p)
  
  # Inicializar matrices de números en longitud
  NatL_UF <- matrix(0, nrow = length(lengths), ncol = ngtg)
  NatL_F <- matrix(0, nrow = length(lengths), ncol = ngtg)
  
  # Calcular números en longitud para cada GTG
  for (g in 1:ngtg) {
    gtg_linf <- gtg_linfs[g]
    NPR_U <- rec_p_norm[g]
    NPR_F <- rec_p_norm[g]
    
    for (i in 1:length(lengths)) {
      L <- lengths[i]
      MKL <- mk
      
      if (sel_type == "asymptotic") {
        sel <- logistic(L, sl50, sl95)
      } else {
        sel <- dome_selectivity(L, sl50, sl95, sr50, sr95)
      }
      
      FKL <- fm * mk * sel
      ZKL <- MKL + FKL
      
      if (L < gtg_linf) {
        delta_L <- bin_width
        surv_U <- exp(-MKL * delta_L / (gtg_linf - L))
        surv_F <- exp(-ZKL * delta_L / (gtg_linf - L))
        
        NatL_UF[i, g] <- NPR_U * (1 - surv_U) / MKL
        NatL_F[i, g] <- NPR_F * (1 - surv_F) / ZKL
        
        NPR_U <- NPR_U * surv_U
        NPR_F <- NPR_F * surv_F
      }
    }
  }
  
  # Agregar a través de GTGs
  total_N_UF <- rowSums(NatL_UF)
  total_N_F <- rowSums(NatL_F)
  
  # Aplicar selectividad a la captura
  if (sel_type == "asymptotic") {
    catch_sel <- logistic(lengths, sl50, sl95)
  } else {
    catch_sel <- dome_selectivity(lengths, sl50, sl95, sr50, sr95)
  }
  total_N_F_catch <- total_N_F * catch_sel
  
  # Calcular fecundidad
  fecundity <- lengths^3
  
  # Calcular SPR
  EPR0 <- sum(total_N_UF * maturity * fecundity)
  EPRf <- sum(total_N_F_catch * maturity * fecundity)
  spr <- EPRf / EPR0
  
  # Composición de longitudes en la captura
  total_catch <- sum(total_N_F_catch)
  length_comp <- total_N_F_catch / total_catch
  
  list(
    spr = spr,
    lengths = lengths,
    length_comp = length_comp,
    selectivity = selectivity,
    maturity = maturity
  )
}

# Interfaz de usuario
ui <- fluidPage(
  titlePanel("LBSPR Simulator - Length-Based Spawning Potential Ratio"),
  
  sidebarLayout(
    sidebarPanel(
      width = 3,
      
      h4("Biological Parameters"),
      sliderInput("linf", "L∞ (Asymptotic Length, cm):", 
                  min = 50, max = 200, value = 100, step = 5),
      sliderInput("cv_linf", "CV of L∞:", 
                  min = 0.05, max = 0.3, value = 0.1, step = 0.01),
      sliderInput("mk", "M/K Ratio:", 
                  min = 0.5, max = 3, value = 1.5, step = 0.1),
      sliderInput("l50", "L50 (Maturity, cm):", 
                  min = 20, max = 160, value = 50, step = 1),
      sliderInput("l95", "L95 (Maturity, cm):", 
                  min = 20, max = 180, value = 55, step = 1),
      
      hr(),
      
      h4("Selectivity Parameters"),
      selectInput("sel_type", "Selectivity Type:", 
                  choices = c("Asymptotic" = "asymptotic", 
                              "Dome-shaped" = "dome"),
                  selected = "asymptotic"),
      sliderInput("sl50", "SL50 (Ascending, cm):", 
                  min = 10, max = 140, value = 40, step = 1),
      sliderInput("sl95", "SL95 (Ascending, cm):", 
                  min = 10, max = 160, value = 45, step = 1),
      
      conditionalPanel(
        condition = "input.sel_type == 'dome'",
        sliderInput("sr50", "SR50 (Descending, cm):", 
                    min = 50, max = 240, value = 80, step = 1),
        sliderInput("sr95", "SR95 (Descending, cm):", 
                    min = 50, max = 260, value = 100, step = 1)
      ),
      
      hr(),
      
      h4("Fishing Pressure"),
      sliderInput("fm", "F/M Ratio:", 
                  min = 0, max = 4, value = 1.0, step = 0.1),
      
      hr(),
      
      h4("Quick Presets"),
      actionButton("light_fishing", "Light Fishing", 
                   class = "btn-success btn-block"),
      actionButton("moderate_fishing", "Moderate Fishing", 
                   class = "btn-warning btn-block"),
      actionButton("heavy_fishing", "Heavy Fishing", 
                   class = "btn-danger btn-block")
    ),
    
    mainPanel(
      width = 9,
      
      # Panel de información
      wellPanel(
        h4("About LBSPR"),
        p("Length-Based Spawning Potential Ratio (LBSPR) is a method to assess fish stock status using length composition data.",
          "SPR is the ratio of spawning output under fishing to unfished spawning output.",
          strong("SPR > 0.4 generally indicates sustainable fishing."),
          "Developed to compare LBSPR using different selectivity patterns, based on Hordyk et al (2015a,b,c;2016)",
          "alfonso.medellin@enesmerida.unam.mx")
      ),
      
      # Resultados de SPR
      uiOutput("spr_result"),
      
      # Gráficas
      fluidRow(
        column(6, plotOutput("length_comp_plot", height = "350px")),
        column(6, plotOutput("sel_mat_plot", height = "350px"))
      ),
      
      # Puntos de referencia
      wellPanel(
        h4("Reference Points"),
        fluidRow(
          column(4, 
                 div(style = "background-color: #d4edda; padding: 10px; border-radius: 5px;",
                     strong("SPR > 40%"),
                     p("Stock is healthy and sustainable"))
          ),
          column(4,
                 div(style = "background-color: #fff3cd; padding: 10px; border-radius: 5px;",
                     strong("20% < SPR < 40%"),
                     p("Caution - approaching overfishing"))
          ),
          column(4,
                 div(style = "background-color: #f8d7da; padding: 10px; border-radius: 5px;",
                     strong("SPR < 20%"),
                     p("Overfished - reduce fishing pressure"))
          )
        )
      )
    )
  )
)

# Servidor
server <- function(input, output, session) {
  
  # Actualizar límites dinámicamente
  observe({
    updateSliderInput(session, "l50", max = input$linf * 0.8)
    updateSliderInput(session, "l95", min = input$l50, max = input$linf * 0.9)
    updateSliderInput(session, "sl50", max = input$linf * 0.7)
    updateSliderInput(session, "sl95", min = input$sl50, max = input$linf * 0.8)
    updateSliderInput(session, "sr50", min = input$sl95 + 5, max = input$linf * 1.2)
    updateSliderInput(session, "sr95", min = input$sr50 + 5, max = input$linf * 1.3)
  })
  
  # Presets
  observeEvent(input$light_fishing, {
    updateSliderInput(session, "fm", value = 0.5)
    updateSliderInput(session, "sl50", value = 40)
    updateSliderInput(session, "sl95", value = 45)
    updateSelectInput(session, "sel_type", selected = "asymptotic")
  })
  
  observeEvent(input$moderate_fishing, {
    updateSliderInput(session, "fm", value = 1.5)
    updateSliderInput(session, "sl50", value = 30)
    updateSliderInput(session, "sl95", value = 35)
    updateSelectInput(session, "sel_type", selected = "asymptotic")
  })
  
  observeEvent(input$heavy_fishing, {
    updateSliderInput(session, "fm", value = 2.5)
    updateSliderInput(session, "sl50", value = 25)
    updateSliderInput(session, "sl95", value = 30)
    updateSelectInput(session, "sel_type", selected = "asymptotic")
  })
  
  # Ejecutar simulación
  results <- reactive({
    run_lbspr_simulation(
      linf = input$linf,
      cv_linf = input$cv_linf,
      mk = input$mk,
      l50 = input$l50,
      l95 = input$l95,
      sel_type = input$sel_type,
      sl50 = input$sl50,
      sl95 = input$sl95,
      sr50 = input$sr50,
      sr95 = input$sr95,
      fm = input$fm
    )
  })
  
  # Mostrar resultado de SPR
  output$spr_result <- renderUI({
    res <- results()
    spr_pct <- res$spr * 100
    
    color <- if (res$spr > 0.4) {
      "#d4edda"
    } else if (res$spr > 0.2) {
      "#fff3cd"
    } else {
      "#f8d7da"
    }
    
    status <- if (res$spr > 0.4) {
      "✓ Sustainable"
    } else if (res$spr > 0.2) {
      "⚠ Caution"
    } else {
      "✗ Overfished"
    }
    
    div(
      style = paste0("background-color: ", color, 
                     "; padding: 20px; border-radius: 10px; margin-bottom: 20px; border: 2px solid;"),
      fluidRow(
        column(6,
               h2(paste0("SPR: ", round(spr_pct, 1), "%")),
               p(status, style = "font-size: 16px;")
        ),
        column(6, align = "right",
               p("F/M Ratio", style = "margin-bottom: 5px;"),
               h3(round(input$fm, 2))
        )
      )
    )
  })
  
  # Gráfica de composición de longitudes
  output$length_comp_plot <- renderPlot({
    res <- results()
    
    df <- data.frame(
      length = res$lengths,
      frequency = res$length_comp
    )
    
    ggplot(df, aes(x = length, y = frequency)) +
      geom_bar(stat = "identity", fill = "#3b82f6") +
      labs(
        title = "Catch Length Composition",
        x = "Length (cm)",
        y = "Frequency"
      ) +
      theme_minimal() +
      theme(
        plot.title = element_text(size = 16, face = "bold"),
        axis.title = element_text(size = 12),
        panel.grid.minor = element_blank()
      )
  })
  
  # Gráfica de selectividad y madurez
  output$sel_mat_plot <- renderPlot({
    res <- results()
    
    df <- data.frame(
      length = res$lengths,
      selectivity = res$selectivity,
      maturity = res$maturity
    )
    
    ggplot(df, aes(x = length)) +
      geom_line(aes(y = selectivity, color = "Selectivity"), size = 1.2) +
      geom_line(aes(y = maturity, color = "Maturity"), size = 1.2) +
      scale_color_manual(values = c("Selectivity" = "#3b82f6", "Maturity" = "#10b981")) +
      labs(
        title = "Selectivity & Maturity",
        x = "Length (cm)",
        y = "Probability",
        color = ""
      ) +
      theme_minimal() +
      theme(
        plot.title = element_text(size = 16, face = "bold"),
        axis.title = element_text(size = 12),
        legend.position = "bottom",
        panel.grid.minor = element_blank()
      ) +
      ylim(0, 1)
  })
}

# Ejecutar la aplicación
shinyApp(ui = ui, server = server)
