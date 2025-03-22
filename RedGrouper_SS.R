#------------------------------------------------------------------------
# Running SS3 for red grouper data
#------------------------------------------------------------------------

library("r4ss")

# download folder Red_grouper_SS from 
# https://drive.google.com/drive/folders/13OtdcZ6tPKqj3jqKDzxgdv-S7MrAns3a?usp=drive_link

wd <- "your drive:/Red_grouper_SS/FirstModel_base"
setwd(wd) 

# run SS from R
system("./ss3 -hess") # add/remove -hess to calculate hessian

# read the model outputs and print diagnostic messages 
Out <- SS_output(dir = "your drive:/Red_grouper_SS/FirstModel_base")
# plot the results
SS_plots(Out)

# kobe plot with b/bmsy & F/Fmsy

dta <- Out$Kobe
tmp <- Out$derived_quants

ggplot(data = dta, aes(x = B.Bmsy, y = F.Fmsy, colour = Yr, label = Yr))+
  geom_rect(aes(xmin = 0, xmax = 1, ymin = 0, ymax = 1), 
            fill="lightgoldenrod1", col = "lightgoldenrod1",alpha = 0.2) +
  geom_rect(aes(xmin = 1, xmax = 5.5, ymin = 1, ymax = 3), 
            fill="#FFB960", col = "#FFB960",alpha = 0.2) +
  geom_rect(aes(xmin = 0, xmax = 1, ymin = 1, ymax = 3), 
            fill="indianred1", col = "indianred1",alpha = 0.2) +
  geom_rect(aes(xmin = 1, xmax = 5.5, ymin = 0, ymax = 1), 
            fill="palegreen", col = "palegreen",alpha = 0.2) +
  geom_point(show.legend = FALSE, size=2, alpha=0.7) +
  geom_hline(yintercept = 1) +
  geom_vline(xintercept = 1) +
  expand_limits(y = 0, x = c(0, 1.01)) + 
  scale_y_continuous(expand = c(0, 0), breaks = seq(0, 3.5, 0.5)) +
  scale_x_continuous(expand = c(0, 0), breaks = seq(0, 5.5, 0.5)) +
  labs(x = expression(B/B[MSY]), y = expression(F/F[MSY])) +
  scale_colour_gradient(low = "gray60", high = "gray1") +
  #scale_color_gradientn(colours = rainbow(10)) +
  theme(panel.background = element_blank(), 
        panel.border = element_rect(colour = "black", fill=NA),legend.position = "none") + 
  geom_text(hjust=0, vjust=0,check_overlap=TRUE) + 
  geom_segment(aes(x = B.Bmsy, y = F.Fmsy, colour = Yr, xend = lead(B.Bmsy), 
                   yend = lead(F.Fmsy)), arrow = arrow(length = unit(0.2,"cm"))) +
  geom_segment(aes(x = dta$B.Bmsy[nrow(dta)] + tmp[tmp$Label=="Bratio_2023","StdDev"], 
                   xend = dta$B.Bmsy[nrow(dta)] - tmp[tmp$Label=="Bratio_2023","StdDev"], 
                   y = dta$F.Fmsy[nrow(dta)], yend = dta$F.Fmsy[nrow(dta)]), col="grey", size=1) +
  geom_segment(aes(x = dta$B.Bmsy[nrow(dta)], xend = dta$B.Bmsy[nrow(dta)], 
                   y = dta$F.Fmsy[nrow(dta)] + tmp[tmp$Label=="F_2023","StdDev"], 
                   yend = dta$F.Fmsy[nrow(dta)] - tmp[tmp$Label=="F_2023","StdDev"]), col="grey", size=1) +
  annotate("point", x = dta$B.Bmsy[nrow(dta)], y = dta$F.Fmsy[nrow(dta)], size=2, colour = "grey")

#---------------------------------------------------------------------------------
# sskobe shown in paper comes from this code:
#---------------------------------------------------------------------------------

wd <- "your drive:/Red_grouper_SS/Scenario_3"
setwd(wd) 

# run SS from R
system("./ss3 ")

# read the model outputs and print diagnostic messages 
Out3 <- SS_output(dir = "your drive:/Red_grouper_SS/Scenario_3")
# plot the results
SS_plots(Out3)

# kobe plot with b/bmsy & F/Fmsy

dta <- Out3$Kobe
tmp <- Out3$derived_quants

