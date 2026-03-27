#---------------------------------------------------------
# SPiCT & BSM for red grouper
#---------------------------------------------------------

# SPiCT analysis

# historical catch data
hist<-read.csv("C:/Kraken/MeroPYuc/SS3_Input_data/catchess3_4flt_new.csv",sep=",",header=TRUE)
hist$total<-hist$Fleet_1+hist$Fleet_2+hist$Fleet_3+hist$Fleet_4

histx<-filter(hist,Year>=1982)

cvct<-sd(hist$total)/mean(hist$total)

# spict with two indexes of abundance
inp <- list("timeC"=hist$Year,"obsC"=hist$total)

inp$timeI<-list("timeI"=cpueht2$Year,"timeI"=cpueht2$Year)
inp$obsI<-list()
inp$obsI[[1]]<-cpueht2$hooks
inp$obsI[[2]]<-cpueht2$trawl
inp$logq <- c(log(0.01),2,0)

inp$priors$logn <- c(log(1.2), 0.2, 1)
inp$priors$logbkfrac <- c(log(0.999), 0.1, 1)
inp$priors$logK <- c(log(max(hist$total)*2),0.6,1)
inp$priors$logr<- c(log(0.35),0.6, 1)
inp$priors$logsdc<-c(log(cvct),0.1,0) # process error on catch
inp$priors$logsdb<-c(log(0.1),0.1,0) # process error on biomass
inp$priors$logsdi<-c(log(0.2),0.1,0) # observation error on index

# Model
res <- fit.spict(inp)

# Evaluate results

sumspict.parest(res)

summary(res)

plot(res)
plotspict.priors(res)

# time to bmsy changing F
plotspict.tc(res)
plotspict.biomass(res)
plotspict.bbmsy(res)

# residual analysis... asumptions of data to be fitted in model
ress<-calc.osa.resid(res)
plotspict.diagnostic(ress)

#retrospective analysis
rets<-retro(res,nretroyear=5,mc.cores=1)
plotspict.retro(rets)
plotspict.retro.fixed(rets)

# Get b/bmsy & f/fmsy estimates

get.par("logBBmsy", res, exp=TRUE) # B/Bmsy time series
get.par("logFFmsy", res, exp=TRUE) # F/Fmsy time series

BBmsy_spict_raw <- get.par("logBBmsy", res, exp = TRUE)

FFmsy_spict_raw <- get.par("logFFmsy", res, exp = TRUE)

# Create data.table for kobe plot
kobeB_spict <- data.table(
  Year = res$inp$timeC,  
  bbmsy = BBmsy_spict_raw[, "est"][as.character(res$inp$timeC)],
  bbmsyl = BBmsy_spict_raw[, "ll"][as.character(res$inp$timeC)],
  bbmsyh = BBmsy_spict_raw[, "ul"][as.character(res$inp$timeC)],
  ffmsy = FFmsy_spict_raw[, "est"][as.character(res$inp$timeC)],
  ffmsyl = FFmsy_spict_raw[, "ll"][as.character(res$inp$timeC)],
  ffmsyh = FFmsy_spict_raw[, "ul"][as.character(res$inp$timeC)]
)



# Create data.table with stock biomass
B_spict_raw <- get.par("logB", res, exp = TRUE)

B_spict_table <- data.table(
  Year = res$inp$timeC,  
  B = B_spict_raw[, "est"][as.character(res$inp$timeC)],
  Blower = B_spict_raw[, "ll"][as.character(res$inp$timeC)],
  Bhigher = B_spict_raw[, "ul"][as.character(res$inp$timeC)],
  Fuente = "SPiCT_redgrouper",
  B_MSY =get.par("logBmsy", res, exp = TRUE)[2],
  MSY = get.par("logMSY", res, exp = TRUE)[2]
)

# Kobe para cada punto
spikobe <- kobeB_spict %>%
  mutate(
    kobe_status = case_when(
      bbmsy >= 1 & ffmsy <= 1 ~ "Sustainable",  # B > BMSY, F < FMSY
      bbmsy >= 1 & ffmsy > 1 ~ "Overfishing", # B > BMSY, F > FMSY
      bbmsy < 1 & ffmsy <= 1 ~ "Recovery", # B < BMSY, F < FMSY
      bbmsy < 1 & ffmsy > 1 ~ "Overfished" # B < BMSY, F > FMSY
    ),
    # Aseguramos que 'year' sea numérico para la etiqueta
    year = as.numeric(Year)
  )

# Definir colores manualmente para cada estado
kobe_colors <- c(
  "Sustainable" = "darkgreen", 
  "Overfishing" = "orange",
  "Recovery" = "gold",
  "Overfished" = "red"
)

first_years <- spikobe[1, ]
last_year_indexs <- nrow(spikobe)

tmp11<-data.frame(
  Label=c("Bratio_2023","F_2023"),
  StdDev=c(0.08,0.05)
)

spictk<-ggplot(data = spikobe, aes(x = bbmsy, y = ffmsy, label = Year)) +
  
  # Líneas de referencia (BBMSY=1, FFMSY=1)
  geom_hline(yintercept = 1, linetype = "dashed", color = "black") +
  geom_vline(xintercept = 1, linetype = "dashed", color = "black") +
  
  # Puntos (con color asignado por kobe_status)
  geom_point(aes(colour = kobe_status), show.legend = TRUE, size = 2, alpha = 0.7) +
  
  # AUMENTAR TAMAÑO DEL PUNTO INICIAL (PRIMER AÑO)
  geom_point(data = first_years, # Usa solo la fila del primer año
             aes(colour = kobe_status),
             size = 4, # Tamaño más grande
             shape = 15) + # Forma cuadrada para destacarlo (opcional)
  
  # Trayectoria con flechas
  geom_segment(aes(x = bbmsy, y = ffmsy, xend = lead(bbmsy), yend = lead(ffmsy), colour = kobe_status),
               arrow = arrow(length = unit(0.2,"cm"))) +
  
  # Barras de error horizontales (B/B_MSY) - Último punto
  geom_segment(aes(x = spikobe$bbmsy[last_year_indexs] + tmp11[tmp11$Label=="Bratio_2023","StdDev"],
                   xend = spikobe$bbmsy[last_year_indexs] - tmp11[tmp11$Label=="Bratio_2023","StdDev"],
                   y = spikobe$ffmsy[last_year_indexs], yend = spikobe$ffmsy[last_year_indexs]),
               col = "grey", size = 1) +
  
  # Barras de error verticales (F/F_MSY) - Último punto
  geom_segment(aes(x = spikobe$bbmsy[last_year_indexs], xend = spikobe$bbmsy[last_year_indexs],
                   y = spikobe$ffmsy[last_year_indexs] + tmp11[tmp11$Label=="F_2023","StdDev"],
                   yend = spikobe$ffmsy[last_year_indexs] - tmp11[tmp11$Label=="F_2023","StdDev"]),
               col = "grey", size = 1) +
  
  # Punto final con incertidumbre (en color gris para destacarlo)
  annotate("point", x = spikobe$bbmsy[last_year_indexs], y = spikobe$ffmsy[last_year_indexs], size = 3, shape = 21, fill = "white", colour = "black") +
  
  # REEMPLAZAR geom_text CON ggrepel::geom_text_repel
  geom_text_repel(aes(colour = kobe_status), # Mantiene el color por estado
                  min.segment.length = 0, # Dibuja segmentos hasta el punto
                  size = 3.5,
                  max.overlaps = 3) + # Permite que se procesen todas las etiquetas
  
  # Aplicar los colores manuales y el nombre de la leyenda
  scale_colour_manual(values = kobe_colors, name = "Status of stock") +
  
  # Escalas y títulos
  expand_limits(y = 0, x = c(0, 2.2)) +
  scale_y_continuous(expand = c(0, 0), breaks = seq(0, 3.5, 0.5)) +
  scale_x_continuous(expand = c(0, 0), breaks = seq(0, 2.5, 0.5)) +
  labs(x = expression(B/B[MSY]), y = expression(F/F[MSY])) +
  
  # Temas
  theme_bw() +
  theme(
    panel.grid.major = element_blank(), 
    panel.grid.minor = element_blank(),
    legend.position = "bottom"
  )

