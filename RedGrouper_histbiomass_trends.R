#----------------------------------------------------------------------------
# historic biomass & msy for paper
#----------------------------------------------------------------------------

biomall<-read.csv("histbiomall.csv",sep=",",header=TRUE)
head(biomall)

biomassall<-biomall%>%
  pivot_longer(cols=-year,names_to="quant.author",values_to="ton")

# add faceting factor for nice plot
biomall2<-biomassall%>%
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

biomall2$author<-"no text"
maval<-match(as.character(biomall2$quant.author),names(nmlst))
biomall2$author[!is.na(maval)]<-unlist(nmlst)[maval[!is.na(maval)]]

biomall2$source<-as.factor(ifelse(biomall2$author=="Present study (MSY)",
                                  "Present study",
              ifelse(biomall2$author=="Present study (Stock biomass)","Present study",
              ifelse(biomall2$author=="Present study (Spawning stock biomass)",
              "Present study",ifelse(biomall2$author=="Total catch",
              "Present study","Past studies")))))

biomall3 <- biomall2 %>%
  mutate(year_extracted = as.numeric(stringr::str_extract(quant.author, "\\(?[0-9]{4}"))) #Improved year extraction

biomall3_ordered <- biomall3 %>%
  group_by(Category, author) %>%
  arrange(year_extracted) %>%  # Order by extracted year
  ungroup()

biomall3_ordered <- biomall3_ordered %>%
  mutate(year_factor = factor(year, levels = sort(unique(year))))

# Order the data by year WITHIN each Category and quant.author
biomall3_ordered <- biomall3_ordered %>%
  group_by(Category, quant.author) %>%  
  arrange(year_extracted) %>%           
  ungroup()

# Convert year to factor (after ordering!)
biomall3_ordered <- biomall3_ordered %>%
  mutate(year_factor = factor(year, levels = unique(year)))

# extracting catch to add as area 
ct<-filter(biomall3_ordered,author=="Total catch")
biomall4<-filter(biomall3_ordered,author!="Total catch")

# Order factor (author) as desired
biomall4$author<-factor(biomall4$author,levels=c(
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

# biomass plot
biomall4$quant.author <- factor(biomall4$quant.author, levels=unique(biomall4$quant.author))

Burg24 <- paletteer_c("grDevices::Burg", 25, direction=-1)
BlueTeal24 <- paletteer_c("ggthemes::Blue-Teal", 24, direction=1)
colores <- c(Burg24, BlueTeal24)
autmsy <- append(levels(biomall4$author)[!grepl("biomass", levels(biomall4$author))],"")
autbiom <- append(levels(biomall4$author)[!grepl("MSY", levels(biomall4$author))],"Present study (MSY)",25)
leglab <- c(autbiom, autmsy)

# the plot

biom<-ggplot() +
  geom_area(data=ct, aes(year, y=ton/1000, fill=Category),color="grey30",fill="grey80") +
  geom_line(data=biomall4[!grepl("MSY.", biomall4$quant.author),], aes(x = year, y = ton/1000, color = quant.author, group = quant.author), linewidth=1.25) +
  geom_line(data=biomall4[grepl("MSY.", biomall4$quant.author),], aes(x = year, y = ton/1000, color = quant.author, group = quant.author), linewidth=1.25) +
  scale_y_continuous(expand = c(0, 0), breaks = seq(0, 500, 25)) +
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
    axis.text.x=element_blank(),
    axis.text=element_text(size=14, face="bold")
  ) +
  add_fishape(family="Serranidae",
              option="Epinephelus_merra",
              xmin=2015,xmax=2023,ymin=250,ymax=300,
              fill=fish(option="Epinephelus_striatus",n=3)[2],
              alpha=0.8
  ) + ggtitle("a)")

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

# this line creates figure 3

ggarrange(biom,biotrend,align="hv",ncol=1,nrow=2,
          common.legend=TRUE,legend=c("right"))
