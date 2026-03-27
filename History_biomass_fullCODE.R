#-------------------------------------------------------------------------
# biomass trend meta-analysis
#-------------------------------------------------------------------------

bioss<-read.csv("biometa.csv",sep=",",header=TRUE)

head(bioss)

bioss2<-bioss%>%
  pivot_longer(cols=-year,names_to="quant.author",values_to="ton")

# add faceting factor for nice plot
bioss2<-bioss2%>%
  mutate(Category=case_when(
    startsWith(quant.author,"B..")~"Estimated biomass",
    grepl("MSY",quant.author)~ "MSY",
    grepl("SSB",quant.author)~ "Estimated biomass",
    TRUE~"Total catch"
  ))

nmlst<-list(
  "B..Arreguin.Sanchez..1987."="Arreguin-Sanchez (1987)",           
  "B..Blanco.et.al...1980."="Blanco et al (1980)",              
  "B..Buesa..1978."="Buesa (1978)",                      
  "B..Burgos.et.al...1999."="Burgos et al (1999)",              
  "B..Burgos.Rosas.y.Perez.Perez..2006."="Burgos-Rosas & Perez-Perez (2006)",
  "B..Contreras.et.al...1993."="Contreras et al (1993)",           
  "B..Doi.et.al...1981."="Doi et al (1981)",                 
  "B..Fuentes.y.Contreras..1986."="Fuentes & Contreras (1986)",        
  "B..Garcia.et.al...1986."="Garcia et al (1986)",              
  "B..Gimenez.Hurtado.et.al...2005."="Gimenez-Hurtado et al (2005)",     
  "B..Gonzalez.et.al...1974a."="Gonzalez et al (1974a)",           
  "B..Gonzalez.et.al...1974b."="Gonzalez et al (1974b)",           
  "B..Hernandez.et.al...1999."="Hernandez et al (1999)",           
  "B..Hernandez.et.al...2010."="Hernandez et al (2010)",           
  "B..Klima..1976."="Klima (1976)",                      
  "B..Monroy..1998."="Monroy-Garcia (1998)",                     
  "B..Monroy.Garcia.et.al...2013."="Monroy-Garcia et al (2013)",       
  "B..Moreno.et.al...1991."="Moreno et al (1991)",              
  "B..Moreno.et.al...1995."="Moreno et al (1995)",              
  "B..Moreno.et.al...1997."="Moreno et al (1997)",              
  "B..present.study"="Present study (Stock biomass)",                     
  "B..Seijo..1986."="Seijo (1986)",                      
  "B..Valdes.et.al...1989."="Valdes et al (1989)",
  "B..Echazabal.Salazar.et.al...2021."="Echazaba-Salazar et al (2021)",
  "MSY.Arreguin.Sanchez..1987."="Arreguin-Sanchez (1987)",                    
  "MSY.Blanco.et.al...1980."="Blanco et al (1980)",             
  "MSY.Buesa..1978."="Buesa (1978)",                     
  "MSY.Burgos.et.al...1999."="Burgos et al (1999)",             
  "MSY.Burgos.Rosas.y.Perez.Perez..2006."="Burgos-Rosas & Perez-Perez (2006)",
  "MSY.Contreras.et.al...1993."="Contreras et al (1993)",          
  "MSY.Doi.et.al...1981."="Doi et al (1981)",                
  "MSY.Fuentes.y.Contreras..1986."="Fuentes & Contreras (1986)",       
  "MSY.Garcia.et.al...1986."="Garcia et al (1986)",             
  "MSY.Gimenez.Hurtado.et.al...2005."="Gimenez-Hurtado et al (2005)",    
  "MSY.Gonzalez.et.al...1974a."="Gonzalez et al (1974a)",                     
  "MSY.Gonzalez.et.al...1974b."="Gonzalez et al (1974b)",                     
  "MSY.Hernandez.et.al...1999."="Hernandez et al (1999)",                     
  "MSY.Hernandez.et.al...2010."="Hernandez et al (2010)",                     
  "MSY.Klima..1976."="Klima (1976)",                                           
  "MSY.Monroy..1998."="Monroy-Garcia (1998)",                                         
  "MSY.Monroy.Garcia.et.al...2013."="Monroy-Garcia et al (2013)",             
  "MSY.Moreno.et.al...1991."="Moreno et al (1991)",                           
  "MSY.Moreno.et.al...1995."="Moreno et al (1995)",                           
  "MSY.Moreno.et.al...1997."="Moreno et al (1997)",                           
  "MSY.present.study"="Present study (MSY)",                    
  "MSY.Seijo..1986."="Seijo (1986)",                                           
  "MSY.Valdes.et.al...1989."="Valdes et al (1989)",
  "MSY.Echazabal.Salazar.et.al...2021."="Echazaba-Salazar et al (2021)",
  "SSB..present.study"="Present study (Spawning stock biomass)",                   
  "total.catch"="Total catch"
)

bioss2$author<-"no text"
maval<-match(as.character(bioss2$quant.author),names(nmlst))
bioss2$author[!is.na(maval)]<-unlist(nmlst)[maval[!is.na(maval)]]

bioss2$source<-as.factor(ifelse(bioss2$author=="Present study (MSY)",
                                "Present study",
                                ifelse(bioss2$author=="Present study (Stock biomass)","Present study",
                                       ifelse(bioss2$author=="Present study (Spawning stock biomass)",
                                              "Present study",ifelse(bioss2$author=="Total catch",
                                                                     "Present study","Past studies")))))

ct<-filter(bioss2,Category=="Total catch")
bioss2<-filter(bioss2,Category!="Total catch")

bioss2$author<-factor(bioss2$author,levels=c(
  "Gonzalez et al (1974a)",                
  "Gonzalez et al (1974b)",                
  "Klima (1976)",                          
  "Buesa (1978)",                          
  "Blanco et al (1980)",                   
  "Doi et al (1981)",                      
  "Seijo (1986)",                          
  "Garcia et al (1986)",                   
  "Fuentes & Contreras (1986)",            
  "Arreguin-Sanchez (1987)",
  "Valdes et al (1989)",                   
  "Moreno et al (1991)",                   
  "Contreras et al (1993)",                
  "Moreno et al (1995)",
  "Moreno et al (1997)",
  "Monroy-Garcia (1998)",                  
  "Burgos et al (1999)",                   
  "Hernandez et al (1999)",                
  "Gimenez-Hurtado et al (2005)",          
  "Burgos-Rosas & Perez-Perez (2006)",     
  "Hernandez et al (2010)",                
  "Monroy-Garcia et al (2013)",
  "Echazaba-Salazar et al (2021)",
  "Present study (Stock biomass)",         
  "Present study (Spawning stock biomass)",
  "Present study (MSY)"
))