# spict with two indexes of abundance from 1986
cpue86<-filter(cpueht2,Year>=1986)

inp2 <- list("timeC"=histi$Year,"obsC"=histi$total)

inp2$timeI<-list("timeI"=cpue86$Year,"timeI"=cpue86$Year)
inp2$obsI<-list()
inp2$obsI[[1]]<-cpue86$hooks
inp2$obsI[[2]]<-cpue86$trawl
inp2$logq <- c(log(0.01),2,0)

inp2$priors$logn <- c(log(1.2), 0.2, 1)
inp2$priors$logbkfrac <- c(log(0.5), 0.1, 1)
inp2$priors$logK <- c(log(max(histi$total)*2),0.6,1)
inp2$priors$logr<- c(log(0.35),0.6, 1)
inp2$priors$logsdc<-c(log(cvct),0.1,0) # process error on catch
inp2$priors$logsdb<-c(log(0.1),0.1,0) # process error on biomass
inp2$priors$logsdi<-c(log(0.2),0.1,0) # observation error on index

# Model
res2 <- fit.spict(inp2)

# Evaluate results

sumspict.parest(res2)

summary(res2)

plot(res2)

# Create data.table for kobe plot
kobeB_spict86 <- data.table(
  Year = res2$inp$timeC,  
  bbmsy = BBmsy_spict_raw[, "est"][as.character(res2$inp$timeC)],
  bbmsyl = BBmsy_spict_raw[, "ll"][as.character(res2$inp$timeC)],
  bbmsyh = BBmsy_spict_raw[, "ul"][as.character(res2$inp$timeC)],
  ffmsy = FFmsy_spict_raw[, "est"][as.character(res2$inp$timeC)],
  ffmsyl = FFmsy_spict_raw[, "ll"][as.character(res2$inp$timeC)],
  ffmsyh = FFmsy_spict_raw[, "ul"][as.character(res2$inp$timeC)]
)

spikobe86 <- kobeB_spict86 %>%
  mutate(
    kobe_status = case_when(
      bbmsy >= 1 & ffmsy <= 1 ~ "Sustainable",  # B > BMSY, F < FMSY
      bbmsy >= 1 & ffmsy > 1 ~ "Overfishing", # B > BMSY, F > FMSY
      bbmsy < 1 & ffmsy <= 1 ~ "Recovery", # B < BMSY, F < FMSY
      bbmsy < 1 & ffmsy > 1 ~ "Overfished" # B < BMSY, F > FMSY
    ),
    # Aseguramos que 'year' sea numérico para la etiqueta
    year = as.numeric(Year)
  )

first_years86 <- spikobe86[1, ]
last_year_indexs86 <- nrow(spikobe86)

tmp8<-data.frame(
  Label=c("Bratio_2023","F_2023"),
  StdDev=c(0.08,0.05)
)

spictk86<-ggplot(data = spikobe86, aes(x = bbmsy, y = ffmsy, label = Year)) +
  
  # Líneas de referencia (BBMSY=1, FFMSY=1)
  geom_hline(yintercept = 1, linetype = "dashed", color = "black") +
  geom_vline(xintercept = 1, linetype = "dashed", color = "black") +
  
  # Puntos (con color asignado por kobe_status)
  geom_point(aes(colour = kobe_status), show.legend = TRUE, size = 2, alpha = 0.7) +
  
  # AUMENTAR TAMAÑO DEL PUNTO INICIAL (PRIMER AÑO)
  geom_point(data = first_years86, # Usa solo la fila del primer año
             aes(colour = kobe_status),
             size = 4, # Tamaño más grande
             shape = 15) + # Forma cuadrada para destacarlo (opcional)
  
  # Trayectoria con flechas
  geom_segment(aes(x = bbmsy, y = ffmsy, xend = lead(bbmsy), yend = lead(ffmsy), colour = kobe_status),
               arrow = arrow(length = unit(0.2,"cm"))) +
  
  # Barras de error horizontales (B/B_MSY) - Último punto
  geom_segment(aes(x = spikobe86$bbmsy[last_year_indexs86] + tmp8[tmp8$Label=="Bratio_2023","StdDev"],
                   xend = spikobe86$bbmsy[last_year_indexs86] - tmp8[tmp8$Label=="Bratio_2023","StdDev"],
                   y = spikobe86$ffmsy[last_year_indexs86], yend = spikobe86$ffmsy[last_year_indexs86]),
               col = "grey", size = 1) +
  
  # Barras de error verticales (F/F_MSY) - Último punto
  geom_segment(aes(x = spikobe86$bbmsy[last_year_indexs86], xend = spikobe86$bbmsy[last_year_indexs86],
                   y = spikobe86$ffmsy[last_year_indexs86] + tmp8[tmp8$Label=="F_2023","StdDev"],
                   yend = spikobe86$ffmsy[last_year_indexs86] - tmp8[tmp8$Label=="F_2023","StdDev"]),
               col = "grey", size = 1) +
  
  # Punto final con incertidumbre (en color gris para destacarlo)
  annotate("point", x = spikobe86$bbmsy[last_year_indexs86], y = spikobe86$ffmsy[last_year_indexs86], size = 3, shape = 21, fill = "white", colour = "black") +
  
  # REEMPLAZAR geom_text CON ggrepel::geom_text_repel
  geom_text_repel(aes(colour = kobe_status), # Mantiene el color por estado
                  min.segment.length = 0, # Dibuja segmentos hasta el punto
                  size = 3.5,
                  max.overlaps = 3) + # Permite que se procesen todas las etiquetas
  
  # Aplicar los colores manuales y el nombre de la leyenda
  scale_colour_manual(values = kobe_colors, name = "Status of stock") +
  
  # Escalas y títulos
  expand_limits(y = 0, x = c(0, 2.2)) +
  scale_y_continuous(expand = c(0, 0), breaks = seq(0, 3.5, 0.5)) +
  scale_x_continuous(expand = c(0, 0), breaks = seq(0, 2.5, 0.5)) +
  labs(x = expression(B/B[MSY]), y = expression(F/F[MSY])) +
  
  # Temas
  theme_bw() +
  theme(
    panel.grid.major = element_blank(), 
    panel.grid.minor = element_blank(),
    legend.position = "bottom"
  )

