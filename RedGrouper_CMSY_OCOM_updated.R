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
plot_dlm(out6)

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

#-----------------------------------------------------------
# CMSY & OCOM diagnostics
#-----------------------------------------------------------

# Check column names in ref_ts
cat("Columns in ref_ts:\n")
print(names(out3$ref_ts))
print("\nFirst few rows:\n")
print(head(out3$ref_ts))

# Create diagnostic plots with correct column names
par(mfrow = c(2, 2))

# 1. Biomass trajectory relative to BMSY
plot(out3$ref_ts$year, out3$ref_ts$bbmsy,
     type = "l", lwd = 2,
     xlab = "Year", ylab = "B/BMSY",
     main = "Biomass relative to BMSY",
     ylim = c(0, max(out3$ref_ts$bbmsy, na.rm = TRUE) * 1.1))
abline(h = 1, col = "red", lty = 2, lwd = 2)
abline(h = 0.5, col = "orange", lty = 2)
legend("topright", 
       legend = c("B/BMSY", "Target (1.0)", "Limit (0.5)"),
       lty = c(1, 2, 2), 
       col = c("black", "red", "orange"), 
       lwd = c(2, 2, 1))
grid()

# 2. Fishing mortality relative to FMSY
plot(out3$ref_ts$year, out3$ref_ts$ffmsy,
     type = "l", lwd = 2,
     xlab = "Year", ylab = "F/FMSY",
     main = "Fishing mortality relative to FMSY",
     ylim = c(0, max(out3$ref_ts$ffmsy, na.rm = TRUE) * 1.1))
abline(h = 1, col = "red", lty = 2, lwd = 2)
legend("topright", 
       legend = c("F/FMSY", "Target (1.0)"),
       lty = c(1, 2), 
       col = c("black", "red"), 
       lwd = c(2, 2))
grid()

# 3. Observed vs Predicted catch
plot(hist$Year, hist$total,
     type = "p", pch = 19,
     xlab = "Year", ylab = "Catch",
     main = "Observed vs Predicted Catch",
     ylim = c(0, max(c(hist$total, out3$ref_ts$ct_pred), na.rm = TRUE) * 1.1))
lines(out3$ref_ts$year, out3$ref_ts$catch_ma, col = "blue", lwd = 2)
legend("topleft", 
       legend = c("Observed", "Predicted"),
       pch = c(19, NA), 
       lty = c(NA, 1), 
       col = c("black", "blue"))
grid()

# 4. Residuals
residuals <- hist$total - out3$ref_ts$catch_ma
plot(hist$Year, residuals,
     type = "h", lwd = 2,
     xlab = "Year", ylab = "Residuals",
     main = "Catch Residuals")
abline(h = 0, col = "red", lty = 2)
grid()

par(mfrow = c(1, 1))

# Calculate residuals
residuals <- hist$total - out3$ref_ts$catch_ma
relative_residuals <- residuals / hist$total

# Summary statistics
cat("\n=== Residual Diagnostics ===\n")
cat("Mean residual:", round(mean(residuals, na.rm = TRUE), 2), "\n")
cat("SD of residuals:", round(sd(residuals, na.rm = TRUE), 2), "\n")
cat("Mean absolute relative error:", round(mean(abs(relative_residuals), na.rm = TRUE) * 100, 2), "%\n")
cat("RMSE:", round(sqrt(mean(residuals^2, na.rm = TRUE)), 2), "\n")

# Residual diagnostic plots
par(mfrow = c(2, 2))

# Histogram of residuals
hist(residuals, breaks = 20,
     main = "Distribution of Residuals",
     xlab = "Residuals",
     col = "lightblue",
     border = "white")
abline(v = 0, col = "red", lwd = 2, lty = 2)

# Q-Q plot for normality
qqnorm(residuals, main = "Q-Q Plot of Residuals")
qqline(residuals, col = "red", lwd = 2)

# Residuals vs fitted
plot(out3$ref_ts$catch_ma, residuals,
     xlab = "Predicted Catch", ylab = "Residuals",
     main = "Residuals vs Fitted",
     pch = 19)
abline(h = 0, col = "red", lty = 2, lwd = 2)
grid()

# Autocorrelation
acf(residuals, main = "Autocorrelation of Residuals")

par(mfrow = c(1, 1))

# Calculate final year values first
final_b_bmsy <- tail(out3$ref_ts$bbmsy, 1)
final_f_fmsy <- tail(out3$ref_ts$ffmsy, 1)
final_year <- tail(out3$ref_ts$year, 1)


# Comprehensive Summary Report
cat("\n========================================\n")
cat("CMSY MODEL DIAGNOSTIC SUMMARY\n")
cat("========================================\n\n")