# Use the ordered data and factor 
# first the palettes for 25 factors

bioss2$quant.author <- factor(bioss2$quant.author, levels=unique(bioss2$quant.author))

Burg24 <- paletteer_c("grDevices::Burg", 25, direction=-1)
BlueTeal24 <- paletteer_c("ggthemes::Blue-Teal", 24, direction=-1)
colores <- c(Burg24, BlueTeal24)
autmsy <- append(levels(bioss2$author)[!grepl("biomass", levels(bioss2$author))],"")
autbiom <- append(levels(bioss2$author)[!grepl("MSY", levels(bioss2$author))],"Present study (MSY)",25)
leglab <- c(autbiom, autmsy)

# the plot

biotrend<-ggplot() +
  geom_area(data=ct, aes(year, y=ton/1000, fill=Category),color="grey30",fill="grey80") +
  geom_line(data=bioss2[!grepl("MSY.", bioss2$quant.author),], aes(x = year, y = ton/1000, color = quant.author, group = quant.author), linewidth=1.25) +
  geom_line(data=bioss2[grepl("MSY.", bioss2$quant.author),], aes(x = year, y = ton/1000, color = quant.author, group = quant.author), linewidth=1.25) +
  
  #geom_point(data=bioss2, aes(x = year, y = ton, color = author, shape = Category), size=2) +
  scale_y_continuous(expand = c(0, 0), breaks = seq(0, 400, 25)) +
  #scale_color_paletteer_d("colorBlindness::SteppedSequential5Steps")+
  scale_color_manual(values=colores,name="Author Biomass                                 Author MSY",
                     labels=leglab) + #palette de paletteer
  theme_bw() +
  xlab("") + ylab("tonnes (x1000)")+
  guides(col = guide_legend(ncol=2,nrow = 25)) +
  theme(
    legend.title = element_text(size = 14, face="bold"),
    legend.text = element_text(size = 12),
    legend.key.size = unit(1, "lines"),
    legend.direction= "vertical",
    legend.position = "right",
    axis.title=element_text(size=14,face="bold"),
    axis.text=element_text(size=14, face="bold")
  ) + ggtitle("b)")

ggarrange(biom,biotrend,align="hv",ncol=1,nrow=2,
          common.legend=TRUE,legend=c("right"))

#------------------------------
#test for paper's review
#------------------------------

bioss2 %>% 
  tidyplot(x=year,y=ton,color=quant.author) %>% 
  add_line() %>% 
  #add_sem_ribbon() %>% 
  adjust_size(height=90,width=90,unit="mm") %>% 
  split_plot(by=Category)

bioss3<-filter(bioss2,source=="Past studies")

bioss3$author<-factor(bioss3$author,levels=c(
  "Gonzalez et al (1974a)",                
  "Gonzalez et al (1974b)",                
  "Klima (1976)",                          
  "Buesa (1978)",                          
  "Blanco et al (1980)",                   
  "Doi et al (1981)",                      
  "Seijo (1986)",                          
  "Garcia et al (1986)",                   
  "Fuentes & Contreras (1986)",            
  "Arreguin-Sanchez (1987)",
  "Valdes et al (1989)",                   
  "Moreno et al (1991)",                   
  "Contreras et al (1993)",                
  "Moreno et al (1995)",
  "Moreno et al (1997)",
  "Monroy-Garcia (1998)",                  
  "Burgos et al (1999)",                   
  "Hernandez et al (1999)",                
  "Gimenez-Hurtado et al (2005)",          
  "Burgos-Rosas & Perez-Perez (2006)",     
  "Hernandez et al (2010)",                
  "Monroy-Garcia et al (2013)",
  "Echazaba-Salazar et al (2021)"
))

# Use the ordered data and factor 

bioss3$quant.author <- factor(bioss3$quant.author, levels=unique(bioss3$quant.author))

Burg23 <- paletteer_c("grDevices::Burg", 23, direction=-1)
BlueTeal23 <- paletteer_c("ggthemes::Blue-Teal", 23, direction=-1)
colores <- c(Burg23, BlueTeal23)
autbiom2 <- append(levels(bioss3$author)[!grepl("biomass", levels(bioss3$author))],"",23)
autmsy2 <- append(levels(bioss3$author)[!grepl("MSY", levels(bioss3$author))],"")
leglab2 <- c(autbiom2, autmsy2)


biotrend2<-ggplot() +
  geom_area(data=ct, aes(year, y=ton/1000, fill=Category),color="grey30",fill="grey80") +
  geom_line(data=bioss3[!grepl("MSY.", bioss3$quant.author),], aes(x = year, y = ton/1000, color = quant.author, group = quant.author), linewidth=1.25) +
  geom_line(data=bioss3[grepl("MSY.", bioss3$quant.author),], aes(x = year, y = ton/1000, color = quant.author, group = quant.author), linewidth=1.25) +
  
  #geom_point(data=bioss2, aes(x = year, y = ton, color = author, shape = Category), size=2) +
  scale_y_continuous(expand = c(0, 0), breaks = seq(0, 400, 25)) +
  #scale_color_paletteer_d("colorBlindness::SteppedSequential5Steps")+
  scale_color_manual(values=colores,name="Author Biomass                                 Author MSY",
                     labels=leglab2) + #palette de paletteer
  theme_bw() +
  xlab("") + ylab("tonnes (x1000)")+
  guides(col = guide_legend(ncol=2,nrow = 23)) +
  theme(
    legend.title = element_text(size = 14, face="bold"),
    legend.text = element_text(size = 12),
    legend.key.size = unit(1, "lines"),
    legend.direction= "vertical",
    legend.position = "right",
    axis.title=element_text(size=14,face="bold"),
    axis.text=element_text(size=14, face="bold")
  ) + ggtitle("a)")

bioss4<-filter(bioss2,source=="Present study")

bioss4$author2<-as.factor(ifelse(bioss4$author=="Present study (Stock biomass)","Stock biomass",
                                 ifelse(bioss4$author=="Present study (Spawning stock biomass)", "Spawning stock biomass", "MSY")))

bioss4$author2<-factor(bioss4$author2,levels=c(
  "Stock biomass",         
  "Spawning stock biomass",
  "MSY"
))

# Create a proper color mapping
# MSY as solid blue and the other two with sequential colors:
colors_custom <- c(
  "Stock biomass" = paletteer_c("grDevices::Burg", 2, direction=1)[1],
  "Spawning stock biomass" = paletteer_c("grDevices::Burg", 2, direction=1)[2],
  "MSY" = "dodgerblue4"
)

# original palette approach