#-------------------------------------------
# BSM
#-------------------------------------------

# bayesian state-space surplus production model
histx3<-filter(hist,Year>=1982&Year<=2022)

outx<-bsm(year=histx3$Year,catch=histx3$total,biomass=cpuex2$Index,btype="CPUE",
          resilience="Medium",r.low=0.2,r.hi=0.6,stb.low=NA,stb.hi=NA,
          int.yr=NA,intb.low=NA,intb.hi=NA,endb.low=NA,endb.hi=NA,
          q.start=NA,q.end=NA,verbose=TRUE)

plot_dlm(outx)
outx$ref_pt

bareg<-outx$ref_ts

tmp1<-data.frame(
  Label=c("Bratio_2022","F_2022"),
  StdDev=c(0.18,0.17)
)

bsmkob <- ggplot(data = bareg, aes(x = bbmsy, y = ffmsy, colour = year, label = year))+
  geom_rect(aes(xmin = 0, xmax = 1, ymin = 0, ymax = 1), 
            fill="lightgoldenrod1", col = "lightgoldenrod1",alpha = 0.2) +
  geom_rect(aes(xmin = 1, xmax = 2.2, ymin = 1, ymax = 1.75), 
            fill="#FFB960", col = "#FFB960",alpha = 0.2) +
  geom_rect(aes(xmin = 0, xmax = 1, ymin = 1, ymax = 1.75), 
            fill="indianred1", col = "indianred1",alpha = 0.2) +
  geom_rect(aes(xmin = 1, xmax = 2.2, ymin = 0, ymax = 1), 
            fill="palegreen", col = "palegreen",alpha = 0.2) +
  geom_point(show.legend = FALSE, size=2, alpha=0.7) +
  geom_hline(yintercept = 1) +
  geom_vline(xintercept = 1) +
  expand_limits(y = 0, x = c(0, 2.2)) + 
  scale_y_continuous(expand = c(0, 0), breaks = seq(0, 3.5, 0.5)) +
  scale_x_continuous(expand = c(0, 0), breaks = seq(0, 2.5, 0.5)) +
  labs(x = expression(B/B[MSY]), y = expression(F/F[MSY])) +
  scale_colour_gradient(low = "gray60", high = "gray1") +
  #scale_color_gradientn(colours = rainbow(10)) +
  theme(panel.background = element_blank(), 
        panel.border = element_rect(colour = "black", fill=NA),legend.position = "none") + 
  geom_text(hjust=0, vjust=0,check_overlap=TRUE) + 
  geom_segment(aes(x = bbmsy, y = ffmsy, colour = year, xend = lead(bbmsy), 
                   yend = lead(ffmsy)), arrow = arrow(length = unit(0.2,"cm"))) +
  geom_segment(aes(x = bareg$bbmsy[nrow(bareg)] + tmp[tmp$Label=="Bratio_2022","StdDev"], 
                   xend = bareg$bbmsy[nrow(bareg)] - tmp[tmp$Label=="Bratio_2022","StdDev"], 
                   y = bareg$ffmsy[nrow(bareg)], yend = bareg$ffmsy[nrow(bareg)]), col="grey", size=1) +
  geom_segment(aes(x = bareg$bbmsy[nrow(bareg)], xend = bareg$bbmsy[nrow(bareg)], 
                   y = bareg$ffmsy[nrow(bareg)] + tmp[tmp$Label=="F_2022","StdDev"], 
                   yend = bareg$ffmsy[nrow(bareg)] - tmp[tmp$Label=="F_2022","StdDev"]), col="grey", size=1) +
  annotate("point", x = bareg$bbmsy[nrow(bareg)], y = bareg$ffmsy[nrow(bareg)], size=2, colour = "grey")

# test to create colored plot depending on bbmsy and ffmsy values

# 2. Clasificación del estado de Kobe para cada punto
bareg2 <- bareg %>%
  mutate(
    kobe_status = case_when(
      bbmsy >= 1 & ffmsy <= 1 ~ "Sustainable",  # B > BMSY, F < FMSY
      bbmsy >= 1 & ffmsy > 1 ~ "Overfishing", # B > BMSY, F > FMSY
      bbmsy < 1 & ffmsy <= 1 ~ "Recovery", # B < BMSY, F < FMSY
      bbmsy < 1 & ffmsy > 1 ~ "Overfished" # B < BMSY, F > FMSY
    ),
    # Aseguramos que 'year' sea numérico para la etiqueta
    year = as.numeric(year)
  )

# Definir colores manualmente para cada estado
kobe_colors <- c(
  "Sustainable" = "darkgreen", 
  "Overfishing" = "orange",
  "Recovery" = "gold",
  "Overfished" = "red"
)

bsmkob2 <-ggplot(data = bareg2, aes(x = bbmsy, y = ffmsy, label = year)) +
  
  # Líneas de referencia (BBMSY=1, FFMSY=1)
  geom_hline(yintercept = 1, linetype = "dashed", color = "black") +
  geom_vline(xintercept = 1, linetype = "dashed", color = "black") +
  
  # Puntos (con color asignado por kobe_status)
  geom_point(aes(colour = kobe_status), show.legend = TRUE, size = 2, alpha = 0.7) +
  
  # Trayectoria con flechas (con color asignado por kobe_status)
  geom_segment(aes(x = bbmsy, y = ffmsy, xend = lead(bbmsy), yend = lead(ffmsy), colour = kobe_status),
               arrow = arrow(length = unit(0.2,"cm"))) +
  
  # Barras de error horizontales (B/B_MSY) - Último punto
  geom_segment(aes(x = bareg2$bbmsy[nrow(bareg2)] + tmp[tmp$Label=="Bratio_2022","StdDev"],
                   xend = bareg2$bbmsy[nrow(bareg2)] - tmp[tmp$Label=="Bratio_2022","StdDev"],
                   y = bareg2$ffmsy[nrow(bareg2)], yend = bareg2$ffmsy[nrow(bareg2)]),
               col = "grey", size = 1) +
  
  # Barras de error verticales (F/F_MSY) - Último punto
  geom_segment(aes(x = bareg2$bbmsy[nrow(bareg2)], xend = bareg2$bbmsy[nrow(bareg2)],
                   y = bareg2$ffmsy[nrow(bareg2)] + tmp[tmp$Label=="F_2022","StdDev"],
                   yend = bareg2$ffmsy[nrow(bareg2)] - tmp[tmp$Label=="F_2022","StdDev"]),
               col = "grey", size = 1) +
  
  # Punto final con incertidumbre (en color gris para destacarlo)
  annotate("point", x = bareg2$bbmsy[nrow(bareg2)], y = bareg2$ffmsy[nrow(bareg2)], size = 3, shape = 21, fill = "white", colour = "black") +
  
  # Etiquetas de año (con color asignado por kobe_status)
  geom_text(aes(colour = kobe_status), hjust = 0, vjust = 0, check_overlap = TRUE) +
  
  # Aplicar los colores manuales y el nombre de la leyenda
  scale_colour_manual(values = kobe_colors, name = "Status of stock") +
  
  # Escalas y títulos
  expand_limits(y = 0, x = c(0, 2.2)) +
  scale_y_continuous(expand = c(0, 0), breaks = seq(0, 3.5, 0.5)) +
  scale_x_continuous(expand = c(0, 0), breaks = seq(0, 2.5, 0.5)) +
  labs(x = expression(B/B[MSY]), y = expression(F/F[MSY])) +
  
  # Temas
  theme_bw() + # Usamos theme_bw() para un fondo blanco y un estilo limpio
  theme(
    panel.grid.major = element_blank(), 
    panel.grid.minor = element_blank(),
    legend.position = "bottom" # Muestra la leyenda ahora que es informativa
  )

