#------------------------------------------------------------------------------
# ICESJMS-2025-117 Red grouper fishery daily records
#------------------------------------------------------------------------------
# load libraries

suppressPackageStartupMessages({
  library(spict)
  library(sraplus)
  library(ggplot2)
  library(fishualize)
  library(viridis)
  library(viridisLite)
  library(RColorBrewer)
  library(dplyr)
  library(forcats)
  library(ggpubr)
  library(ggdist)
  library(ggdensity)
  library(ggrepel)
  library(ggside)
  library(ggpmisc)
  library(hexbin)
  library(tidyquant)
  library(tidyverse)
  library(boot)
  library(patchwork)
  library(gghighlight)
  library(performance)
  library(report)
  library(brms)
  library(rstanarm)
  library(glmmTMB)
  library(sf)
  library(ggalluvial)
  library(ggsankey)
  library(relaimpo)
  library(CausalImpact)
  library(lubridate)
  library(rgdal)
  library(sp)
  library(maps)
  library(tmap)
  library(tmaptools)
  library(leaflet)
  library(spatstat)
  library(ggblend)
  library(marmap)
  library(raster)
  library(rasterVis)
  library(geodata)
  library(ncdf4)
  library(reshape2)
  library(stringr)
  library(grid)
  library(gridExtra)
  library(ggspatial)
  library(tidyplots)
  library(paletteer)
  library(packrat)
  library(grateful)
})

# load data
emorio<-read.csv("redgrouper0022.csv",sep=",",header=TRUE)

# check data
head(emorio)
summary(emorio)

# aggregate data by year, fleet, site and daysworked
morio <- aggregate(emorio[,"year"],by=list(year=emorio$year,Fleet=emorio$fleet,Site=emorio$Site),length) 
#rename columns
names(morio) <- c("year","Fleet","Site","dw") 
morio

# total vessels a year per site
tmps <- aggregate(emorio[,c("ton","est.vessels")],by=list(year=emorio$year,Fleet=emorio$fleet,Site=emorio$Site), sum, na.rm=TRUE)
# merge objects by year
morio <- merge(morio,tmps,by=c("year","Fleet","Site"))     
morio

# effective fishing days
edw<-as.data.frame(emorio%>%group_by(year,fleet,Site)%>%summarize(n_unique=n_distinct(day)))
names(edw)<-c("year","Fleet","Site","ewd")
morio <- merge(morio,edw,by=c("year","Fleet","Site"))     
morio

# add effort in hooks
morio$hooks<-as.numeric(ifelse(morio$Fleet=="artisanal","150",ifelse(morio$Fleet=="mid.range","1500",0)))

# nominal effort as hooks per vessel per day
morio$effort<-morio$est.vessels*morio$ewd*morio$hooks

# year-site CPUE in a new column
morio$CPUE <- morio$ton/morio$effort

morio

# Nobs (months a year), catch, effort per year per fleet
mysumlf <- aggregate(morio[,"year"],by=list(year=morio$year,fleet=morio$Fleet),length) 
#rename columns
names(mysumlf) <- c("year","fleet","Nobs") 
mysumlf

# total of days worked per vessel in a year
tmpf <- aggregate(morio[,c("ton","effort")],by=list(year=morio$year,fleet=morio$Fleet), sum, na.rm=TRUE)
# merge objects by year
mysumlf <- merge(mysumlf,tmpf,by=c("year","fleet"))     
mysumlf
# year CPUE in a new column
mysumlf$CPUE <- mysumlf$ton/mysumlf$effort
mysumlf
# as no there was no fishing in 2002 by mid.range (Hurricane Isidoro), we averaged cpue 2001-2003
mysumlf[6,"CPUE"]<-2.450666666666667e-5 

# Nobs (months a year), catch, effort per year
mysuml <- aggregate(morio[,"year"],by=list(year=morio$year),length) 
#rename columns
names(mysuml) <- c("year","Nobs") 
mysuml

# total of days worked per vessel in a year
tmp <- aggregate(morio[,c("ton","effort")],by=list(year=morio$year), sum, na.rm=TRUE)
# merge objects by year
mysum <- merge(mysuml,tmp,by="year")     
mysum
# year CPUE in a new column
mysum$CPUE <- mysum$ton/mysum$effort
mysum
# as no there was no fishing in 2002 by mid.range (Hurricane Isidoro), we averaged cpue & effort 2001-2003
mysum[3,"CPUE"]<-3.306666666666667e-5
mysum[3,"effort"]<-224127850

# separate fleets to create plot  
midr<-filter(mysumlf,fleet=="mid.range")
artis<-filter(mysumlf,fleet=="artisanal")

# CPUE dataframe (data was used in SPiCt and SRAplus runs, not shown)
cpues<-cbind(year=midr$year,cpue_mid=midr$CPUE,cpue_art=artis$CPUE)
cpues<-as.data.frame(cpues)
cpues[3,"cpue_mid"]<-2.450666666666667e-5

# plot CPUE mid.range & artisanal (standardized by mean)
colors <- c("mid.range CPUE" = "firebrick", "artisanal CPUE" = "dodgerblue2")

ggplot(cpues) +
  geom_ribbon(size = 0.8, fill = "firebrick",alpha=0.2, 
              aes(x=year, y=cpue_mid/mean(cpue_mid),ymin = (cpue_mid-sd(cpue_mid))/mean(cpue_mid), ymax = (cpue_mid+sd(cpue_mid))/mean(cpue_mid))) +
  geom_point(aes(x=year, y=cpue_mid/mean(cpue_mid), color = "mid.range CPUE"), size = 3.5) +
  geom_line(aes(x=year, y=cpue_mid/mean(cpue_mid), color="mid.range CPUE"), linewidth = 0.8) + 
  geom_point(aes(x=year, y=cpue_art/mean(cpue_art), color = "artisanal CPUE"), size = 3.5) +
  geom_line(aes(x=year, y=cpue_art/mean(cpue_art), color="artisanal CPUE"), linewidth = 0.8)+
  geom_ribbon(size = 0.8, fill = "dodgerblue2",alpha=0.2,aes(x=year, y=cpue_art/mean(cpue_art), ymin = (cpue_art-sd(cpue_art))/mean(cpue_art), ymax = (cpue_art+sd(cpue_art))/mean(cpue_art))) +
  labs(x = "year",
       y = "Index of relative abundance",
       color = "Fleet") + 
  scale_color_manual(values = colors)+theme_bw()

# this cpue was used as input in implementation of SS
# end of code
#-------------------------------------------------------------------------------------------------
