#-----------------------------------------------------------------------------
# CMSY & BSM for red grouper results comparison
#-----------------------------------------------------------------------------

library(datalimited2)

# historical catches as with SS3 (1950-2023)
hist<-read.csv("C:/Kraken/MeroPYuc/SS3_Input_data/catchess3_4flt_new.csv",sep=",",header=TRUE)
hist$total<-hist$Fleet_1+hist$Fleet_2+hist$Fleet_3+hist$Fleet_4

out3<-cmsy2(year=hist$Year,catch=hist$total,resilience="Medium",
            r.low=0.1,r.hi=0.6,stb.low=NA,stb.hi=NA,
            int.yr=NA,intb.low=NA,intb.hi=NA,endb.low=NA,endb.hi=NA,verbose=TRUE)

plot_dlm(out3)
out3$ref_pts
cmsyfull<-out3$ref_ts

# historical catches as IMIPAS (1986->)
histi<-filter(hist,Year>=1986)
out4<-cmsy2(year=histi$Year,catch=histi$total,resilience="Medium",
            r.low=NA,r.hi=NA,stb.low=NA,stb.hi=NA,
            int.yr=NA,intb.low=NA,intb.hi=NA,endb.low=NA,endb.hi=NA,verbose=TRUE)

plot_dlm(out4)
out4$ref_pts
cmsy86<-out4$ref_ts

# Optimized catch only model (ocom) Zhou et al 2017 

out5<-ocom(year=hist$Year,catch=hist$total,m=0.2)
out6<-ocom(year=histi$Year,catch=histi$total,m=0.2)
plot_dlm(out5)
out5$ref_pt
ocomres<-out5$ref_ts
ocomres2<-out6$ref_ts #run with histi dataframe

# kobe plots

okombe <- ggplot(data = ocomres, aes(x = bbmsy, y = ffmsy, colour = year, label = year))+
  geom_rect(aes(xmin = 0, xmax = 1, ymin = 0, ymax = 1), 
            fill="lightgoldenrod1", col = "lightgoldenrod1",alpha = 0.2) +
  geom_rect(aes(xmin = 1, xmax = 2.2, ymin = 1, ymax = 3), 
            fill="#FFB960", col = "#FFB960",alpha = 0.2) +
  geom_rect(aes(xmin = 0, xmax = 1, ymin = 1, ymax = 3), 
            fill="indianred1", col = "indianred1",alpha = 0.2) +
  geom_rect(aes(xmin = 1, xmax = 2.2, ymin = 0, ymax = 1), 
            fill="palegreen", col = "palegreen",alpha = 0.2) +
  geom_point(show.legend = FALSE, size=2, alpha=0.7) +
  geom_hline(yintercept = 1) +
  geom_vline(xintercept = 1) +
  expand_limits(y = 0, x = c(0, 1.01)) + 
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
  geom_segment(aes(x = ocomres$bbmsy[nrow(ocomres)] + tmp[tmp$Label=="Bratio_2023","StdDev"], 
                   xend = ocomres$bbmsy[nrow(ocomres)] - tmp[tmp$Label=="Bratio_2023","StdDev"], 
                   y = ocomres$ffmsy[nrow(ocomres)], yend = ocomres$ffmsy[nrow(ocomres)]), col="grey", size=1) +
  geom_segment(aes(x = ocomres$bbmsy[nrow(ocomres)], xend = ocomres$bbmsy[nrow(ocomres)], 
                   y = ocomres$ffmsy[nrow(ocomres)] + tmp[tmp$Label=="F_2023","StdDev"], 
                   yend = ocomres$ffmsy[nrow(ocomres)] - tmp[tmp$Label=="F_2023","StdDev"]), col="grey", size=1) +
  annotate("point", x = ocomres$bbmsy[nrow(ocomres)], y = ocomres$ffmsy[nrow(ocomres)], size=2, colour = "grey")