bsmkob|bsmkob2

first_yearb <- bareg2[1, ]
last_year_indexb <- nrow(bareg2)

bsmk<-ggplot(data = bareg2, aes(x = bbmsy, y = ffmsy, label = year)) +
  
  # Líneas de referencia (BBMSY=1, FFMSY=1)
  geom_hline(yintercept = 1, linetype = "dashed", color = "black") +
  geom_vline(xintercept = 1, linetype = "dashed", color = "black") +
  
  # Puntos (con color asignado por kobe_status)
  geom_point(aes(colour = kobe_status), show.legend = TRUE, size = 2, alpha = 0.7) +
  
  # AUMENTAR TAMAÑO DEL PUNTO INICIAL (PRIMER AÑO)
  geom_point(data = first_yearb, # Usa solo la fila del primer año
             aes(colour = kobe_status),
             size = 4, # Tamaño más grande
             shape = 15) + # Forma cuadrada para destacarlo (opcional)
  
  # Trayectoria con flechas
  geom_segment(aes(x = bbmsy, y = ffmsy, xend = lead(bbmsy), yend = lead(ffmsy), colour = kobe_status),
               arrow = arrow(length = unit(0.2,"cm"))) +
  
  # Barras de error horizontales (B/B_MSY) - Último punto
  geom_segment(aes(x = bareg2$bbmsy[last_year_indexb] + tmp1[tmp1$Label=="Bratio_2022","StdDev"],
                   xend = bareg2$bbmsy[last_year_indexb] - tmp1[tmp1$Label=="Bratio_2022","StdDev"],
                   y = bareg2$ffmsy[last_year_indexb], yend = bareg2$ffmsy[last_year_indexb]),
               col = "grey", size = 1) +
  
  # Barras de error verticales (F/F_MSY) - Último punto
  geom_segment(aes(x = bareg2$bbmsy[last_year_indexb], xend = bareg2$bbmsy[last_year_indexb],
                   y = bareg2$ffmsy[last_year_indexb] + tmp1[tmp1$Label=="F_2022","StdDev"],
                   yend = bareg2$ffmsy[last_year_indexb] - tmp1[tmp1$Label=="F_2022","StdDev"]),
               col = "grey", size = 1) +
  
  # Punto final con incertidumbre (en color gris para destacarlo)
  annotate("point", x = bareg2$bbmsy[last_year_indexb], y = bareg2$ffmsy[last_year_indexb], size = 3, shape = 21, fill = "white", colour = "black") +
  
  # REEMPLAZAR geom_text CON ggrepel::geom_text_repel
  geom_text_repel(aes(colour = kobe_status), # Mantiene el color por estado
                  min.segment.length = 0, # Dibuja segmentos hasta el punto
                  size = 3.5,
                  max.overlaps = 3) + # Permite que se procesen todas las etiquetas
  
  # Aplicar los colores manuales y el nombre de la leyenda
  scale_colour_manual(values = kobe_colors, name = "Status of stock") +
  
  # Escalas y títulos
  expand_limits(y = 0, x = c(0, 2.2)) +
  scale_y_continuous(expand = c(0, 0), breaks = seq(0, 3.5, 0.5)) +
  scale_x_continuous(expand = c(0, 0), breaks = seq(0, 2.5, 0.5)) +
  labs(x = expression(B/B[MSY]), y = expression(F/F[MSY])) +
  
  # Temas
  theme_bw() +
  theme(
    panel.grid.major = element_blank(), 
    panel.grid.minor = element_blank(),
    legend.position = "bottom"
  )

# bsm from 1986 as imipas and others
histx4<-filter(hist,Year>=1986&Year<=2022)
cpuex5<-filter(cpuex2,Year>=1986)

outx2<-bsm(year=histx4$Year,catch=histx4$total,biomass=cpuex5$Index,btype="CPUE",
           resilience="Medium",r.low=0.2,r.hi=0.6,stb.low=NA,stb.hi=NA,
           int.yr=NA,intb.low=NA,intb.hi=NA,endb.low=NA,endb.hi=NA,
           q.start=NA,q.end=NA,verbose=TRUE)

plot_dlm(outx2)
outx2$ref_pt

ba86<-outx2$ref_ts

tmp6<-data.frame(
  Label=c("Bratio_2022","F_2022"),
  StdDev=c(0.18,0.17)
)


ba862 <- ba86 %>%
  mutate(
    kobe_status = case_when(
      bbmsy >= 1 & ffmsy <= 1 ~ "Sustainable",  # B > BMSY, F < FMSY
      bbmsy >= 1 & ffmsy > 1 ~ "Overfishing", # B > BMSY, F > FMSY
      bbmsy < 1 & ffmsy <= 1 ~ "Recovery", # B < BMSY, F < FMSY
      bbmsy < 1 & ffmsy > 1 ~ "Overfished" # B < BMSY, F > FMSY
    ),
    # Aseguramos que 'year' sea numérico para la etiqueta
    year = as.numeric(year)
  )

first_yearb8 <- ba862[1, ]
last_year_indexb8 <- nrow(ba862)