Burg2 <- paletteer_c("grDevices::Burg", 2, direction=1)  # For the two biomass lines
colores_fixed <- c(Burg2, "dodgerblue4")  # Sequential colors + solid blue
names(colores_fixed) <- levels(bioss4$author2)

prsnt <- ggplot() +
  geom_area(data = ct, aes(year, y = ton/1000, fill = Category), 
            color = "grey30", fill = "grey80") +
  # Single geom_line call using 'author' for color mapping
  geom_line(data = bioss4, aes(x = year, y = ton/1000, color = author2, group = author2), 
            linewidth = 1.25) +
  scale_y_continuous(expand = c(0, 0), breaks = seq(0, 400, 25)) +
  # Use the fixed color mapping
  scale_color_manual(values = colores_fixed, name = "Present study") +
  theme_bw() +
  xlab("") + ylab("tonnes (x1000)") +
  guides(col = guide_legend(ncol = 1, nrow = 4)) +
  theme(
    legend.title = element_text(size = 14, face = "bold"),
    legend.text = element_text(size = 12),
    legend.key.size = unit(1, "lines"),
    legend.direction = "vertical",
    legend.position = "right",
    axis.title = element_text(size = 14, face = "bold"),
    axis.text = element_text(size = 14, face = "bold")
  ) + 
  ggtitle("b)")

ggarrange(biotrend2,prsnt,align="hv",ncol=1,nrow=2,
          legend=c("right"))

#--------------------------------------------------
# gray scale with single figure
#--------------------------------------------------

ggplot() +
  geom_area(data=ct, aes(year, y=ton/1000, fill=Category),
            color="grey30",fill="grey80") +
  geom_line(data=bioss2[!grepl("MSY.", bioss2$quant.author),],
            aes(x = year, y = ton/1000, color = quant.author,
                group = quant.author), linewidth=1.25) +
  geom_line(data=bioss2[grepl("MSY.", bioss2$quant.author),],
            aes(x = year, y = ton/1000, color = quant.author,
                group = quant.author), linewidth=1.25) +
  scale_y_continuous(expand = c(0, 0), breaks = seq(0, 400, 25)) +
  scale_color_paletteer_d("colorBlindness::SteppedSequential5Steps")+
  scale_color_manual(values=colores,name="Author Biomass                                  Author MSY",
                     labels=leglab) + #palette de paletteer
  theme_bw() +
  xlab("") + ylab("tonnes (x1000)")+
  guides(col = guide_legend(ncol=2,nrow = 25)) +
  theme(
    legend.title = element_text(size = 14, face="bold"),
    legend.text = element_text(size = 12),
    legend.key.size = unit(1, "lines"),
    legend.direction= "vertical",
    legend.position = "right",
    axis.title=element_text(size=14,face="bold"),
    axis.text=element_text(size=14, face="bold")
  ) + ggtitle("")

bioss2 <- filter(bioss2, Category != "Total catch")
bioss2$author <- factor(bioss2$author, levels = c(
  "Gonzalez et al (1974a)",                
  "Gonzalez et al (1974b)",                
  "Klima (1976)",                          
  "Buesa (1978)",                          
  "Blanco et al (1980)",                   
  "Doi et al (1981)",                      
  "Seijo (1986)",                          
  "Garcia et al (1986)",                   
  "Fuentes & Contreras (1986)",            
  "Arreguin-Sanchez (1987)",
  "Valdes et al (1989)",                   
  "Moreno et al (1991)",                   
  "Contreras et al (1993)",                
  "Moreno et al (1995)",
  "Moreno et al (1997)",
  "Monroy-Garcia (1998)",                  
  "Burgos et al (1999)",                   
  "Hernandez et al (1999)",                
  "Gimenez-Hurtado et al (2005)",          
  "Burgos-Rosas & Perez-Perez (2006)",     
  "Hernandez et al (2010)",                
  "Monroy-Garcia et al (2013)",
  "Echazaba-Salazar et al (2021)",
  "Present study (Stock biomass)",         
  "Present study (Spawning stock biomass)",
  "Present study (MSY)"
))

# Use the ordered data and factor 
bioss2$quant.author <- factor(bioss2$quant.author, levels = unique(bioss2$quant.author))

# Create custom colors - all grey except Present study
colores_highlight <- rep("grey70", length(unique(bioss2$quant.author)))
names(colores_highlight) <- levels(bioss2$quant.author)

# Find Present study entries in quant.author and assign specific colors
present_indices <- which(grepl("Present study", levels(bioss2$quant.author)) | 
                           grepl("Present study", names(colores_highlight)))

# If the above doesn't work, try finding by checking the actual data
if(length(present_indices) == 0) {
  # Alternative: look for Present study entries in the data itself
  present_quant_authors <- unique(bioss2$quant.author[bioss2$author %in% 
                                                        c("Present study (Stock biomass)", "Present study (Spawning stock biomass)", "Present study (MSY)")])
  
  for(i in 1:length(colores_highlight)) {
    quant_name <- names(colores_highlight)[i]
    if(quant_name %in% present_quant_authors) {
      # Determine which Present study line this is by checking the data
      corresponding_data <- bioss2[bioss2$quant.author == quant_name, ]
      if(nrow(corresponding_data) > 0) {
        author_name <- unique(corresponding_data$author)[1]
        if(author_name == "Present study (Stock biomass)") {
          colores_highlight[i] <- "red3"
        } else if(author_name == "Present study (Spawning stock biomass)") {
          colores_highlight[i] <- "red2"
        } else if(author_name == "Present study (MSY)") {
          colores_highlight[i] <- "dodgerblue4"
        }
      }
    }
  }
} else {
  # Direct assignment if found by name
  for(idx in present_indices) {
    quant_name <- names(colores_highlight)[idx]
    if(grepl("Stock.*biomass", quant_name) && !grepl("Spawning", quant_name)) {
      colores_highlight[idx] <- "red3"
    } else if(grepl("Spawning.*biomass", quant_name)) {
      colores_highlight[idx] <- "red2"
    } else if(grepl("MSY", quant_name)) {
      colores_highlight[idx] <- "dodgerblue4"
    }
  }
}

# Create legend labels (keep your existing approach)
autmsy <- append(levels(bioss2$author)[!grepl("biomass", levels(bioss2$author))], "")
autbiom <- append(levels(bioss2$author)[!grepl("MSY", levels(bioss2$author))], "Present study (MSY)", 25)
leglab <- c(autbiom, autmsy)