cat("Reference Points:\n")
for(i in 1:nrow(out3$ref_pts)) {
  param_name <- out3$ref_pts$param[i]
  est <- out3$ref_pts$est[i]
  lo <- out3$ref_pts$lo[i]
  hi <- out3$ref_pts$hi[i]
  cat(sprintf("  %s: %.4f (%.4f - %.4f)\n", param_name, est, lo, hi))
}

cat("\nCurrent Stock Status (Final Year:", tail(out3$ref_ts$year, 1), "):\n")
cat("  B/BMSY:", round(final_b_bmsy, 2), "\n")
cat("  F/FMSY:", round(final_f_fmsy, 2), "\n")

if (final_b_bmsy < 0.5) {
  cat("  Status: CRITICALLY OVERFISHED\n")
} else if (final_b_bmsy < 1) {
  cat("  Status: OVERFISHED\n")
} else {
  cat("  Status: NOT OVERFISHED\n")
}

if (final_f_fmsy > 1) {
  cat("  Fishing: OVERFISHING OCCURRING\n")
} else {
  cat("  Fishing: SUSTAINABLE\n")
}

cat("\nModel Fit:\n")
cat("  RMSE:", round(sqrt(mean(residuals^2, na.rm = TRUE)), 2), "\n")
cat("  Mean Absolute % Error:", round(mean(abs(relative_residuals), na.rm = TRUE) * 100, 2), "%\n")
cat("  Mean residual:", round(mean(residuals, na.rm = TRUE), 2), "\n")

cat("\n========================================\n")

#-------------------------------------------------------------
# with short catch history
#-------------------------------------------------------------

# Check column names in ref_ts
cat("Columns in ref_ts:\n")
print(names(out4$ref_ts))
print("\nFirst few rows:\n")
print(head(out4$ref_ts))

# Create diagnostic plots with correct column names
par(mfrow = c(2, 2))

# 1. Biomass trajectory relative to BMSY
plot(out4$ref_ts$year, out4$ref_ts$bbmsy,
     type = "l", lwd = 2,
     xlab = "Year", ylab = "B/BMSY",
     main = "Biomass relative to BMSY",
     ylim = c(0, max(out4$ref_ts$bbmsy, na.rm = TRUE) * 1.1))
abline(h = 1, col = "red", lty = 2, lwd = 2)
abline(h = 0.5, col = "orange", lty = 2)
legend("topright", 
       legend = c("B/BMSY", "Target (1.0)", "Limit (0.5)"),
       lty = c(1, 2, 2), 
       col = c("black", "red", "orange"), 
       lwd = c(2, 2, 1))
grid()

# 2. Fishing mortality relative to FMSY
plot(out4$ref_ts$year, out4$ref_ts$ffmsy,
     type = "l", lwd = 2,
     xlab = "Year", ylab = "F/FMSY",
     main = "Fishing mortality relative to FMSY",
     ylim = c(0, max(out4$ref_ts$ffmsy, na.rm = TRUE) * 1.1))
abline(h = 1, col = "red", lty = 2, lwd = 2)
legend("topright", 
       legend = c("F/FMSY", "Target (1.0)"),
       lty = c(1, 2), 
       col = c("black", "red"), 
       lwd = c(2, 2))
grid()

# 3. Observed vs Predicted catch
plot(histi$Year, histi$total,
     type = "p", pch = 19,
     xlab = "Year", ylab = "Catch",
     main = "Observed vs Predicted Catch",
     ylim = c(0, max(c(hist$total, out4$ref_ts$ct_pred), na.rm = TRUE) * 1.1))
lines(out4$ref_ts$year, out4$ref_ts$catch_ma, col = "blue", lwd = 2)
legend("topleft", 
       legend = c("Observed", "Predicted"),
       pch = c(19, NA), 
       lty = c(NA, 1), 
       col = c("black", "blue"))
grid()

# 4. Residuals
residuals <- histi$total - out4$ref_ts$catch_ma
plot(histi$Year, residuals,
     type = "h", lwd = 2,
     xlab = "Year", ylab = "Residuals",
     main = "Catch Residuals")
abline(h = 0, col = "red", lty = 2)
grid()

par(mfrow = c(1, 1))

# Calculate residuals
residuals <- histi$total - out4$ref_ts$catch_ma
relative_residuals <- residuals / histi$total

# Summary statistics
cat("\n=== Residual Diagnostics ===\n")
cat("Mean residual:", round(mean(residuals, na.rm = TRUE), 2), "\n")
cat("SD of residuals:", round(sd(residuals, na.rm = TRUE), 2), "\n")
cat("Mean absolute relative error:", round(mean(abs(relative_residuals), na.rm = TRUE) * 100, 2), "%\n")
cat("RMSE:", round(sqrt(mean(residuals^2, na.rm = TRUE)), 2), "\n")