bsm86k<-ggplot(data = ba862, aes(x = bbmsy, y = ffmsy, label = year)) +
  
  # Líneas de referencia (BBMSY=1, FFMSY=1)
  geom_hline(yintercept = 1, linetype = "dashed", color = "black") +
  geom_vline(xintercept = 1, linetype = "dashed", color = "black") +
  
  # Puntos (con color asignado por kobe_status)
  geom_point(aes(colour = kobe_status), show.legend = TRUE, size = 2, alpha = 0.7) +
  
  # AUMENTAR TAMAÑO DEL PUNTO INICIAL (PRIMER AÑO)
  geom_point(data = first_yearb8, # Usa solo la fila del primer año
             aes(colour = kobe_status),
             size = 4, # Tamaño más grande
             shape = 15) + # Forma cuadrada para destacarlo (opcional)
  
  # Trayectoria con flechas
  geom_segment(aes(x = bbmsy, y = ffmsy, xend = lead(bbmsy), yend = lead(ffmsy), colour = kobe_status),
               arrow = arrow(length = unit(0.2,"cm"))) +
  
  # Barras de error horizontales (B/B_MSY) - Último punto
  geom_segment(aes(x = ba862$bbmsy[last_year_indexb8] + tmp6[tmp6$Label=="Bratio_2022","StdDev"],
                   xend = ba862$bbmsy[last_year_indexb8] - tmp6[tmp6$Label=="Bratio_2022","StdDev"],
                   y = ba862$ffmsy[last_year_indexb8], yend = ba862$ffmsy[last_year_indexb8]),
               col = "grey", size = 1) +
  
  # Barras de error verticales (F/F_MSY) - Último punto
  geom_segment(aes(x = ba862$bbmsy[last_year_indexb8], xend = ba862$bbmsy[last_year_indexb8],
                   y = ba862$ffmsy[last_year_indexb8] + tmp6[tmp6$Label=="F_2022","StdDev"],
                   yend = ba862$ffmsy[last_year_indexb8] - tmp6[tmp6$Label=="F_2022","StdDev"]),
               col = "grey", size = 1) +
  
  # Punto final con incertidumbre (en color gris para destacarlo)
  annotate("point", x = ba862$bbmsy[last_year_indexb8], y = ba862$ffmsy[last_year_indexb8], size = 3, shape = 21, fill = "white", colour = "black") +
  
  # REEMPLAZAR geom_text CON ggrepel::geom_text_repel
  geom_text_repel(aes(colour = kobe_status), # Mantiene el color por estado
                  min.segment.length = 0, # Dibuja segmentos hasta el punto
                  size = 3.5,
                  max.overlaps = 3) + # Permite que se procesen todas las etiquetas
  
  # Aplicar los colores manuales y el nombre de la leyenda
  scale_colour_manual(values = kobe_colors, name = "Status of stock") +
  
  # Escalas y títulos
  expand_limits(y = 0, x = c(0, 2.2)) +
  scale_y_continuous(expand = c(0, 0), breaks = seq(0, 3.5, 0.5)) +
  scale_x_continuous(expand = c(0, 0), breaks = seq(0, 2.5, 0.5)) +
  labs(x = expression(B/B[MSY]), y = expression(F/F[MSY])) +
  
  # Temas
  theme_bw() +
  theme(
    panel.grid.major = element_blank(), 
    panel.grid.minor = element_blank(),
    legend.position = "bottom"
  )

#-----------------------------------------------------------------------------
# CMSY & BSM for red grouper results comparison
#-----------------------------------------------------------------------------

library(datalimited2)
mery<-filter(conmero,species%in%c("Epinephelus morio"))
meroy<-aggregate(mery$ton,by=list(mery$ANO.CORTE),sum)
names(meroy)<-c("year","ton")


# cmsy Froese 2017, no info on anything but "resilience" and catch arribos 00-23
out<-cmsy2(year=meroy$year,catch=meroy$ton,resilience="Low",
           r.low=0.37,r.hi=0.49,stb.low=NA,stb.hi=NA,
           int.yr=NA,intb.low=NA,intb.hi=NA,endb.low=NA,endb.hi=NA,verbose=TRUE)

plot_dlm(out)
out$ref_pts

# with r from previous spict and sra analysis
out1<-cmsy2(year=meroy$year,catch=meroy$ton,resilience="Medium",
            r.low=0.128,r.hi=1.17,stb.low=NA,stb.hi=NA,
            int.yr=NA,intb.low=NA,intb.hi=NA,endb.low=NA,endb.hi=NA,verbose=TRUE)

plot_dlm(out1)
out1$ref_pts

# historical catches as with SS3 (1950-2023)
hist<-read.csv("C:/Kraken/MeroPYuc/SS3_Input_data/catchess3_4flt_new.csv",sep=",",header=TRUE)
hist$total<-hist$Fleet_1+hist$Fleet_2+hist$Fleet_3+hist$Fleet_4

out3<-cmsy2(year=hist$Year,catch=hist$total,resilience="Medium",
            r.low=0.1,r.hi=0.6,stb.low=NA,stb.hi=NA,
            int.yr=NA,intb.low=NA,intb.hi=NA,endb.low=NA,endb.hi=NA,verbose=TRUE)

plot_dlm(out3)
out3$ref_pts
cmsyfull<-out3$ref_ts

# for new kobe plot (review 2)

cmsyfull2 <- cmsyfull %>%
  mutate(
    kobe_status = case_when(
      bbmsy >= 1 & ffmsy <= 1 ~ "Sustainable",  # B > BMSY, F < FMSY
      bbmsy >= 1 & ffmsy > 1 ~ "Overfishing", # B > BMSY, F > FMSY
      bbmsy < 1 & ffmsy <= 1 ~ "Recovery", # B < BMSY, F < FMSY
      bbmsy < 1 & ffmsy > 1 ~ "Overfished" # B < BMSY, F > FMSY
    ),
    # Aseguramos que 'year' sea numérico para la etiqueta
    year = as.numeric(year)
  )

first_yearc <- cmsyfull2[1, ]
last_year_indexc <- nrow(cmsyfull2)

tmp2<-data.frame(
  Label=c("Bratio_2023","F_2023"),
  StdDev=c(0.10,0.10)
)

cmsyflk<-ggplot(data = cmsyfull2, aes(x = bbmsy, y = ffmsy, label = year)) +
  
  # Líneas de referencia (BBMSY=1, FFMSY=1)
  geom_hline(yintercept = 1, linetype = "dashed", color = "black") +
  geom_vline(xintercept = 1, linetype = "dashed", color = "black") +
  
  # Puntos (con color asignado por kobe_status)
  geom_point(aes(colour = kobe_status), show.legend = TRUE, size = 2, alpha = 0.7) +
  
  # AUMENTAR TAMAÑO DEL PUNTO INICIAL (PRIMER AÑO)
  geom_point(data = first_yearc, # Usa solo la fila del primer año
             aes(colour = kobe_status),
             size = 4, # Tamaño más grande
             shape = 15) + # Forma cuadrada para destacarlo (opcional)
  
  # Trayectoria con flechas
  geom_segment(aes(x = bbmsy, y = ffmsy, xend = lead(bbmsy), yend = lead(ffmsy), colour = kobe_status),
               arrow = arrow(length = unit(0.2,"cm"))) +
  
  # Barras de error horizontales (B/B_MSY) - Último punto
  geom_segment(aes(x = cmsyfull2$bbmsy[last_year_indexc] + tmp2[tmp2$Label=="Bratio_2023","StdDev"],
                   xend = cmsyfull2$bbmsy[last_year_indexc] - tmp2[tmp2$Label=="Bratio_2023","StdDev"],
                   y = cmsyfull2$ffmsy[last_year_indexc], yend = cmsyfull2$ffmsy[last_year_indexc]),
               col = "grey", size = 1) +
  
  # Barras de error verticales (F/F_MSY) - Último punto
  geom_segment(aes(x = cmsyfull2$bbmsy[last_year_indexc], xend = cmsyfull2$bbmsy[last_year_indexc],
                   y = cmsyfull2$ffmsy[last_year_indexc] + tmp2[tmp2$Label=="F_2023","StdDev"],
                   yend = cmsyfull2$ffmsy[last_year_indexc] - tmp2[tmp2$Label=="F_2023","StdDev"]),
               col = "grey", size = 1) +
  
  # Punto final con incertidumbre (en color gris para destacarlo)
  annotate("point", x = cmsyfull2$bbmsy[last_year_indexc], y = cmsyfull2$ffmsy[last_year_indexc], size = 3, shape = 21, fill = "white", colour = "black") +
  
  # REEMPLAZAR geom_text CON ggrepel::geom_text_repel
  geom_text_repel(aes(colour = kobe_status), # Mantiene el color por estado
                  min.segment.length = 0, # Dibuja segmentos hasta el punto
                  size = 3.5,
                  max.overlaps = 3) + # Permite que se procesen todas las etiquetas
  
  # Aplicar los colores manuales y el nombre de la leyenda
  scale_colour_manual(values = kobe_colors, name = "Status of stock") +
  
  # Escalas y títulos
  expand_limits(y = 0, x = c(0, 2.2)) +
  scale_y_continuous(expand = c(0, 0), breaks = seq(0, 3.5, 0.5)) +
  scale_x_continuous(expand = c(0, 0), breaks = seq(0, 2.5, 0.5)) +
  labs(x = expression(B/B[MSY]), y = expression(F/F[MSY])) +
  
  # Temas
  theme_bw() +
  theme(
    panel.grid.major = element_blank(), 
    panel.grid.minor = element_blank(),
    legend.position = "bottom"
  )