# The plot with highlighting
biotrend2 <- ggplot() +
  geom_area(data = ct, aes(year, y = ton/1000, fill = Category), 
            color = "grey30", fill = "grey80") +
  
  # Plot non-MSY lines (biomass)
  geom_line(data = bioss2[!grepl("MSY.", bioss2$quant.author), ], 
            aes(x = year, y = ton/1000, color = quant.author, group = quant.author), 
            linewidth = ifelse(grepl("Present study", 
                                     bioss2[!grepl("MSY.", bioss2$quant.author), ]$author), 
                               2, 0.8),
            alpha = ifelse(grepl("Present study", 
                                 bioss2[!grepl("MSY.", bioss2$quant.author), ]$author), 
                           1, 0.7)) +
  
  # Plot MSY lines  
  geom_line(data = bioss2[grepl("MSY.", bioss2$quant.author), ], 
            aes(x = year, y = ton/1000, color = quant.author, group = quant.author), 
            linewidth = ifelse(grepl("Present study", 
                                     bioss2[grepl("MSY.", bioss2$quant.author), ]$author), 
                               2, 0.8),
            alpha = ifelse(grepl("Present study", 
                                 bioss2[grepl("MSY.", bioss2$quant.author), ]$author), 
                           1, 0.7)) +
  
  scale_y_continuous(expand = c(0, 0), breaks = seq(0, 400, 25)) +
  scale_color_manual(values = colores_highlight, 
                     name = "Author Biomass                                 Author MSY",
                     labels = leglab) +
  theme_bw() +
  xlab("") + ylab("tonnes (x1000)") +
  guides(col = guide_legend(ncol = 2, nrow = 25)) +
  theme(
    legend.title = element_text(size = 14, face = "bold"),
    legend.text = element_text(size = 12),
    legend.key.size = unit(1, "lines"),
    legend.direction = "vertical",
    legend.position = "right",
    axis.title = element_text(size = 14, face = "bold"),
    axis.text = element_text(size = 14, face = "bold")
  ) + 
  ggtitle("Historic biomass trends")


# Create custom colors for highlighting Present study
colores_highlight <- rep("grey70", length(unique(bioss2$quant.author)))
names(colores_highlight) <- levels(bioss2$quant.author)

# Assign colors to Present study entries
present_quant_authors <- unique(bioss2$quant.author[bioss2$author %in% 
                                                      c("Present study (Stock biomass)", "Present study (Spawning stock biomass)", "Present study (MSY)")])

for(i in 1:length(colores_highlight)) {
  quant_name <- names(colores_highlight)[i]
  if(quant_name %in% present_quant_authors) {
    corresponding_data <- bioss2[bioss2$quant.author == quant_name, ]
    if(nrow(corresponding_data) > 0) {
      author_name <- unique(corresponding_data$author)[1]
      if(author_name == "Present study (Stock biomass)") {
        colores_highlight[i] <- "firebrick4"
      } else if(author_name == "Present study (Spawning stock biomass)") {
        colores_highlight[i] <- "firebrick3"
      } else if(author_name == "Present study (MSY)") {
        colores_highlight[i] <- "dodgerblue4"
      }
    }
  }
}

# Create legend labels
autmsy <- append(levels(bioss2$author)[!grepl("biomass", levels(bioss2$author))], "")
autbiom <- append(levels(bioss2$author)[!grepl("MSY", levels(bioss2$author))], "Present study (MSY)", 25)
leglab <- c(autbiom, autmsy)

# Define the MSY box coordinates based on where MSY lines appear in your plot
# Adjust these values to encompass the MSY lines in your actual data
msy_box <- data.frame(
  xmin = 1958, xmax = 2023,  # Year range where MSY lines are visible
  ymin = 5, ymax = 30        # Y-axis range that encompasses MSY values
)

# Main plot with MSY region highlighted by a box
biotrend3 <- ggplot()+
  # Plot non-MSY lines (biomass)
  geom_line(data = bioss2[!grepl("MSY.", bioss2$quant.author), ], 
            aes(x = year, y = ton/1000, color = quant.author, group = quant.author), 
            linewidth = ifelse(grepl("Present study", 
                                     bioss2[!grepl("MSY.", bioss2$quant.author), ]$author), 
                               2, 0.8),
            alpha = ifelse(grepl("Present study", 
                                 bioss2[!grepl("MSY.", bioss2$quant.author), ]$author), 
                           1, 0.7)) +
  
  # Plot MSY lines  
  # geom_line(data = bioss2[grepl("MSY.", bioss2$quant.author), ], 
  #           aes(x = year, y = ton/1000, color = quant.author, group = quant.author), 
  #           linewidth = ifelse(grepl("Present study", 
  #                                    bioss2[grepl("MSY.", bioss2$quant.author), ]$author), 
  #                              2, 0.8),
  #           alpha = ifelse(grepl("Present study", 
  #                                bioss2[grepl("MSY.", bioss2$quant.author), ]$author), 
  #                          1, 0.7)) +
  
  # Add the MSY box outline OVER the plot data
  # geom_rect(data = msy_box, 
  #           aes(xmin = xmin, xmax = xmax, ymin = ymin, ymax = ymax),
  #           color = "firebrick1", fill = NA, linewidth = 1, linetype = "dashed") +
  # 
  # # Optional: Add an arrow or text annotation pointing to the box
  # annotate("text", x = msy_box$xmin - 5, y = msy_box$ymax, 
  #          label = "MSY Detail →", size = 3, color = "firebrick1", fontface = "bold") +
  scale_y_continuous(expand = c(0, 0), breaks = seq(0, 400, 25)) +
  scale_color_manual(values = colores_highlight, 
                     name = "Reference",
                     labels = leglab) +
  theme_bw() +
  xlab("") + ylab("tonnes (x1000)") +
  guides(col = guide_legend(ncol = 2, nrow = 25)) +
  theme(
    legend.title = element_text(size = 14, face = "bold"),
    legend.text = element_text(size = 12),
    legend.key.size = unit(1, "lines"),
    legend.direction = "vertical",
    legend.position = "right",
    axis.title = element_text(size = 14, face = "bold"),
    axis.text = element_text(size = 14, face = "bold")
  ) + 
  ggtitle("Biomass trends")

# Create MSY-only subplot showing the same region as the box
msy_data <- bioss2[grepl("MSY.", bioss2$quant.author), ]

# Create colors only for MSY entries
msy_colors <- colores_highlight[names(colores_highlight) %in% unique(msy_data$quant.author)]