# Residual diagnostic plots
par(mfrow = c(2, 2))

# Histogram of residuals
hist(residuals, breaks = 20,
     main = "Distribution of Residuals",
     xlab = "Residuals",
     col = "lightblue",
     border = "white")
abline(v = 0, col = "red", lwd = 2, lty = 2)

# Q-Q plot for normality
qqnorm(residuals, main = "Q-Q Plot of Residuals")
qqline(residuals, col = "red", lwd = 2)

# Residuals vs fitted
plot(out4$ref_ts$catch_ma, residuals,
     xlab = "Predicted Catch", ylab = "Residuals",
     main = "Residuals vs Fitted",
     pch = 19)
abline(h = 0, col = "red", lty = 2, lwd = 2)
grid()

# Autocorrelation
acf(residuals, main = "Autocorrelation of Residuals")

par(mfrow = c(1, 1))

# Calculate final year values first
final_b_bmsy <- tail(out4$ref_ts$bbmsy, 1)
final_f_fmsy <- tail(out4$ref_ts$ffmsy, 1)
final_year <- tail(out4$ref_ts$year, 1)


# Comprehensive Summary Report
cat("\n========================================\n")
cat("CMSY MODEL DIAGNOSTIC SUMMARY\n")
cat("========================================\n\n")

cat("Reference Points:\n")
for(i in 1:nrow(out4$ref_pts)) {
  param_name <- out4$ref_pts$param[i]
  est <- out4$ref_pts$est[i]
  lo <- out4$ref_pts$lo[i]
  hi <- out4$ref_pts$hi[i]
  cat(sprintf("  %s: %.4f (%.4f - %.4f)\n", param_name, est, lo, hi))
}

cat("\nCurrent Stock Status (Final Year:", tail(out4$ref_ts$year, 1), "):\n")
cat("  B/BMSY:", round(final_b_bmsy, 2), "\n")
cat("  F/FMSY:", round(final_f_fmsy, 2), "\n")

if (final_b_bmsy < 0.5) {
  cat("  Status: CRITICALLY OVERFISHED\n")
} else if (final_b_bmsy < 1) {
  cat("  Status: OVERFISHED\n")
} else {
  cat("  Status: NOT OVERFISHED\n")
}

if (final_f_fmsy > 1) {
  cat("  Fishing: OVERFISHING OCCURRING\n")
} else {
  cat("  Fishing: SUSTAINABLE\n")
}

cat("\nModel Fit:\n")
cat("  RMSE:", round(sqrt(mean(residuals^2, na.rm = TRUE)), 2), "\n")
cat("  Mean Absolute % Error:", round(mean(abs(relative_residuals), na.rm = TRUE) * 100, 2), "%\n")
cat("  Mean residual:", round(mean(residuals, na.rm = TRUE), 2), "\n")

cat("\n========================================\n")

#-----------------------------------------------------
# ocom full time series diagnostics
#----------------------------------------------------

out5

# The data is in data frames with specific column names
# Use ref_ts for time series data

par(mfrow = c(2, 2))

# Plot 1: B/BMSY trajectory with confidence intervals
plot(out5$ref_ts$year, out5$ref_ts$bbmsy, type = "l", lwd = 2,
     xlab = "Year", ylab = "B/BMSY",
     main = "Biomass relative to BMSY",
     ylim = range(c(out5$ref_ts$bbmsy_lo, out5$ref_ts$bbmsy_hi)))
lines(out5$ref_ts$year, out5$ref_ts$bbmsy_lo, lty = 2, col = "gray")
lines(out5$ref_ts$year, out5$ref_ts$bbmsy_hi, lty = 2, col = "gray")
polygon(c(out5$ref_ts$year, rev(out5$ref_ts$year)),
        c(out5$ref_ts$bbmsy_lo, rev(out5$ref_ts$bbmsy_hi)),
        col = rgb(0.5, 0.5, 0.5, 0.3), border = NA)
lines(out5$ref_ts$year, out5$ref_ts$bbmsy, lwd = 2)
abline(h = 1, col = "red", lty = 2, lwd = 2)
abline(h = 0.5, col = "orange", lty = 3, lwd = 2)

# Plot 2: F/FMSY trajectory with confidence intervals
plot(out5$ref_ts$year, out5$ref_ts$ffmsy, type = "l", lwd = 2,
     xlab = "Year", ylab = "F/FMSY",
     main = "Fishing mortality relative to FMSY",
     ylim = range(c(out5$ref_ts$ffmsy_lo, out5$ref_ts$ffmsy_hi)))
