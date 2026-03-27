#--------------------------------------------
# new kobe plots for red grouper
#--------------------------------------------

# models previously run (SS3, SPiCT, BSM, CMSY, OCOM & IMIPAS' kobe)

# SS3 kobe from best model 
# Out3 <- SS_output(dir = "C:/Kraken/MeroPYuc/SS-DL-tool-master/Scenarios/1983mexmidcpue_4cpues_h84_mixedgpar")

# kobe plot with b/bmsy & F/Fmsy

dta <- Out3$Kobe
tmp <- Out3$derived_quants

dta2 <- dta %>%
  mutate(
    kobe_status = case_when(
      B.Bmsy >= 1 & F.Fmsy <= 1 ~ "Sustainable",  # B > BMSY, F < FMSY
      B.Bmsy >= 1 & F.Fmsy > 1 ~ "Overfishing", # B > BMSY, F > FMSY
      B.Bmsy < 1 & F.Fmsy <= 1 ~ "Recovery", # B < BMSY, F < FMSY
      B.Bmsy < 1 & F.Fmsy > 1 ~ "Overfished" # B < BMSY, F > FMSY
    ),
    # Aseguramos que 'year' sea numérico para la etiqueta
    year = as.numeric(Yr)
  )


first_year <- dta2[1, ]
last_year_index <- nrow(dta2)

bestssk<-ggplot(data = dta2, aes(x = B.Bmsy, y = F.Fmsy, label = year)) +
  
  # Líneas de referencia (B.Bmsy=1, F.Fmsy=1)
  geom_hline(yintercept = 1, linetype = "dashed", color = "black") +
  geom_vline(xintercept = 1, linetype = "dashed", color = "black") +
  
  # Puntos (con color asignado por kobe_status)
  geom_point(aes(colour = kobe_status), show.legend = TRUE, size = 2, alpha = 0.7) +
  
  # AUMENTAR TAMAÑO DEL PUNTO INICIAL (PRIMER AÑO)
  geom_point(data = first_year, # Usa solo la fila del primer año
             aes(colour = kobe_status),
             size = 4, # Tamaño más grande
             shape = 15) + # Forma cuadrada para destacarlo (opcional)
  
  # Trayectoria con flechas
  geom_segment(aes(x = B.Bmsy, y = F.Fmsy, xend = lead(B.Bmsy), yend = lead(F.Fmsy), colour = kobe_status),
               arrow = arrow(length = unit(0.2,"cm"))) +
  
  # Barras de error horizontales (B/B_MSY) - Último punto
  geom_segment(aes(x = dta2$B.Bmsy[last_year_index] + tmp[tmp$Label=="Bratio_2023","StdDev"],
                   xend = dta2$B.Bmsy[last_year_index] - tmp[tmp$Label=="Bratio_2023","StdDev"],
                   y = dta2$F.Fmsy[last_year_index], yend = dta2$F.Fmsy[last_year_index]),
               col = "grey", size = 1) +
  
  # Barras de error verticales (F/F_MSY) - Último punto
  geom_segment(aes(x = dta2$B.Bmsy[last_year_index], xend = dta2$B.Bmsy[last_year_index],
                   y = dta2$F.Fmsy[last_year_index] + tmp[tmp$Label=="F_2023","StdDev"],
                   yend = dta2$F.Fmsy[last_year_index] - tmp[tmp$Label=="F_2023","StdDev"]),
               col = "grey", size = 1) +
  
  # Punto final con incertidumbre (en color gris para destacarlo)
  annotate("point", x = dta2$B.Bmsy[last_year_index], y = dta2$F.Fmsy[last_year_index], size = 3, shape = 21, fill = "white", colour = "black") +
  
  # REEMPLAZAR geom_text CON ggrepel::geom_text_repel
  geom_text_repel(aes(colour = kobe_status), # Mantiene el color por estado
                  min.segment.length = 0, # Dibuja segmentos hasta el punto
                  size = 3.5,
                  max.overlaps = 3) + # Permite que se procesen todas las etiquetas
  
  # Aplicar los colores manuales y el nombre de la leyenda
  scale_colour_manual(values = kobe_colors, name = "Status of stock") +
  
  # Escalas y títulos
  expand_limits(y = 0, x = c(0, 2.2)) +
  scale_y_continuous(expand = c(0, 0), breaks = seq(0, 5.5, 0.5)) +
  scale_x_continuous(expand = c(0, 0), breaks = seq(0, 4.5, 0.5)) +
  labs(x = expression(B/B[MSY]), y = expression(F/F[MSY])) +
  
  # Temas
  theme_bw() +
  theme(
    panel.grid.major = element_blank(), 
    panel.grid.minor = element_blank(),
    legend.position = "bottom"
  )