msy_subplot <- ggplot() +
  geom_area(data = ct, aes(year, y = ton/1000, fill = Category), 
            color = "grey30", fill = "dodgerblue",alpha=0.3) +
  # Add a subtle background to match the main plot's MSY region
  # geom_rect(data = msy_box, 
  #           aes(xmin = 1958, xmax = xmax, ymin = ymin, ymax = ymax),
  #           color = "firebrick1", fill = "grey95", alpha = 0.3, linewidth = 1) +
  
  geom_line(data = msy_data, 
            aes(x = year, y = ton/1000, color = quant.author, group = quant.author), 
            linewidth = ifelse(grepl("Present study", msy_data$author), 2.5, 1.2)) +
  
  scale_color_manual(values = msy_colors) +
  scale_y_continuous(expand = c(0, 0), breaks = seq(0, 400, 25)) +
  
  theme_bw() +
  theme(
    legend.position = "none",
    axis.title = element_text(size = 10, face = "bold"),
    axis.text = element_text(size = 9),
    plot.background = element_rect(color = "transparent", linewidth = 2),
    panel.border = element_rect(color = "transparent", linewidth = 1)
  ) +
  xlab("Year") + ylab("tonnes x1000") +
  ggtitle("MSY Detail View")

# Method 1: Side-by-side with the box clearly showing the correspondence
side_by_side <- ggarrange(
  biotrend3, msy_subplot,
  ncol = 2, nrow = 1,
  widths = c(2.5, 1),  # Main plot is 2.5x wider than subplot
  align = "h"
)

# Method 2: Stacked arrangement 
stacked_plots <- ggarrange(
  biotrend3,
  msy_subplot,
  ncol = 1, nrow = 2,
  heights = c(2, 1),  # Main plot is 2x taller than subplot
  align = "v"
)
#----------------------------------------------
# another go to the plot
# single plot, two panels, single legend, 
# single x, highlight present study
#----------------------------------------------

bioss5<-filter(bioss2,Category%in%c("Estimated biomass"))

Burg2 <- paletteer_c("grDevices::Burg", 25, direction=1)
BlueTeal24 <- paletteer_c("ggthemes::Blue-Teal", 24, direction=1)

ggplot()+
  geom_line(data = bioss5,aes(x = year, y = ton/1000, 
                              color = author, group = author),linewidth = 1)+
  gghighlight(quant.author==c("B..present.study","SSB..present.study"),
              unhighlighted_params = list(linewidth=1,colour=alpha("pink",0.4)),
              use_direct_label=TRUE,
              line_label_type="sec_axis")+
  scale_y_continuous(expand = c(0, 0), breaks = seq(0, 400, 25)) +
  scale_color_manual(values = Burg2, 
                     name = "Reference",
                     labels = leglab) +
  theme_bw() +
  xlab("") + ylab("tonnes (x1000)")

#----------------------

# Create a unified reference system with numbers
create_numbered_legend <- function(bioss_data) {
  # Get unique authors in order
  unique_authors <- levels(bioss_data$author)
  
  # Create a mapping of author to number
  author_numbers <- data.frame(
    author = unique_authors,
    number = 1:length(unique_authors),
    stringsAsFactors = FALSE
  )
  
  # Create numbered labels - highlight Present study entries
  author_numbers$label <- ifelse(
    grepl("Present study", author_numbers$author),
    paste0(author_numbers$number, ". ", author_numbers$author, " ★"),  # Add star for Present study
    paste0(author_numbers$number, ". ", author_numbers$author)
  )
  
  return(author_numbers)
}

# Create the numbered legend system
author_legend <- create_numbered_legend(bioss2)
print("Legend mapping:")
print(author_legend[c("number", "author", "label")])

# Create a mapping from quant.author to numbers
create_quant_to_number_mapping <- function(bioss_data, author_legend) {
  # Create a lookup table using base R
  quant_to_author <- unique(bioss_data[, c("quant.author", "author")])
  
  # Merge with legend numbers
  quant_mapping <- merge(quant_to_author, author_legend, by = "author")
  
  # Create the final mapping
  quant_numbers <- setNames(quant_mapping$number, quant_mapping$quant.author)
  quant_labels <- setNames(quant_mapping$label, quant_mapping$quant.author)
  
  return(list(numbers = quant_numbers, labels = quant_labels))
}

quant_mapping <- create_quant_to_number_mapping(bioss2, author_legend)

# Create enhanced colors - highlight Present study with distinct colors
create_enhanced_colors <- function(bioss_data, author_legend) {
  unique_quant <- levels(bioss_data$quant.author)
  colors <- rep("grey60", length(unique_quant))  # Default grey for past studies
  names(colors) <- unique_quant
  
  # Find Present study entries and assign distinct colors
  for(i in 1:length(colors)) {
    quant_name <- names(colors)[i]
    corresponding_data <- bioss_data[bioss_data$quant.author == quant_name, ]
    
    if(nrow(corresponding_data) > 0) {
      author_name <- unique(corresponding_data$author)[1]
      if(grepl("Present study.*Stock biomass", author_name) & !grepl("Spawning", author_name)) {
        colors[i] <- "firebrick4"
      } else if(grepl("Present study.*Spawning.*biomass", author_name)) {
        colors[i] <- "firebrick3"
      } else if(grepl("Present study.*MSY", author_name)) {
        colors[i] <- "dodgerblue4"
      }
    }
  }
  
  return(colors)
}

enhanced_colors <- create_enhanced_colors(bioss2, author_legend)

# Create line width mapping (thicker for Present study)
create_line_widths <- function(data, base_width = 0.8, highlight_width = 2) {
  ifelse(grepl("Present study", data$author), highlight_width, base_width)
}

# Create alpha mapping (more opaque for Present study)
create_alpha_values <- function(data, base_alpha = 0.6, highlight_alpha = 1) {
  ifelse(grepl("Present study", data$author), highlight_alpha, base_alpha)
}

# Modified biomass plot
biotrend3 <- ggplot() +
  # Plot non-MSY lines (biomass) with enhanced styling
  geom_line(data = bioss2[!grepl("MSY.", bioss2$quant.author), ], 
            aes(x = year, y = ton/1000, color = quant.author, group = quant.author), 
            linewidth = 1,
            alpha = create_alpha_values(bioss2[!grepl("MSY.", bioss2$quant.author), ])) +
  
  scale_y_continuous(expand = c(0, 0), breaks = seq(0, 400, 25)) +
  scale_color_manual(values = enhanced_colors, 
                     name = "References",
                     labels = quant_mapping$labels) +
  theme_bw() +
  xlab("") + ylab("tonnes (x1000)") +
  guides(color = guide_legend(
    ncol = 1, 
    nrow = length(unique(bioss2$author)),
    override.aes = list(linewidth = 1.2, alpha = 1),  # Standardize legend appearance
    title.position = "top"
  )) +
  theme(
    legend.title = element_text(size = 14, face = "bold"),
    legend.text = element_text(size = 10),  # Smaller text to fit numbers
    legend.key.size = unit(0.8, "lines"),
    legend.direction = "vertical",
    legend.position = "right",
    legend.margin = margin(0, 0, 0, 10),
    axis.title = element_text(size = 14, face = "bold"),
    axis.text = element_text(size = 14, face = "bold")
  ) + 
  ggtitle("Biomass trends")