# historical catches as IMIPAS (1986->)
histi<-filter(hist,Year>=1986)
out4<-cmsy2(year=histi$Year,catch=histi$total,resilience="Medium",
            r.low=NA,r.hi=NA,stb.low=NA,stb.hi=NA,
            int.yr=NA,intb.low=NA,intb.hi=NA,endb.low=NA,endb.hi=NA,verbose=TRUE)

plot_dlm(out4)
out4$ref_pts
cmsy86<-out4$ref_ts

cmsy862 <- cmsy86 %>%
  mutate(
    kobe_status = case_when(
      bbmsy >= 1 & ffmsy <= 1 ~ "Sustainable",  # B > BMSY, F < FMSY
      bbmsy >= 1 & ffmsy > 1 ~ "Overfishing", # B > BMSY, F > FMSY
      bbmsy < 1 & ffmsy <= 1 ~ "Recovery", # B < BMSY, F < FMSY
      bbmsy < 1 & ffmsy > 1 ~ "Overfished" # B < BMSY, F > FMSY
    ),
    # Aseguramos que 'year' sea numérico para la etiqueta
    year = as.numeric(year)
  )

first_yearc8 <- cmsy862[1, ]
last_year_indexc8 <- nrow(cmsy862)

tmp3<-data.frame(
  Label=c("Bratio_2023","F_2023"),
  StdDev=c(0.10,0.10)
)

cmsy86k<-ggplot(data = cmsy862, aes(x = bbmsy, y = ffmsy, label = year)) +
  
  # Líneas de referencia (BBMSY=1, FFMSY=1)
  geom_hline(yintercept = 1, linetype = "dashed", color = "black") +
  geom_vline(xintercept = 1, linetype = "dashed", color = "black") +
  
  # Puntos (con color asignado por kobe_status)
  geom_point(aes(colour = kobe_status), show.legend = TRUE, size = 2, alpha = 0.7) +
  
  # AUMENTAR TAMAÑO DEL PUNTO INICIAL (PRIMER AÑO)
  geom_point(data = first_yearc8, # Usa solo la fila del primer año
             aes(colour = kobe_status),
             size = 4, # Tamaño más grande
             shape = 15) + # Forma cuadrada para destacarlo (opcional)
  
  # Trayectoria con flechas
  geom_segment(aes(x = bbmsy, y = ffmsy, xend = lead(bbmsy), yend = lead(ffmsy), colour = kobe_status),
               arrow = arrow(length = unit(0.2,"cm"))) +
  
  # Barras de error horizontales (B/B_MSY) - Último punto
  geom_segment(aes(x = cmsy862$bbmsy[last_year_indexc8] + tmp3[tmp3$Label=="Bratio_2023","StdDev"],
                   xend = cmsy862$bbmsy[last_year_indexc8] - tmp3[tmp3$Label=="Bratio_2023","StdDev"],
                   y = cmsy862$ffmsy[last_year_indexc8], yend = cmsy862$ffmsy[last_year_indexc8]),
               col = "grey", size = 1) +
  
  # Barras de error verticales (F/F_MSY) - Último punto
  geom_segment(aes(x = cmsy862$bbmsy[last_year_indexc8], xend = cmsy862$bbmsy[last_year_indexc8],
                   y = cmsy862$ffmsy[last_year_indexc8] + tmp3[tmp3$Label=="F_2023","StdDev"],
                   yend = cmsy862$ffmsy[last_year_indexc8] - tmp3[tmp3$Label=="F_2023","StdDev"]),
               col = "grey", size = 1) +
  
  # Punto final con incertidumbre (en color gris para destacarlo)
  annotate("point", x = cmsy862$bbmsy[last_year_indexc8], y = cmsy862$ffmsy[last_year_indexc8], size = 3, shape = 21, fill = "white", colour = "black") +
  
  # REEMPLAZAR geom_text CON ggrepel::geom_text_repel
  geom_text_repel(aes(colour = kobe_status), # Mantiene el color por estado
                  min.segment.length = 0, # Dibuja segmentos hasta el punto
                  size = 3.5,
                  max.overlaps = 3) + # Permite que se procesen todas las etiquetas
  
  # Aplicar los colores manuales y el nombre de la leyenda
  scale_colour_manual(values = kobe_colors, name = "Status of stock") +
  
  # Escalas y títulos
  expand_limits(y = 0, x = c(0, 2.2)) +
  scale_y_continuous(expand = c(0, 0), breaks = seq(0, 3.5, 0.5)) +
  scale_x_continuous(expand = c(0, 0), breaks = seq(0, 2.5, 0.5)) +
  labs(x = expression(B/B[MSY]), y = expression(F/F[MSY])) +
  
  # Temas
  theme_bw() +
  theme(
    panel.grid.major = element_blank(), 
    panel.grid.minor = element_blank(),
    legend.position = "bottom"
  )

# bayesian state-space surplus production model

out2<-bsm(year=meroy$year,catch=meroy$ton,biomass=mysum2$CPUE,btype="CPUE",
          resilience="Medium",r.low=NA,r.hi=NA,stb.low=NA,stb.hi=NA,
          int.yr=NA,intb.low=NA,intb.hi=NA,endb.low=NA,endb.hi=NA,
          q.start=NA,q.end=NA,verbose=TRUE)

plot_dlm(out2)
out2$ref_pt


# Optimized catch only model (ocom) Zhou et al 2017 

out5<-ocom(year=hist$Year,catch=hist$total,m=0.2)
out6<-ocom(year=histi$Year,catch=histi$total,m=0.2)
plot_dlm(out5)
out5$ref_pt
out5$ref_ts
ocomres<-out5$ref_ts
ocomres86<-out6$ref_ts #run with histi dataframe