okombe2 <- ggplot(data = ocomres2, aes(x = bbmsy, y = ffmsy, colour = year, label = year))+
  geom_rect(aes(xmin = 0, xmax = 1, ymin = 0, ymax = 1), 
            fill="lightgoldenrod1", col = "lightgoldenrod1",alpha = 0.2) +
  geom_rect(aes(xmin = 1, xmax = 2.2, ymin = 1, ymax = 3), 
            fill="#FFB960", col = "#FFB960",alpha = 0.2) +
  geom_rect(aes(xmin = 0, xmax = 1, ymin = 1, ymax = 3), 
            fill="indianred1", col = "indianred1",alpha = 0.2) +
  geom_rect(aes(xmin = 1, xmax = 2.2, ymin = 0, ymax = 1), 
            fill="palegreen", col = "palegreen",alpha = 0.2) +
  geom_point(show.legend = FALSE, size=2, alpha=0.7) +
  geom_hline(yintercept = 1) +
  geom_vline(xintercept = 1) +
  expand_limits(y = 0, x = c(0, 1.01)) + 
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
  geom_segment(aes(x = ocomres2$bbmsy[nrow(ocomres2)] + tmp[tmp$Label=="Bratio_2023","StdDev"], 
                   xend = ocomres2$bbmsy[nrow(ocomres2)] - tmp[tmp$Label=="Bratio_2023","StdDev"], 
                   y = ocomres2$ffmsy[nrow(ocomres2)], yend = ocomres2$ffmsy[nrow(ocomres2)]), col="grey", size=1) +
  geom_segment(aes(x = ocomres2$bbmsy[nrow(ocomres2)], xend = ocomres2$bbmsy[nrow(ocomres2)], 
                   y = ocomres2$ffmsy[nrow(ocomres2)] + tmp[tmp$Label=="F_2023","StdDev"], 
                   yend = ocomres2$ffmsy[nrow(ocomres2)] - tmp[tmp$Label=="F_2023","StdDev"]), col="grey", size=1) +
  annotate("point", x = ocomres2$bbmsy[nrow(ocomres2)], y = ocomres2$ffmsy[nrow(ocomres2)], size=2, colour = "grey")


cmsykobe <- ggplot(data = cmsyfull, aes(x = bbmsy, y = ffmsy, colour = year, label = year))+
  geom_rect(aes(xmin = 0, xmax = 1, ymin = 0, ymax = 1), 
            fill="lightgoldenrod1", col = "lightgoldenrod1",alpha = 0.2) +
  geom_rect(aes(xmin = 1, xmax = 2.2, ymin = 1, ymax = 3), 
            fill="#FFB960", col = "#FFB960",alpha = 0.2) +
  geom_rect(aes(xmin = 0, xmax = 1, ymin = 1, ymax = 3), 
            fill="indianred1", col = "indianred1",alpha = 0.2) +
  geom_rect(aes(xmin = 1, xmax = 2.2, ymin = 0, ymax = 1), 
            fill="palegreen", col = "palegreen",alpha = 0.2) +
  geom_point(show.legend = FALSE, size=2, alpha=0.7) +
  geom_hline(yintercept = 1) +
  geom_vline(xintercept = 1) +
  expand_limits(y = 0, x = c(0, 1.01)) + 
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
  geom_segment(aes(x = cmsyfull$bbmsy[nrow(cmsyfull)] + tmp[tmp$Label=="Bratio_2023","StdDev"], 
                   xend = cmsyfull$bbmsy[nrow(cmsyfull)] - tmp[tmp$Label=="Bratio_2023","StdDev"], 
                   y = cmsyfull$ffmsy[nrow(cmsyfull)], yend = cmsyfull$ffmsy[nrow(cmsyfull)]), col="grey", size=1) +
  geom_segment(aes(x = cmsyfull$bbmsy[nrow(cmsyfull)], xend = cmsyfull$bbmsy[nrow(cmsyfull)], 
                   y = cmsyfull$ffmsy[nrow(cmsyfull)] + tmp[tmp$Label=="F_2023","StdDev"], 
                   yend = cmsyfull$ffmsy[nrow(cmsyfull)] - tmp[tmp$Label=="F_2023","StdDev"]), col="grey", size=1) +
  annotate("point", x = cmsyfull$bbmsy[nrow(cmsyfull)], y = cmsyfull$ffmsy[nrow(cmsyfull)], size=2, colour = "grey")