# Create MSY-only subplot with the same legend system
msy_data <- bioss2[grepl("MSY.", bioss2$quant.author), ]
msy_colors <- enhanced_colors[names(enhanced_colors) %in% unique(msy_data$quant.author)]

msy_subplot <- ggplot() +
  geom_area(data = ct, aes(year, y = ton/1000, fill = Category), 
            color = "grey30", fill = "dodgerblue", alpha = 0.3) +
  
  geom_line(data = msy_data, 
            aes(x = year, y = ton/1000, color = quant.author, group = quant.author), 
            linewidth = 1,
            alpha = create_alpha_values(msy_data)) +
  
  scale_color_manual(values = msy_colors,
                     name = "References",
                     labels = quant_mapping$labels) +
  scale_y_continuous(expand = c(0, 0), breaks = seq(0, 400, 25)) +
  
  theme_bw() +
  theme(
    legend.title = element_text(size = 14, face = "bold"),
    legend.text = element_text(size = 10),  # Smaller text to fit numbers
    legend.key.size = unit(0.8, "lines"),
    legend.direction = "vertical",
    legend.position = "right",
    legend.margin = margin(0, 0, 0, 10),
    axis.title = element_text(size = 14, face = "bold"),
    axis.text = element_text(size = 14, face = "bold")
  ) + 
  xlab("Year") + ylab("tonnes x1000") +
  ggtitle("MSY trends") +
  
  # Add reference numbers as text annotations for key MSY lines
  geom_text(data = {
    present_msy <- msy_data[grepl("Present study", msy_data$author), ]
    if(nrow(present_msy) > 0) {
      # Get the last year for each Present study MSY line
      present_msy_last <- do.call(rbind, lapply(split(present_msy, present_msy$quant.author), function(x) {
        x[which.max(x$year), ]
      }))
      present_msy_last
    } else {
      data.frame()  # Return empty data frame if no Present study MSY data
    }
  }, 
  aes(x = year, y = ton/1000, 
      label = quant_mapping$numbers[quant.author]),
  size = 3, fontface = "bold", color = "black")

# Arrange plots side by side with shared legend

combined_plots <- ggarrange(
  biotrend3, msy_subplot,
  ncol = 1, nrow = 2,
  widths = c(1, 2),
  align = "h",
  common.legend = TRUE,
  legend = "none"
)


# Alternative: Create a separate legend plot if you want more control
create_custom_legend <- function(author_legend, enhanced_colors) {
  # Create a data frame for legend plotting
  legend_data <- author_legend
  legend_data$color <- sapply(legend_data$author, function(auth) {
    # Find corresponding color
    matching_quant <- names(enhanced_colors)[sapply(names(enhanced_colors), function(q) {
      any(bioss2$author[bioss2$quant.author == q] == auth)
    })]
    if(length(matching_quant) > 0) return(enhanced_colors[matching_quant[1]])
    return("grey60")
  })
  
  # Create legend plot
  ggplot(legend_data, aes(x = 1, y = number)) +
    geom_point(aes(color = color), size = 3) +
    geom_text(aes(label = label), hjust = 0, x = 1.1, size = 3) +
    scale_color_identity() +
    scale_y_reverse() +
    theme_void() +
    theme(plot.margin = margin(0, 0, 0, 0)) +
    xlim(0.9, 3)
}

# Uncomment to use custom legend:
custom_legend <- create_custom_legend(author_legend, enhanced_colors)

combined_plots|custom_legend


#-----------------------------------------------------------

library(gghighlight)
library(ggplot2)

# Simple approach with gghighlight
biotrend3_simple <- ggplot(data = bioss2[!grepl("MSY.", bioss2$quant.author), ], 
                           aes(x = year, y = ton/1000, color = author, group = quant.author)) +
  geom_line(linewidth = 1.2) +
  
  # Highlight only Present study lines
  gghighlight(grepl("Present study", author),
              unhighlighted_params = list(
                color = "grey80",      # Color for non-highlighted lines
                alpha = 0.5,          # Transparency for background lines
                linewidth = 0.6       # Thinner lines for background
              ),
              use_direct_label = TRUE,  # Add labels directly on the plot
              label_key = author,       # Use author names as labels
              label_params = list(size = 3, fontface = "bold")) +
  
  # Custom colors for Present study lines
  scale_color_manual(values = c(
    "Present study (Stock biomass)" = "firebrick4",
    "Present study (Spawning stock biomass)" = "firebrick3",
    "Present study (MSY)" = "dodgerblue4"
  )) +
  
  scale_y_continuous(expand = c(0, 0), breaks = seq(0, 400, 25)) +
  theme_bw() +
  xlab("") + ylab("tonnes (x1000)") +
  theme(
    legend.position = "right",
    axis.title = element_text(size = 14, face = "bold"),
    axis.text = element_text(size = 14, face = "bold")
  ) + 
  ggtitle("Biomass trends - Present Study Highlighted")

# MSY subplot with gghighlight
msy_data <- bioss2[grepl("MSY.", bioss2$quant.author), ]

msy_subplot_simple <- ggplot(data = msy_data, 
                             aes(x = year, y = ton/1000, color = author, group = quant.author)) +
  geom_area(data = ct, aes(year, y = ton/1000, fill = Category), 
            color = "grey30", fill = "dodgerblue", alpha = 0.3, inherit.aes = FALSE) +
  
  geom_line(linewidth = 1.2) +
  
  # Highlight Present study MSY
  gghighlight(grepl("Present study", author),
              unhighlighted_params = list(
                color = "grey70",
                alpha = 0.6,
                linewidth = 0.8
              ),
              use_direct_label = TRUE,
              label_key = author,
              label_params = list(size = 2.5, fontface = "bold")) +
  
  scale_color_manual(values = c("Present study (MSY)" = "dodgerblue4")) +
  scale_y_continuous(expand = c(0, 0), breaks = seq(0, 400, 25)) +
  theme_bw() +
  theme(
    legend.position = "right",
    axis.title = element_text(size = 14, face = "bold"),
    axis.text = element_text(size = 14, face = "bold")
  ) + 
  xlab("Year") + ylab("tonnes x1000") +
  ggtitle("MSY trends - Present Study Highlighted")

# Combine plots
library(ggpubr)
combined_simple <- ggarrange(
  biotrend3_simple, msy_subplot_simple,
  ncol = 1, nrow = 2,
  widths = c(1, 2),
  align = "h"
)

combined_simple|custom_legend

# --- Plot 1: Biomass Trends --- another test

# Prepare data and identify groups
biotrend_data <- bioss2[!grepl("MSY.", bioss2$quant.author), ] %>%
  mutate(highlight_group = ifelse(grepl("Present study", author), "Highlighted", "Unhighlighted"))