lines(out5$ref_ts$year, out5$ref_ts$ffmsy_lo, lty = 2, col = "gray")
lines(out5$ref_ts$year, out5$ref_ts$ffmsy_hi, lty = 2, col = "gray")
polygon(c(out5$ref_ts$year, rev(out5$ref_ts$year)),
        c(out5$ref_ts$ffmsy_lo, rev(out5$ref_ts$ffmsy_hi)),
        col = rgb(0.5, 0.5, 0.5, 0.3), border = NA)
lines(out5$ref_ts$year, out5$ref_ts$ffmsy, lwd = 2)
abline(h = 1, col = "red", lty = 2, lwd = 2)

# Plot 3: Biomass trajectory
plot(out5$ref_ts$year, out5$ref_ts$b, type = "l", lwd = 2,
     xlab = "Year", ylab = "Biomass (mt)",
     main = "Estimated Biomass",
     ylim = range(c(out5$ref_ts$b_lo, out5$ref_ts$b_hi)))
lines(out5$ref_ts$year, out5$ref_ts$b_lo, lty = 2, col = "gray")
lines(out5$ref_ts$year, out5$ref_ts$b_hi, lty = 2, col = "gray")
polygon(c(out5$ref_ts$year, rev(out5$ref_ts$year)),
        c(out5$ref_ts$b_lo, rev(out5$ref_ts$b_hi)),
        col = rgb(0.5, 0.5, 0.5, 0.3), border = NA)
lines(out5$ref_ts$year, out5$ref_ts$b, lwd = 2)

# Plot 4: Fishing mortality
plot(out5$ref_ts$year, out5$ref_ts$f, type = "l", lwd = 2,
     xlab = "Year", ylab = "Fishing mortality (F)",
     main = "Estimated Fishing Mortality",
     ylim = range(c(out5$ref_ts$f_lo, out5$ref_ts$f_hi)))
lines(out5$ref_ts$year, out5$ref_ts$f_lo, lty = 2, col = "gray")
lines(out5$ref_ts$year, out5$ref_ts$f_hi, lty = 2, col = "gray")
polygon(c(out5$ref_ts$year, rev(out5$ref_ts$year)),
        c(out5$ref_ts$f_lo, rev(out5$ref_ts$f_hi)),
        col = rgb(0.5, 0.5, 0.5, 0.3), border = NA)
lines(out5$ref_ts$year, out5$ref_ts$f, lwd = 2)

# Kobe plot
par(mfrow = c(1, 1))
plot(out5$ref_ts$bbmsy, out5$ref_ts$ffmsy, type = "n",
     xlim = c(0, max(out5$ref_ts$bbmsy_hi, 2)),
     ylim = c(0, max(out5$ref_ts$ffmsy_hi, 2)),
     xlab = "B/BMSY", ylab = "F/FMSY",
     main = "Kobe Plot - Stock Status")

# Colored quadrants
rect(0, 0, 1, 1, col = rgb(1, 0, 0, 0.2), border = NA)
rect(1, 0, 100, 1, col = rgb(1, 1, 0, 0.2), border = NA)
rect(0, 1, 1, 100, col = rgb(1, 1, 0, 0.2), border = NA)
rect(1, 1, 100, 100, col = rgb(0, 1, 0, 0.2), border = NA)

# Trajectory
lines(out5$ref_ts$bbmsy, out5$ref_ts$ffmsy, lwd = 2, col = "blue")
points(out5$ref_ts$bbmsy, out5$ref_ts$ffmsy, pch = 19, cex = 0.5, col = "blue")

# Highlight start and end
points(out5$ref_ts$bbmsy[1], out5$ref_ts$ffmsy[1], 
       pch = 19, cex = 2, col = "green")
points(tail(out5$ref_ts$bbmsy, 1), tail(out5$ref_ts$ffmsy, 1), 
       pch = 19, cex = 2, col = "red")

# Reference lines
abline(v = 1, h = 1, lty = 2, lwd = 2)

# Labels
text(out5$ref_ts$bbmsy[1], out5$ref_ts$ffmsy[1], 
     labels = out5$ref_ts$year[1], pos = 3, cex = 0.8)
text(tail(out5$ref_ts$bbmsy, 1), tail(out5$ref_ts$ffmsy, 1), 
     labels = tail(out5$ref_ts$year, 1), pos = 3, cex = 0.8)

legend("topright", legend = c("Start", "End", "Trajectory"),
       col = c("green", "red", "blue"), pch = c(19, 19, NA), 
       lty = c(NA, NA, 1), bty = "n")

# Print reference points with quantiles
cat("\n========== OCOM Reference Points ==========\n")
print(out5$ref_pts)
cat("\n")