ocomres2 <- ocomres %>%
  mutate(
    kobe_status = case_when(
      bbmsy >= 1 & ffmsy <= 1 ~ "Sustainable",  # B > BMSY, F < FMSY
      bbmsy >= 1 & ffmsy > 1 ~ "Overfishing", # B > BMSY, F > FMSY
      bbmsy < 1 & ffmsy <= 1 ~ "Recovery", # B < BMSY, F < FMSY
      bbmsy < 1 & ffmsy > 1 ~ "Overfished" # B < BMSY, F > FMSY
    ),
    # Aseguramos que 'year' sea numérico para la etiqueta
    year = as.numeric(year)
  )

first_yearo <- ocomres2[1, ]
last_year_indexo <- nrow(ocomres2)

tmp4<-data.frame(
  Label=c("Bratio_2023","F_2023"),
  StdDev=c(0.10,0.10)
)

ocomk<-ggplot(data = ocomres2, aes(x = bbmsy, y = ffmsy, label = year)) +
  
  # Líneas de referencia (BBMSY=1, FFMSY=1)
  geom_hline(yintercept = 1, linetype = "dashed", color = "black") +
  geom_vline(xintercept = 1, linetype = "dashed", color = "black") +
  
  # Puntos (con color asignado por kobe_status)
  geom_point(aes(colour = kobe_status), show.legend = TRUE, size = 2, alpha = 0.7) +
  
  # AUMENTAR TAMAÑO DEL PUNTO INICIAL (PRIMER AÑO)
  geom_point(data = first_yearo, # Usa solo la fila del primer año
             aes(colour = kobe_status),
             size = 4, # Tamaño más grande
             shape = 15) + # Forma cuadrada para destacarlo (opcional)
  
  # Trayectoria con flechas
  geom_segment(aes(x = bbmsy, y = ffmsy, xend = lead(bbmsy), yend = lead(ffmsy), colour = kobe_status),
               arrow = arrow(length = unit(0.2,"cm"))) +
  
  # Barras de error horizontales (B/B_MSY) - Último punto
  geom_segment(aes(x = ocomres2$bbmsy[last_year_indexo] + tmp4[tmp4$Label=="Bratio_2023","StdDev"],
                   xend = ocomres2$bbmsy[last_year_indexo] - tmp4[tmp4$Label=="Bratio_2023","StdDev"],
                   y = ocomres2$ffmsy[last_year_indexo], yend = ocomres2$ffmsy[last_year_indexo]),
               col = "grey", size = 1) +
  
  # Barras de error verticales (F/F_MSY) - Último punto
  geom_segment(aes(x = ocomres2$bbmsy[last_year_indexo], xend = ocomres2$bbmsy[last_year_indexo],
                   y = ocomres2$ffmsy[last_year_indexo] + tmp4[tmp4$Label=="F_2023","StdDev"],
                   yend = ocomres2$ffmsy[last_year_indexo] - tmp4[tmp4$Label=="F_2023","StdDev"]),
               col = "grey", size = 1) +
  
  # Punto final con incertidumbre (en color gris para destacarlo)
  annotate("point", x = ocomres2$bbmsy[last_year_indexo], y = ocomres2$ffmsy[last_year_indexo], size = 3, shape = 21, fill = "white", colour = "black") +
  
  # REEMPLAZAR geom_text CON ggrepel::geom_text_repel
  geom_text_repel(aes(colour = kobe_status), # Mantiene el color por estado
                  min.segment.length = 0, # Dibuja segmentos hasta el punto
                  size = 3.5,
                  max.overlaps = 3) + # Permite que se procesen todas las etiquetas
  
  # Aplicar los colores manuales y el nombre de la leyenda
  scale_colour_manual(values = kobe_colors, name = "Status of stock") +
  
  # Escalas y títulos
  expand_limits(y = 0, x = c(0, 2.2)) +
  scale_y_continuous(expand = c(0, 0), breaks = seq(0, 3.5, 0.5)) +
  scale_x_continuous(expand = c(0, 0), breaks = seq(0, 2.5, 0.5)) +
  labs(x = expression(B/B[MSY]), y = expression(F/F[MSY])) +
  
  # Temas
  theme_bw() +
  theme(
    panel.grid.major = element_blank(), 
    panel.grid.minor = element_blank(),
    legend.position = "bottom"
  )


ocomres862 <- ocomres86 %>%
  mutate(
    kobe_status = case_when(
      bbmsy >= 1 & ffmsy <= 1 ~ "Sustainable",  # B > BMSY, F < FMSY
      bbmsy >= 1 & ffmsy > 1 ~ "Overfishing", # B > BMSY, F > FMSY
      bbmsy < 1 & ffmsy <= 1 ~ "Recovery", # B < BMSY, F < FMSY
      bbmsy < 1 & ffmsy > 1 ~ "Overfished" # B < BMSY, F > FMSY
    ),
    # Aseguramos que 'year' sea numérico para la etiqueta
    year = as.numeric(year)
  )

first_yearo8 <- ocomres862[1, ]
last_year_indexo8 <- nrow(ocomres862)

tmp5<-data.frame(
  Label=c("Bratio_2023","F_2023"),
  StdDev=c(0.10,0.10)
)

ocomk86<-ggplot(data = ocomres862, aes(x = bbmsy, y = ffmsy, label = year)) +
  
  # Líneas de referencia (BBMSY=1, FFMSY=1)
  geom_hline(yintercept = 1, linetype = "dashed", color = "black") +
  geom_vline(xintercept = 1, linetype = "dashed", color = "black") +
  
  # Puntos (con color asignado por kobe_status)
  geom_point(aes(colour = kobe_status), show.legend = TRUE, size = 2, alpha = 0.7) +
  
  # AUMENTAR TAMAÑO DEL PUNTO INICIAL (PRIMER AÑO)
  geom_point(data = first_yearo8, # Usa solo la fila del primer año
             aes(colour = kobe_status),
             size = 4, # Tamaño más grande
             shape = 15) + # Forma cuadrada para destacarlo (opcional)
  
  # Trayectoria con flechas
  geom_segment(aes(x = bbmsy, y = ffmsy, xend = lead(bbmsy), yend = lead(ffmsy), colour = kobe_status),
               arrow = arrow(length = unit(0.2,"cm"))) +
  
  # Barras de error horizontales (B/B_MSY) - Último punto
  geom_segment(aes(x = ocomres862$bbmsy[last_year_indexo8] + tmp5[tmp5$Label=="Bratio_2023","StdDev"],
                   xend = ocomres862$bbmsy[last_year_indexo8] - tmp5[tmp5$Label=="Bratio_2023","StdDev"],
                   y = ocomres862$ffmsy[last_year_indexo8], yend = ocomres862$ffmsy[last_year_indexo8]),
               col = "grey", size = 1) +
  
  # Barras de error verticales (F/F_MSY) - Último punto
  geom_segment(aes(x = ocomres862$bbmsy[last_year_indexo8], xend = ocomres862$bbmsy[last_year_indexo8],
                   y = ocomres862$ffmsy[last_year_indexo8] + tmp5[tmp5$Label=="F_2023","StdDev"],
                   yend = ocomres862$ffmsy[last_year_indexo8] - tmp5[tmp5$Label=="F_2023","StdDev"]),
               col = "grey", size = 1) +
  
  # Punto final con incertidumbre (en color gris para destacarlo)
  annotate("point", x = ocomres862$bbmsy[last_year_indexo8], y = ocomres862$ffmsy[last_year_indexo8], size = 3, shape = 21, fill = "white", colour = "black") +
  
  # REEMPLAZAR geom_text CON ggrepel::geom_text_repel
  geom_text_repel(aes(colour = kobe_status), # Mantiene el color por estado
                  min.segment.length = 0, # Dibuja segmentos hasta el punto
                  size = 3.5,
                  max.overlaps = 3) + # Permite que se procesen todas las etiquetas
  
  # Aplicar los colores manuales y el nombre de la leyenda
  scale_colour_manual(values = kobe_colors, name = "Status of stock") +
  
  # Escalas y títulos
  expand_limits(y = 0, x = c(0, 2.2)) +
  scale_y_continuous(expand = c(0, 0), breaks = seq(0, 3.5, 0.5)) +
  scale_x_continuous(expand = c(0, 0), breaks = seq(0, 2.5, 0.5)) +
  labs(x = expression(B/B[MSY]), y = expression(F/F[MSY])) +
  
  # Temas
  theme_bw() +
  theme(
    panel.grid.major = element_blank(), 
    panel.grid.minor = element_blank(),
    legend.position = "bottom"
  )