# Get names of unhighlighted authors to create the gray palette
unhighlighted_authors <- unique(biotrend_data$author[!grepl("Present study", biotrend_data$author)])
n_greys <- length(unhighlighted_authors)

# Create a named vector for the gray colors
gray_palette <- gray.colors(n_greys, start = 0.4, end = 0.8)
names(gray_palette) <- unhighlighted_authors

# Combine with the specific colors for highlighted lines
full_palette1 <- c(
  "Present study (Stock biomass)" = "firebrick4",
  "Present study (Spawning stock biomass)" = "firebrick3",
  gray_palette # Add the named gray palette
)

# Create data for direct labels
label_data1 <- biotrend_data %>%
  filter(highlight_group == "Highlighted") %>%
  group_by(author) %>%
  slice_max(order_by = year, n = 1) # Get the last point of each line for labeling

# Build the plot
biotrend3_manual <- ggplot(data = biotrend_data,
                           aes(x = year, y = ton/1000, color = author, group = quant.author,
                               alpha = highlight_group, linewidth = highlight_group)) +
  geom_line() +
  
  # Use ggrepel for direct labels on highlighted lines
  geom_text_repel(data = label_data1, aes(label = author),
                  size = 3, fontface = "bold",
                  nudge_x = 1, direction = "y", hjust = 0, segment.color = NA) +
  
  # Apply the custom color palette
  scale_color_manual(values = full_palette1) +
  
  # Manually set alpha (transparency)
  scale_alpha_manual(values = c("Highlighted" = 1.0, "Unhighlighted" = 0.7), guide = "none") +
  
  # Manually set line width
  scale_linewidth_manual(values = c("Highlighted" = 1.2, "Unhighlighted" = 0.6), guide = "none") +
  
  scale_y_continuous(expand = c(0, 0), breaks = seq(0, 400, 25)) +
  theme_bw() +
  xlab("") + ylab("tonnes (x1000)") +
  theme(
    legend.position = "none", # Legend is not needed due to direct labels
    axis.title = element_text(size = 14, face = "bold"),
    axis.text = element_text(size = 14, face = "bold")
  ) +
  ggtitle("Biomass trends - Present Study Highlighted")

# --- Plot 2: MSY Subplot ---

# Prepare data and identify groups
msy_data <- bioss2[grepl("MSY.", bioss2$quant.author), ] %>%
  mutate(highlight_group = ifelse(grepl("Present study", author), "Highlighted", "Unhighlighted"))

# Get names of unhighlighted authors for the gray palette
unhighlighted_authors_msy <- unique(msy_data$author[!grepl("Present study", msy_data$author)])
n_greys_msy <- length(unhighlighted_authors_msy)

# Create a named vector for the gray colors
gray_palette_msy <- gray.colors(n_greys_msy, start = 0.4, end = 0.7)
names(gray_palette_msy) <- unhighlighted_authors_msy

# Combine with the specific color for the highlighted line
full_palette2 <- c(
  "Present study (MSY)" = "dodgerblue4",
  gray_palette_msy
)

# Create data for direct labels
label_data2 <- msy_data %>%
  filter(highlight_group == "Highlighted") %>%
  group_by(author) %>%
  slice_max(order_by = year, n = 1)

# Build the plot
msy_subplot_manual <- ggplot(data = msy_data,
                             aes(x = year, y = ton/1000, color = author, group = quant.author,
                                 alpha = highlight_group, linewidth = highlight_group)) +
  geom_area(data = ct, aes(year, y = ton/1000), inherit.aes = FALSE,
            color = "grey30", fill = "dodgerblue", alpha = 0.3) +
  geom_line() +
  
  # Direct label for the highlighted line
  geom_text_repel(data = label_data2, aes(label = author),
                  size = 2.5, fontface = "bold",
                  nudge_x = 1, direction = "y", hjust = 0, segment.color = NA) +
  
  # Apply the custom color palette
  scale_color_manual(values = full_palette2) +
  
  # Manually set alpha
  scale_alpha_manual(values = c("Highlighted" = 1.0, "Unhighlighted" = 0.8), guide = "none") +
  
  # Manually set line width
  scale_linewidth_manual(values = c("Highlighted" = 1.2, "Unhighlighted" = 0.8), guide = "none") +
  
  scale_y_continuous(expand = c(0, 0), breaks = seq(0, 400, 25)) +
  theme_bw() +
  theme(
    legend.position = "none",
    axis.title = element_text(size = 14, face = "bold"),
    axis.text = element_text(size = 14, face = "bold")
  ) +
  xlab("Year") + ylab("tonnes x1000") +
  ggtitle("MSY trends - Present Study Highlighted")

# --- Combine Plots ---

combined_manual <- ggarrange(
  biotrend3_manual, msy_subplot_manual,
  ncol = 1, nrow = 2,
  # Adjust widths/heights as needed
  align = "v" # Vertical alignment is often better for stacked plots
)

#---------------------------------------------
# yet another test
#---------------------------------------------

# Numeric key for unhighlighted authors ---

# unique authors that are NOT "Present study"
unhighlighted_authors_all <- bioss2 %>%
  filter(!grepl("Present study", author)) %>%
  distinct(author) %>%
  pull(author)

# data frame for legend key
author_key <- data.frame(
  Number = 1:length(unhighlighted_authors_all),
  Author = unhighlighted_authors_all
)

# check key
head(author_key)

# --- Plot 1: Biomass Trends with Numeric Labels ---

# Join author key to the plotting data to add the 'Number' column
biotrend_data <- bioss2[!grepl("MSY.", bioss2$quant.author), ] %>%
  mutate(highlight_group = ifelse(grepl("Present study", author), "Highlighted", "Unhighlighted")) %>%
  left_join(author_key, by = c("author" = "Author")) # Join the key

# Data for the highlighted text labels
label_data1_highlighted <- biotrend_data %>%
  filter(highlight_group == "Highlighted") %>%
  group_by(author) %>%
  slice_max(order_by = year, n = 1)

# Data for the unhighlighted numeric labels
label_data1_unhighlighted <- biotrend_data %>%
  filter(highlight_group == "Unhighlighted") %>%
  group_by(author) %>%
  slice_max(order_by = year, n = 1)

# create labels and positions for unhighlighted lines
u0 <- biotrend_data[biotrend_data$source != "Present study" & !is.na(biotrend_data$ton),]; u0 <- u0[order(u0$Number, u0$year),]
u1 <- list()
for (i in 1:max(u0$Number)) {temp <- u0[u0$Number == i,]; if (i != 23) u1[[i]] <- temp[1,] else u1[[i]] <- temp[nrow(temp),]}
u2 <- do.call("rbind", u1)