par(mfrow = c(2, 2))

# Plot viable r-k pairs
plot(out5$krms_draws$r, out5$krms_draws$k, pch = 19, cex = 0.3,
     col = rgb(0, 0, 1, 0.3),
     xlab = "r (intrinsic growth rate)",
     ylab = "k (carrying capacity)",
     main = paste("Viable r-k pairs (n =", nrow(out5$krms_draws), ")"))

# Histogram of r
hist(out5$krms_draws$r, breaks = 30, col = "lightblue",
     main = "Distribution of r", xlab = "r")
abline(v = median(out5$krms_draws$r), col = "red", lwd = 2)
abline(v = out5$ref_pts$q0.5[out5$ref_pts$param == "r"], 
       col = "blue", lwd = 2, lty = 2)
legend("topright", legend = c("Median", "Best estimate"),
       col = c("red", "blue"), lty = c(1, 2), bty = "n")

# Histogram of k
hist(out5$krms_draws$k, breaks = 30, col = "lightblue",
     main = "Distribution of k", xlab = "k")
abline(v = median(out5$krms_draws$k), col = "red", lwd = 2)
abline(v = out5$ref_pts$q0.5[out5$ref_pts$param == "k"], 
       col = "blue", lwd = 2, lty = 2)

# Histogram of MSY
hist(out5$krms_draws$msy, breaks = 30, col = "lightblue",
     main = "Distribution of MSY", xlab = "MSY")
abline(v = median(out5$krms_draws$msy), col = "red", lwd = 2)
abline(v = out5$ref_pts$q0.5[out5$ref_pts$param == "msy"], 
       col = "blue", lwd = 2, lty = 2)

cat("\n========== Stock Status Summary ==========\n")
cat("Assessment period:", min(out5$ref_ts$year), "-", max(out5$ref_ts$year), "\n")
cat("Natural mortality (M): 0.2\n")
cat("Number of viable parameter combinations:", nrow(out5$krms_draws), "\n\n")

cat("Reference points (median with 95% CI):\n")
cat(sprintf("  MSY: %.0f (%.0f - %.0f) mt\n",
            out5$ref_pts$q0.5[out5$ref_pts$param == "msy"],
            out5$ref_pts$q0.025[out5$ref_pts$param == "msy"],
            out5$ref_pts$q0.975[out5$ref_pts$param == "msy"]))
cat(sprintf("  BMSY: %.0f (%.0f - %.0f) mt\n",
            out5$ref_pts$q0.5[out5$ref_pts$param == "bmsy"],
            out5$ref_pts$q0.025[out5$ref_pts$param == "bmsy"],
            out5$ref_pts$q0.975[out5$ref_pts$param == "bmsy"]))
cat(sprintf("  FMSY: %.4f (%.4f - %.4f)\n",
            out5$ref_pts$q0.5[out5$ref_pts$param == "fmsy"],
            out5$ref_pts$q0.025[out5$ref_pts$param == "fmsy"],
            out5$ref_pts$q0.975[out5$ref_pts$param == "fmsy"]))
cat(sprintf("  r: %.3f (%.3f - %.3f)\n",
            out5$ref_pts$q0.5[out5$ref_pts$param == "r"],
            out5$ref_pts$q0.025[out5$ref_pts$param == "r"],
            out5$ref_pts$q0.975[out5$ref_pts$param == "r"]))
cat(sprintf("  k: %.0f (%.0f - %.0f) mt\n\n",
            out5$ref_pts$q0.5[out5$ref_pts$param == "k"],
            out5$ref_pts$q0.025[out5$ref_pts$param == "k"],
            out5$ref_pts$q0.975[out5$ref_pts$param == "k"]))

final_year <- tail(out5$ref_ts$year, 1)
final_bbmsy <- tail(out5$ref_ts$bbmsy, 1)
final_ffmsy <- tail(out5$ref_ts$ffmsy, 1)
final_b <- tail(out5$ref_ts$b, 1)

cat(sprintf("Current status (%d):\n", final_year))
cat(sprintf("  B/BMSY: %.2f (%.2f - %.2f)\n",
            final_bbmsy,
            tail(out5$ref_ts$bbmsy_lo, 1),
            tail(out5$ref_ts$bbmsy_hi, 1)))
cat(sprintf("  F/FMSY: %.2f (%.2f - %.2f)\n",
            final_ffmsy,
            tail(out5$ref_ts$ffmsy_lo, 1),
            tail(out5$ref_ts$ffmsy_hi, 1)))
cat(sprintf("  Biomass: %.0f (%.0f - %.0f) mt\n\n",
            final_b,
            tail(out5$ref_ts$b_lo, 1),
            tail(out5$ref_ts$b_hi, 1)))