#-------------------------------------------------
# IMIPAS National fisheries act 2022 kobe plot
#-------------------------------------------------

imipask<-c()
imipask$year<-c(seq(1986,2020,by=1))
imipask$bbmsy<-c(2,1.75,1.55,1.35,1.25,1.2,0.98,0.88,0.82,0.76,0.66,0.64,0.62,0.6,
                 0.57,0.59,0.6,0.64,0.64,0.68,0.7,0.68,0.58,0.56,0.52,0.56,0.57,
                 0.5,0.46,0.48,0.44,0.44,0.42,0.44,0.5)
imipask$ffmsy<-c(0.62,0.88,1.1,1.08,1.2,1.44,1.5,1.42,1.64,1.78,1.32,1.1,1.3,1.08,1.22,
                 1.62,1.42,1.76,1.44,1.38,1.3,1.52,1.62,1.86,1.6,1.28,1.96,1.84,1.42,
                 1.76,1.6,1.56,1.34,1.38,1.26)
imipask<-as.data.frame(imipask)

imipask2 <- imipask %>%
  mutate(
    kobe_status = case_when(
      bbmsy >= 1 & ffmsy <= 1 ~ "Sustainable",  # B > BMSY, F < FMSY
      bbmsy >= 1 & ffmsy > 1 ~ "Overfishing", # B > BMSY, F > FMSY
      bbmsy < 1 & ffmsy <= 1 ~ "Recovery", # B < BMSY, F < FMSY
      bbmsy < 1 & ffmsy > 1 ~ "Overfished" # B < BMSY, F > FMSY
    ),
    # Aseguramos que 'year' sea numérico para la etiqueta
    year = as.numeric(year)
  )

first_yeari <- imipask2[1, ]
last_year_indexi <- nrow(imipask2)

tmp7<-data.frame(
  Label=c("Bratio_2020","F_2020"),
  StdDev=c(0.15,0.15)
)

imik2<-ggplot(data = imipask2, aes(x = bbmsy, y = ffmsy, label = year)) +
  
  # Líneas de referencia (BBMSY=1, FFMSY=1)
  geom_hline(yintercept = 1, linetype = "dashed", color = "black") +
  geom_vline(xintercept = 1, linetype = "dashed", color = "black") +
  
  # Puntos (con color asignado por kobe_status)
  geom_point(aes(colour = kobe_status), show.legend = TRUE, size = 2, alpha = 0.7) +
  
  # AUMENTAR TAMAÑO DEL PUNTO INICIAL (PRIMER AÑO)
  geom_point(data = first_yeari, # Usa solo la fila del primer año
             aes(colour = kobe_status),
             size = 4, # Tamaño más grande
             shape = 15) + # Forma cuadrada para destacarlo (opcional)
  
  # Trayectoria con flechas
  geom_segment(aes(x = bbmsy, y = ffmsy, xend = lead(bbmsy), yend = lead(ffmsy), colour = kobe_status),
               arrow = arrow(length = unit(0.2,"cm"))) +
  
  # Barras de error horizontales (B/B_MSY) - Último punto
  geom_segment(aes(x = imipask2$bbmsy[last_year_indexi] + tmp7[tmp7$Label=="Bratio_2020","StdDev"],
                   xend = imipask2$bbmsy[last_year_indexi] - tmp7[tmp7$Label=="Bratio_2020","StdDev"],
                   y = imipask2$ffmsy[last_year_indexi], yend = imipask2$ffmsy[last_year_indexi]),
               col = "grey", size = 1) +
  
  # Barras de error verticales (F/F_MSY) - Último punto
  geom_segment(aes(x = imipask2$bbmsy[last_year_indexi], xend = imipask2$bbmsy[last_year_indexi],
                   y = imipask2$ffmsy[last_year_indexi] + tmp7[tmp7$Label=="F_2020","StdDev"],
                   yend = imipask2$ffmsy[last_year_indexi] - tmp7[tmp7$Label=="F_2020","StdDev"]),
               col = "grey", size = 1) +
  
  # Punto final con incertidumbre (en color gris para destacarlo)
  annotate("point", x = imipask2$bbmsy[last_year_indexi], y = imipask2$ffmsy[last_year_indexi], size = 3, shape = 21, fill = "white", colour = "black") +
  
  # REEMPLAZAR geom_text CON ggrepel::geom_text_repel
  geom_text_repel(aes(colour = kobe_status), # Mantiene el color por estado
                  min.segment.length = 0, # Dibuja segmentos hasta el punto
                  size = 3.5,
                  max.overlaps = 3) + # Permite que se procesen todas las etiquetas
  
  # Aplicar los colores manuales y el nombre de la leyenda
  scale_colour_manual(values = kobe_colors, name = "Status of stock") +
  
  # Escalas y títulos
  expand_limits(y = 0, x = c(0, 2.2)) +
  scale_y_continuous(expand = c(0, 0), breaks = seq(0, 3.5, 0.5)) +
  scale_x_continuous(expand = c(0, 0), breaks = seq(0, 2.5, 0.5)) +
  labs(x = expression(B/B[MSY]), y = expression(F/F[MSY])) +
  
  # Temas
  theme_bw() +
  theme(
    panel.grid.major = element_blank(), 
    panel.grid.minor = element_blank(),
    legend.position = "bottom"
  )

#------------------------------------
# all new plots for review 2
#------------------------------------

ggarrange(bestssk,imik2,spictk,spictk86,bsmk,bsm86k,cmsyflk,cmsy86k,ocomk,ocomk86,align="hv",ncol=2,nrow=5,common.legend=TRUE)