sskobe <- ggplot(data = dta, aes(x = B.Bmsy, y = F.Fmsy, colour = Yr, label = Yr))+
  geom_rect(aes(xmin = 0, xmax = 1, ymin = 0, ymax = 1), 
            fill="lightgoldenrod1", col = "lightgoldenrod1",alpha = 0.2) +
  geom_rect(aes(xmin = 1, xmax = 5, ymin = 1, ymax = 5.5), 
            fill="#FFB960", col = "#FFB960",alpha = 0.2) +
  geom_rect(aes(xmin = 0, xmax = 1, ymin = 1, ymax = 5.5), 
            fill="indianred1", col = "indianred1",alpha = 0.2) +
  geom_rect(aes(xmin = 1, xmax = 5, ymin = 0, ymax = 1), 
            fill="palegreen", col = "palegreen",alpha = 0.2) +
  geom_point(show.legend = FALSE, size=2, alpha=0.7) +
  geom_hline(yintercept = 1) +
  geom_vline(xintercept = 1) +
  expand_limits(y = 0, x = c(0, 1.01)) + 
  scale_y_continuous(expand = c(0, 0), breaks = seq(0, 5.5, 0.5)) +
  scale_x_continuous(expand = c(0, 0), breaks = seq(0, 5, 0.5)) +
  labs(x = expression(B/B[MSY]), y = expression(F/F[MSY])) +
  scale_colour_gradient(low = "gray60", high = "gray1") +
  #scale_color_gradientn(colours = rainbow(10)) +
  theme(panel.background = element_blank(), 
        panel.border = element_rect(colour = "black", fill=NA),legend.position = "none") + 
  geom_text(hjust=0, vjust=0,check_overlap=TRUE) + 
  geom_segment(aes(x = B.Bmsy, y = F.Fmsy, colour = Yr, xend = lead(B.Bmsy), 
                   yend = lead(F.Fmsy)), arrow = arrow(length = unit(0.2,"cm"))) +
  geom_segment(aes(x = dta$B.Bmsy[nrow(dta)] + tmp[tmp$Label=="Bratio_2023","StdDev"], 
                   xend = dta$B.Bmsy[nrow(dta)] - tmp[tmp$Label=="Bratio_2023","StdDev"], 
                   y = dta$F.Fmsy[nrow(dta)], yend = dta$F.Fmsy[nrow(dta)]), col="grey", size=1) +
  geom_segment(aes(x = dta$B.Bmsy[nrow(dta)], xend = dta$B.Bmsy[nrow(dta)], 
                   y = dta$F.Fmsy[nrow(dta)] + tmp[tmp$Label=="F_2023","StdDev"], 
                   yend = dta$F.Fmsy[nrow(dta)] - tmp[tmp$Label=="F_2023","StdDev"]), col="grey", size=1) +
  annotate("point", x = dta$B.Bmsy[nrow(dta)], y = dta$F.Fmsy[nrow(dta)], size=2, colour = "grey")

#-----------------------------------------------------------------
# model comparisons (Suplementary material S2)
#-----------------------------------------------------------------

wd <- "your drive:/Red_grouper_SS/"
setwd(wd)

# read the model outputs and print diagnostic messages 
Out <- SS_output(dir = paste(wd,"FirstModel_Base",sep="/")) 
# plot the results
#SS_plots(Out, forecastplot = TRUE)


Out1 <- SS_output(dir = paste(wd,"Scenario_1",sep="/")) 
Out2 <- SS_output(dir = paste(wd,"Scenario_2",sep="/")) 
Out3 <- SS_output(dir=paste(wd,"Scenario_3",sep="/"))
Out4 <- SS_output(dir=paste(wd,"Scenario_4",sep="/"))
Out5 <- SS_output(dir=paste(wd,"Scenario_5",sep="/"))
Out6 <- SS_output(dir=paste(wd,"Scenario_6",sep="/"))

comparison.list <- list(Out, Out1, Out2, Out3, Out4,Out5,Out6)
comparison.summary <- SSsummarize(biglist = comparison.list )
SSplotComparisons(summaryoutput = comparison.summary, shadeForecast = TRUE, pdf=TRUE, plotdir = getwd(),
                  legendlabels = c("Base","Scenario 1","Scenario 2","Scenario 3","Scenario 4","Scenario 5","Scenario 6"))