cat("Stock status interpretation:\n")
if(final_bbmsy < 0.5) {
  cat("  *** CRITICAL: Stock is severely overfished (B < 0.5*BMSY) ***\n")
} else if(final_bbmsy < 1) {
  cat("  ** WARNING: Stock is overfished (B < BMSY) **\n")
} else {
  cat("  Stock biomass is at or above BMSY\n")
}

if(final_ffmsy > 1) {
  cat("  ** WARNING: Overfishing is occurring (F > FMSY) **\n")
} else {
  cat("  Fishing mortality is at or below FMSY\n")
}
cat("==========================================\n")

par(mfrow = c(1, 1))
plot(out5$ref_ts$year, out5$ref_ts$catch, type = "l", lwd = 2,
     xlab = "Year", ylab = "", main = "Catch and Biomass Trajectory",
     ylim = c(0, max(out5$ref_ts$catch)))
par(new = TRUE)
plot(out5$ref_ts$year, out5$ref_ts$b, type = "l", lwd = 2, col = "blue",
     xlab = "", ylab = "", axes = FALSE,
     ylim = c(0, max(out5$ref_ts$b_hi)))
axis(4, col = "blue", col.axis = "blue")
mtext("Biomass (mt)", side = 4, line = 3, col = "blue")
legend("topleft", legend = c("Catch", "Biomass"),
       col = c("black", "blue"), lty = 1, lwd = 2, bty = "n")

#---------------------------------------------------
# ocom short time series
#---------------------------------------------------

out6

# The data is in data frames with specific column names
# Use ref_ts for time series data

par(mfrow = c(2, 2))

# Plot 1: B/BMSY trajectory with confidence intervals
plot(out6$ref_ts$year, out6$ref_ts$bbmsy, type = "l", lwd = 2,
     xlab = "Year", ylab = "B/BMSY",
     main = "Biomass relative to BMSY",
     ylim = range(c(out6$ref_ts$bbmsy_lo, out6$ref_ts$bbmsy_hi)))
lines(out6$ref_ts$year, out6$ref_ts$bbmsy_lo, lty = 2, col = "gray")
lines(out6$ref_ts$year, out6$ref_ts$bbmsy_hi, lty = 2, col = "gray")
polygon(c(out6$ref_ts$year, rev(out6$ref_ts$year)),
        c(out6$ref_ts$bbmsy_lo, rev(out6$ref_ts$bbmsy_hi)),
        col = rgb(0.5, 0.5, 0.5, 0.3), border = NA)
lines(out6$ref_ts$year, out6$ref_ts$bbmsy, lwd = 2)
abline(h = 1, col = "red", lty = 2, lwd = 2)
abline(h = 0.5, col = "orange", lty = 3, lwd = 2)

# Plot 2: F/FMSY trajectory with confidence intervals
plot(out6$ref_ts$year, out6$ref_ts$ffmsy, type = "l", lwd = 2,
     xlab = "Year", ylab = "F/FMSY",
     main = "Fishing mortality relative to FMSY",
     ylim = range(c(out6$ref_ts$ffmsy_lo, out6$ref_ts$ffmsy_hi)))
lines(out6$ref_ts$year, out6$ref_ts$ffmsy_lo, lty = 2, col = "gray")
lines(out6$ref_ts$year, out6$ref_ts$ffmsy_hi, lty = 2, col = "gray")
polygon(c(out6$ref_ts$year, rev(out6$ref_ts$year)),
        c(out6$ref_ts$ffmsy_lo, rev(out6$ref_ts$ffmsy_hi)),
        col = rgb(0.5, 0.5, 0.5, 0.3), border = NA)
lines(out6$ref_ts$year, out6$ref_ts$ffmsy, lwd = 2)
abline(h = 1, col = "red", lty = 2, lwd = 2)

# Plot 3: Biomass trajectory
plot(out6$ref_ts$year, out6$ref_ts$b, type = "l", lwd = 2,
     xlab = "Year", ylab = "Biomass (mt)",
     main = "Estimated Biomass",
     ylim = range(c(out6$ref_ts$b_lo, out6$ref_ts$b_hi)))
lines(out6$ref_ts$year, out6$ref_ts$b_lo, lty = 2, col = "gray")
lines(out6$ref_ts$year, out6$ref_ts$b_hi, lty = 2, col = "gray")
polygon(c(out6$ref_ts$year, rev(out6$ref_ts$year)),
        c(out6$ref_ts$b_lo, rev(out6$ref_ts$b_hi)),
        col = rgb(0.5, 0.5, 0.5, 0.3), border = NA)