# Create a named vector for the gray colors
n_greys <- nrow(u2)
unhighlighted_authors <- u2$author
gray_palette <- gray.colors(n_greys, start = 0.4, end = 0.8)
names(gray_palette) <- unhighlighted_authors


# Biomass trends plot with the new numeric labels
biotrend3_numbered <- ggplot(data = biotrend_data,
                             aes(x = year, y = ton/1000, color = author, group = quant.author,
                                 alpha = highlight_group, linewidth = highlight_group)) +
  geom_line() +
  
  # Add full text labels for highlighted lines
  geom_text_repel(data = label_data1_highlighted, aes(label = author),
                  size = 3, fontface = "bold",
                  max.overlaps=5, nudge_x=2,
                  nudge_y = 10, direction = "x", hjust = 1, segment.color = NA) +
  
  #label_data1_unhighlighted
  geom_label_repel(data = u2, aes(x=year, y=ton/1000, label = Number), 
                   size = 2.5, fontface = "bold", color = "black",
                   fill = "white", alpha = 0.6,
                   max.overlaps=100,max.iter=Inf,
                   xlim=c(NA,Inf),ylim=c(-Inf,Inf),
                   nudge_x = 1, segment.color = "grey50") +
  
  
  scale_color_manual(values = full_palette1, guide = "none") +
  scale_alpha_manual(values = c("Highlighted" = 1.0, "Unhighlighted" = 0.7), guide = "none") +
  scale_linewidth_manual(values = c("Highlighted" = 1.2, "Unhighlighted" = 0.6), guide = "none") +
  
  scale_y_continuous(expand = c(0, 0), breaks = seq(0, 400, 25)) +
  theme_bw() +
  theme(
    legend.position = "none",
    axis.title = element_blank(),
    axis.text = element_text(size = 14, face = "bold"),
    axis.line.x=element_blank(),
    axis.text.x=element_blank(),
    plot.margin=margin(t=5,r=5,b=-1,l=5,unit="pt"),
    plot.title = element_text(
      hjust = 1,      
      vjust = -10,    
      size = 12,    
      face = "bold" 
    )
  ) + xlab("") + ylab("") +
  ggtitle("Biomass trend")

# --- Plot 2: MSY Subplot with Numeric Labels ---

# Join author key to the MSY data
msy_data <- bioss2[grepl("MSY.", bioss2$quant.author), ] %>%
  mutate(highlight_group = ifelse(grepl("Present study", author), "Highlighted", "Unhighlighted")) %>%
  left_join(author_key, by = c("author" = "Author"))

# Data for highlighted text label
label_data2_highlighted <- msy_data %>%
  filter(highlight_group == "Highlighted") %>%
  group_by(author) %>%
  slice_max(order_by = year, n = 1)

# Data for unhighlighted numeric labels
label_data2_unhighlighted <- msy_data %>%
  filter(highlight_group == "Unhighlighted") %>%
  group_by(author) %>%
  slice_max(order_by = year, n = 1)

# create labels and positions for unhighlighted lines
u01 <- msy_data[msy_data$source != "Present study" & !is.na(msy_data$ton),]; u01 <- u01[order(u01$Number, u01$year),]
u11 <- list()
for (i in 1:max(u01$Number)) {temp <- u01[u01$Number == i,]; if (i != 23) u11[[i]] <- temp[1,] else u11[[i]] <- temp[nrow(temp),]}
u22 <- do.call("rbind", u11)

# Create a named vector for the gray colors
n_greys2 <- nrow(u22)
unhighlighted_authors2 <- u22$author
gray_palette2 <- gray.colors(n_greys2, start = 0.4, end = 0.8)
names(gray_palette2) <- unhighlighted_authors2

# MSY plot
msy_subplot_numbered <- ggplot(data = msy_data,
                               aes(x = year, y = ton/1000, color = author, group = quant.author,
                                   alpha = highlight_group, linewidth = highlight_group)) +
  geom_area(data = ct, aes(year, y = ton/1000), inherit.aes = FALSE,
            color = "grey30", fill = "dodgerblue", alpha = 0.3) +
  geom_line() +
  
  # Full text label for highlighted line
  geom_text_repel(data = label_data2_highlighted, aes(label = author),
                  size = 2.5, fontface = "bold",
                  max.overlaps=10,
                  nudge_y = -0.5, direction = "y", hjust = 0, segment.color = NA) +
  
  geom_label_repel(data = u22, aes(x=year, y=ton/1000, label = Number), 
                   size = 2.5, fontface = "bold", color = "black",
                   fill = "white", alpha = 0.6,
                   max.overlaps=100,max.iter=Inf,
                   xlim=c(NA,Inf),ylim=c(-Inf,Inf),
                   nudge_x = 1, segment.color = "grey50") +
  
  scale_color_manual(values = full_palette2, guide = "none") +
  scale_alpha_manual(values = c("Highlighted" = 1.0, "Unhighlighted" = 0.8), guide = "none") +
  scale_linewidth_manual(values = c("Highlighted" = 1.2, "Unhighlighted" = 0.8), guide = "none") +
  
  scale_y_continuous(expand = c(0, 0), breaks = seq(0, 400, 25)) +
  theme_bw() +
  theme(
    legend.position = "none",
    axis.title = element_text(size = 14, face = "bold"),
    axis.text = element_text(size = 14, face = "bold"),
    plot.margin=margin(t=-9,r=5,b=5,l=5,unit="pt"),
    plot.title = element_text(
      hjust = 1,      
      vjust = -10,     
      size = 12,      
      face = "bold" 
    )
  ) +
  xlab("Year") + ylab("") +
  ggtitle("MSY")

# --- Create the Legend Table and Combine Everything ---

# Object from the author_key data frame
legend_table <- ggtexttable(author_key, rows = NULL,
                            theme = ttheme(
                              colnames.style = colnames_style(face = "bold"),
                              tbody.style = tbody_style(size = 9)
                            ))

# Stack the two main plots vertically
plots_stacked <- ggarrange(
  biotrend3_numbered, msy_subplot_numbered,
  ncol = 1, nrow = 2,
  align = "v"
)

# Create the shared y-axis title object
shared_y_axis_title <- ggpubr::text_grob(
  "tonnes (x1000)", 
  rot = 90, # Rotate the text
  face = "bold", 
  size = 14
)

# Add the shared title to the left of the stacked plots
plots_with_shared_axis <- annotate_figure(
  plots_stacked,
  left = shared_y_axis_title
)

# Combine the stacked plots with the legend table horizontally
final_plot_with_legend <- ggarrange(
  plots_with_shared_axis, legend_table,
  ncol = 2, nrow = 1,
  widths = c(2.5, 1) # Give more space to the plots than the legend
)

