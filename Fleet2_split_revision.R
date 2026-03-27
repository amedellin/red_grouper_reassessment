#-----------------------------------------
# separating mid.range fleet in two to check cpue patterns
#-----------------------------------------

library(r4ss)

# 1. Read your original model files
original_dir <- "C:/Kraken/MeroPYuc/SS-DL-tool-master/Scenarios/1983mexmidcpue_4cpues_h84_mixedgpar - Copy"

# Create new directory for revised model
revised_dir <- "C:/Kraken/MeroPYuc/SS-DL-tool-master/Scenarios/Fleet2_split_revision"
dir.create(revised_dir, showWarnings = FALSE)

# Copy all files to new directory
file.copy(from = list.files(original_dir, full.names = TRUE),
          to = revised_dir,
          overwrite = TRUE)

# 2. Read the data file
dat <- SS_readdat(file.path(revised_dir, "datafile.dat"))

# 3. Examine current Fleet 2 structure
table(dat$CPUE$index)  # See which index is Fleet 2
table(dat$catch$fleet) # See fleet numbers
table(dat$lencomp$fleet) # Fleet numbers in length comp

# Identify Fleet 2 data
fleet2_catch <- dat$catch[dat$catch$fleet == 2, ]
fleet2_cpue <- dat$CPUE[dat$CPUE$index == 2, ]  # or appropriate index number
fleet2_lencomp <- dat$lencomp[dat$lencomp$fleet == 2, ]

# Check year ranges
range(fleet2_catch$year)
range(fleet2_cpue$year)
range(fleet2_lencomp$year)

# 4. Split Fleet 2 into 2a (pre-2000) and 2b (2000+)

# Update catch data
dat$catch$fleet[dat$catch$fleet == 2 & dat$catch$year < 2000] <- 2  # Keep as Fleet 2
dat$catch$fleet[dat$catch$fleet == 2 & dat$catch$year >= 2000] <- 5 # New Fleet 5

# Update CPUE data
dat$CPUE$index[dat$CPUE$index == 2 & dat$CPUE$year < 2000] <- 2
dat$CPUE$index[dat$CPUE$index == 2 & dat$CPUE$year >= 2000] <- 5

# Update length composition
dat$lencomp$FltSvy[dat$lencomp$fleet == 2 & dat$lencomp$year < 2000] <- 2
dat$lencomp$FltSvy[dat$lencomp$fleet == 2 & dat$lencomp$year >= 2000] <- 5

# Update fleet count
dat$Nfleets <- 5

# Add fleet names
dat$fleetnames <- c(dat$fleetnames[1:4], "Fleet_2b_post2000")

# 5. Write modified data file
SS_writedat(datlist = dat, 
            outfile = file.path(revised_dir, "datafile.dat"),
            overwrite = TRUE)

# remember to add selectivity values for fleet 5 in controlfile.dat & check starter just in case

# Run SS3
setwd(revised_dir)
system("ss3 -nohess")  # Initial run without Hessian for speed

# Check for errors
# If it converges, run with Hessian
system("ss3")

# Read output
Out_revised <- SS_output(dir = revised_dir)

# Check convergence
Out_revised$maximum_gradient_component  # Should be < 0.001

SS_plots(Out_revised)

# Now you can compare
comparison <- SSsummarize(list(
  Original = Out1,
  Revised = Out_revised
))

# Generate comparison plots

SSplotComparisons(summaryoutput = comparison, shadeForecast = TRUE, pdf=TRUE, plotdir = getwd(),
                  legendlabels = c("Original (Fleet 2 continuous)", 
                                   "Revised (Fleet 2a/2b split)"))

# retrospective analysis, change dir 

retro(dir=revised_dir,
      newsubdir="retrospectives",
      years=0:-5,
      overwrite = TRUE,
      exe="ss3")

retroModels <- SSgetoutput(
  dirvec = file.path(revised_dir, "retrospectives", paste("retro", 0:-5, sep = ""))
)

retroSummary <- SSsummarize(retroModels)
endyrvec <- retroSummary[["endyrs"]] + 0:-5
SSplotComparisons(retroSummary,print=TRUE,plotdir="retrospectives",
                  endyrvec = endyrvec,
                  legendlabels = paste("Data", 0:-5, "years")
)

SSmohnsrho(summaryoutput=retroSummary)

# Plot CPUE fits side by side
par(mfrow = c(2, 2))

# Original Fleet 2
SSplotIndices(Out1, subplot = 2, fleets = 2, 
              Title = "Original: Fleet 2 (1983-2022)")

# Revised Fleet 2a (pre-2000)
SSplotIndices(Out_revised, subplot = 2, fleets = 2,
              Title = "Revised: Fleet 2a (pre-2000)")

# Revised Fleet 2b (post-2000)  
SSplotIndices(Out_revised, subplot = 2, fleets = 5,
              Title = "Revised: Fleet 2b (2000+)")

# Extract and compare key metrics
cat("\n=== COMPARISON OF KEY OUTPUTS ===\n")
cat("\nOriginal Model:\n")
cat("  SPR (2022):", tail(Out1$SPR_series$SPR, 1), "\n")
cat("  SSB (2022):", tail(Out1$timeseries$SpawnBio, 1), "\n")
cat("  Depletion:", tail(Out1$timeseries$Bratio, 1), "\n")
cat("  Max Gradient:", Out1$maximum_gradient_component, "\n")

cat("\nRevised Model (Fleet 2 split):\n")
cat("  SPR (2022):", tail(Out_revised$SPR_series$SPR, 1), "\n")
cat("  SSB (2022):", tail(Out_revised$timeseries$SpawnBio, 1), "\n")
cat("  Depletion:", tail(Out_revised$timeseries$Bratio, 1), "\n")
cat("  Max Gradient:", Out_revised$maximum_gradient_component, "\n")

# Compare recruitment deviations
par(mfrow = c(1, 2))
plot(Out1$recruit$Yr, Out1$recruit$dev, type = "h",
     main = "Original: Recruitment Deviations",
     xlab = "Year", ylab = "Log Deviation")
abline(h = 0, col = "red")
abline(v = 2000, col = "blue", lty = 2)

plot(Out_revised$recruit$Yr, Out_revised$recruit$dev, type = "h",
     main = "Revised: Recruitment Deviations",
     xlab = "Year", ylab = "Log Deviation")
abline(h = 0, col = "red")
abline(v = 2000, col = "blue", lty = 2)

# Compare SPR trajectories
par(mfrow = c(1, 1))

plot(Out1$sprseries$Yr, Out1$sprseries$SPR, type = "l", lwd = 2,
     main = "SPR Comparison", xlab = "Year", ylab = "SPR",
     ylim = c(0, 1), xlim=c(1950,2023),col = "blue")
lines(Out_revised$sprseries$Yr, Out_revised$sprseries$SPR, 
      col = "red", lwd = 2)
abline(v = 2000, lty = 2, col = "gray")
abline(h = 0.4, lty = 2, col = "green")
legend("topleft", 
       legend = c("Original", "Revised (Fleet 2 split)", "Year 2000", "SPR=0.4"),
       col = c("blue", "red", "gray", "green"),
       lty = c(1, 1, 2, 2), lwd = 2)