lines(out6$ref_ts$year, out6$ref_ts$b, lwd = 2)

# Plot 4: Fishing mortality
plot(out6$ref_ts$year, out6$ref_ts$f, type = "l", lwd = 2,
     xlab = "Year", ylab = "Fishing mortality (F)",
     main = "Estimated Fishing Mortality",
     ylim = range(c(out6$ref_ts$f_lo, out6$ref_ts$f_hi)))
lines(out6$ref_ts$year, out6$ref_ts$f_lo, lty = 2, col = "gray")
lines(out6$ref_ts$year, out6$ref_ts$f_hi, lty = 2, col = "gray")
polygon(c(out6$ref_ts$year, rev(out6$ref_ts$year)),
        c(out6$ref_ts$f_lo, rev(out6$ref_ts$f_hi)),
        col = rgb(0.5, 0.5, 0.5, 0.3), border = NA)
lines(out6$ref_ts$year, out6$ref_ts$f, lwd = 2)

# Kobe plot
par(mfrow = c(1, 1))
plot(out6$ref_ts$bbmsy, out6$ref_ts$ffmsy, type = "n",
     xlim = c(0, max(out6$ref_ts$bbmsy_hi, 2)),
     ylim = c(0, max(out6$ref_ts$ffmsy_hi, 2)),
     xlab = "B/BMSY", ylab = "F/FMSY",
     main = "Kobe Plot - Stock Status")

# Colored quadrants
rect(0, 0, 1, 1, col = rgb(1, 0, 0, 0.2), border = NA)
rect(1, 0, 100, 1, col = rgb(1, 1, 0, 0.2), border = NA)
rect(0, 1, 1, 100, col = rgb(1, 1, 0, 0.2), border = NA)
rect(1, 1, 100, 100, col = rgb(0, 1, 0, 0.2), border = NA)

# Trajectory
lines(out6$ref_ts$bbmsy, out6$ref_ts$ffmsy, lwd = 2, col = "blue")
points(out6$ref_ts$bbmsy, out6$ref_ts$ffmsy, pch = 19, cex = 0.5, col = "blue")

# Highlight start and end
points(out6$ref_ts$bbmsy[1], out6$ref_ts$ffmsy[1], 
       pch = 19, cex = 2, col = "green")
points(tail(out6$ref_ts$bbmsy, 1), tail(out6$ref_ts$ffmsy, 1), 
       pch = 19, cex = 2, col = "red")

# Reference lines
abline(v = 1, h = 1, lty = 2, lwd = 2)

# Labels
text(out6$ref_ts$bbmsy[1], out6$ref_ts$ffmsy[1], 
     labels = out6$ref_ts$year[1], pos = 3, cex = 0.8)
text(tail(out6$ref_ts$bbmsy, 1), tail(out6$ref_ts$ffmsy, 1), 
     labels = tail(out6$ref_ts$year, 1), pos = 3, cex = 0.8)

legend("topright", legend = c("Start", "End", "Trajectory"),
       col = c("green", "red", "blue"), pch = c(19, 19, NA), 
       lty = c(NA, NA, 1), bty = "n")

# Print reference points with quantiles
cat("\n========== OCOM Reference Points ==========\n")
print(out6$ref_pts)
cat("\n")

par(mfrow = c(2, 2))

# Plot viable r-k pairs
plot(out6$krms_draws$r, out6$krms_draws$k, pch = 19, cex = 0.3,
     col = rgb(0, 0, 1, 0.3),
     xlab = "r (intrinsic growth rate)",
     ylab = "k (carrying capacity)",
     main = paste("Viable r-k pairs (n =", nrow(out6$krms_draws), ")"))

# Histogram of r
hist(out6$krms_draws$r, breaks = 30, col = "lightblue",
     main = "Distribution of r", xlab = "r")
abline(v = median(out6$krms_draws$r), col = "red", lwd = 2)
abline(v = out6$ref_pts$q0.5[out6$ref_pts$param == "r"], 
       col = "blue", lwd = 2, lty = 2)
legend("topright", legend = c("Median", "Best estimate"),
       col = c("red", "blue"), lty = c(1, 2), bty = "n")

# Histogram of k
hist(out6$krms_draws$k, breaks = 30, col = "lightblue",
     main = "Distribution of k", xlab = "k")
abline(v = median(out6$krms_draws$k), col = "red", lwd = 2)
abline(v = out6$ref_pts$q0.5[out6$ref_pts$param == "k"], 
       col = "blue", lwd = 2, lty = 2)

# Histogram of MSY
hist(out6$krms_draws$msy, breaks = 30, col = "lightblue",
     main = "Distribution of MSY", xlab = "MSY")