cmsykobe2 <- ggplot(data = cmsy86, aes(x = bbmsy, y = ffmsy, colour = year, label = year))+
  geom_rect(aes(xmin = 0, xmax = 1, ymin = 0, ymax = 1), 
            fill="lightgoldenrod1", col = "lightgoldenrod1",alpha = 0.2) +
  geom_rect(aes(xmin = 1, xmax = 2.2, ymin = 1, ymax = 3), 
            fill="#FFB960", col = "#FFB960",alpha = 0.2) +
  geom_rect(aes(xmin = 0, xmax = 1, ymin = 1, ymax = 3), 
            fill="indianred1", col = "indianred1",alpha = 0.2) +
  geom_rect(aes(xmin = 1, xmax = 2.2, ymin = 0, ymax = 1), 
            fill="palegreen", col = "palegreen",alpha = 0.2) +
  geom_point(show.legend = FALSE, size=2, alpha=0.7) +
  geom_hline(yintercept = 1) +
  geom_vline(xintercept = 1) +
  expand_limits(y = 0, x = c(0, 1.01)) + 
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
  geom_segment(aes(x = cmsy86$bbmsy[nrow(cmsy86)] + tmp[tmp$Label=="Bratio_2023","StdDev"], 
                   xend = cmsy86$bbmsy[nrow(cmsy86)] - tmp[tmp$Label=="Bratio_2023","StdDev"], 
                   y = cmsy86$ffmsy[nrow(cmsy86)], yend = cmsy86$ffmsy[nrow(cmsy86)]), col="grey", size=1) +
  geom_segment(aes(x = cmsy86$bbmsy[nrow(cmsy86)], xend = cmsy86$bbmsy[nrow(cmsy86)], 
                   y = cmsy86$ffmsy[nrow(cmsy86)] + tmp[tmp$Label=="F_2023","StdDev"], 
                   yend = cmsy86$ffmsy[nrow(cmsy86)] - tmp[tmp$Label=="F_2023","StdDev"]), col="grey", size=1) +
  annotate("point", x = cmsy86$bbmsy[nrow(cmsy86)], y = cmsy86$ffmsy[nrow(cmsy86)], size=2, colour = "grey")

# IMIPAS National fisheries act 2022 kobe plot
imipask<-c()
imipask$year<-c(seq(1986,2020,by=1))
imipask$bbmsy<-c(2,1.75,1.55,1.35,1.25,1.2,0.98,0.88,0.82,0.76,0.66,0.64,0.62,0.6,
                 0.57,0.59,0.6,0.64,0.64,0.68,0.7,0.68,0.58,0.56,0.52,0.56,0.57,
                 0.5,0.46,0.48,0.44,0.44,0.42,0.44,0.5)
imipask$ffmsy<-c(0.62,0.88,1.1,1.08,1.2,1.44,1.5,1.42,1.64,1.78,1.32,1.1,1.3,1.08,1.22,
                 1.62,1.42,1.76,1.44,1.38,1.3,1.52,1.62,1.86,1.6,1.28,1.96,1.84,1.42,
                 1.76,1.6,1.56,1.34,1.38,1.26)
imipask<-as.data.frame(imipask)

imik <- ggplot(data = imipask, aes(x = bbmsy, y = ffmsy, colour = year, label = year))+
  geom_rect(aes(xmin = 0, xmax = 1, ymin = 0, ymax = 1), 
            fill="lightgoldenrod1", col = "lightgoldenrod1",alpha = 0.2) +
  geom_rect(aes(xmin = 1, xmax = 2.2, ymin = 1, ymax = 3), 
            fill="#FFB960", col = "#FFB960",alpha = 0.2) +
  geom_rect(aes(xmin = 0, xmax = 1, ymin = 1, ymax = 3), 
            fill="indianred1", col = "indianred1",alpha = 0.2) +
  geom_rect(aes(xmin = 1, xmax = 2.2, ymin = 0, ymax = 1), 
            fill="palegreen", col = "palegreen",alpha = 0.2) +
  geom_point(show.legend = FALSE, size=2, alpha=0.7) +
  geom_hline(yintercept = 1) +
  geom_vline(xintercept = 1) +
  expand_limits(y = 0, x = c(0, 1.01)) + 
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
  geom_segment(aes(x = imipask$bbmsy[nrow(imipask)] + tmp[tmp$Label=="Bratio_2023","StdDev"], 
                   xend = imipask$bbmsy[nrow(imipask)] - tmp[tmp$Label=="Bratio_2023","StdDev"], 
                   y = imipask$ffmsy[nrow(imipask)], yend = imipask$ffmsy[nrow(imipask)]), col="grey", size=1) +
  geom_segment(aes(x = imipask$bbmsy[nrow(imipask)], xend = imipask$bbmsy[nrow(imipask)], 
                   y = imipask$ffmsy[nrow(imipask)] + tmp[tmp$Label=="F_2023","StdDev"], 
                   yend = imipask$ffmsy[nrow(imipask)] - tmp[tmp$Label=="F_2023","StdDev"]), col="grey", size=1) +
  annotate("point", x = imipask$bbmsy[nrow(imipask)], y = imipask$ffmsy[nrow(imipask)], size=2, colour = "grey")

# sskobe plot is created in the SS code but plotted with the others for comparisson 
ggarrange(sskobe,cmsykobe,okombe,imik,cmsykobe2,okombe2,align="hv",ncol=3,nrow=2)