abline(v = median(out6$krms_draws$msy), col = "red", lwd = 2)
abline(v = out6$ref_pts$q0.5[out6$ref_pts$param == "msy"], 
       col = "blue", lwd = 2, lty = 2)

cat("\n========== Stock Status Summary ==========\n")
cat("Assessment period:", min(out6$ref_ts$year), "-", max(out6$ref_ts$year), "\n")
cat("Natural mortality (M): 0.2\n")
cat("Number of viable parameter combinations:", nrow(out6$krms_draws), "\n\n")

cat("Reference points (median with 95% CI):\n")
cat(sprintf("  MSY: %.0f (%.0f - %.0f) mt\n",
            out6$ref_pts$q0.5[out6$ref_pts$param == "msy"],
            out6$ref_pts$q0.025[out6$ref_pts$param == "msy"],
            out6$ref_pts$q0.975[out6$ref_pts$param == "msy"]))
cat(sprintf("  BMSY: %.0f (%.0f - %.0f) mt\n",
            out6$ref_pts$q0.5[out6$ref_pts$param == "bmsy"],
            out6$ref_pts$q0.025[out6$ref_pts$param == "bmsy"],
            out6$ref_pts$q0.975[out6$ref_pts$param == "bmsy"]))
cat(sprintf("  FMSY: %.4f (%.4f - %.4f)\n",
            out6$ref_pts$q0.5[out6$ref_pts$param == "fmsy"],
            out6$ref_pts$q0.025[out6$ref_pts$param == "fmsy"],
            out6$ref_pts$q0.975[out6$ref_pts$param == "fmsy"]))
cat(sprintf("  r: %.3f (%.3f - %.3f)\n",
            out6$ref_pts$q0.5[out6$ref_pts$param == "r"],
            out6$ref_pts$q0.025[out6$ref_pts$param == "r"],
            out6$ref_pts$q0.975[out6$ref_pts$param == "r"]))
cat(sprintf("  k: %.0f (%.0f - %.0f) mt\n\n",
            out6$ref_pts$q0.5[out6$ref_pts$param == "k"],
            out6$ref_pts$q0.025[out6$ref_pts$param == "k"],
            out6$ref_pts$q0.975[out6$ref_pts$param == "k"]))

final_year <- tail(out6$ref_ts$year, 1)
final_bbmsy <- tail(out6$ref_ts$bbmsy, 1)
final_ffmsy <- tail(out6$ref_ts$ffmsy, 1)
final_b <- tail(out6$ref_ts$b, 1)

cat(sprintf("Current status (%d):\n", final_year))
cat(sprintf("  B/BMSY: %.2f (%.2f - %.2f)\n",
            final_bbmsy,
            tail(out6$ref_ts$bbmsy_lo, 1),
            tail(out6$ref_ts$bbmsy_hi, 1)))
cat(sprintf("  F/FMSY: %.2f (%.2f - %.2f)\n",
            final_ffmsy,
            tail(out6$ref_ts$ffmsy_lo, 1),
            tail(out6$ref_ts$ffmsy_hi, 1)))
cat(sprintf("  Biomass: %.0f (%.0f - %.0f) mt\n\n",
            final_b,
            tail(out6$ref_ts$b_lo, 1),
            tail(out6$ref_ts$b_hi, 1)))

cat("Stock status interpretation:\n")
if(final_bbmsy < 0.5) {
  cat("  *** CRITICAL: Stock is severely overfished (B < 0.5*BMSY) ***\n")
} else if(final_bbmsy < 1) {
  cat("  ** WARNING: Stock is overfished (B < BMSY) **\n")
} else {
  cat("  Stock biomass is at or above BMSY\n")
}

if(final_ffmsy > 1) {
  cat("  ** WARNING: Overfishing is occurring (F > FMSY) **\n")
} else {
  cat("  Fishing mortality is at or below FMSY\n")
}
cat("==========================================\n")

par(mfrow = c(1, 1))
plot(out6$ref_ts$year, out6$ref_ts$catch, type = "l", lwd = 2,
     xlab = "Year", ylab = "", main = "Catch and Biomass Trajectory",
     ylim = c(0, max(out6$ref_ts$catch)))
par(new = TRUE)
plot(out6$ref_ts$year, out6$ref_ts$b, type = "l", lwd = 2, col = "blue",
     xlab = "", ylab = "", axes = FALSE,
     ylim = c(0, max(out6$ref_ts$b_hi)))
axis(4, col = "blue", col.axis = "blue")
mtext("Biomass (mt)", side = 4, line = 3, col = "blue")
legend("topleft", legend = c("Catch", "Biomass"),
       col = c("black", "blue"), lty = 1, lwd = 2, bty = "n")