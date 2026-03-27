#--------------------------------------------------------------------------------
# model comparison
#--------------------------------------------------------------------------------

#remotes::install_github("r4ss/r4ss") #use this link to install r4ss NO install.packages("r4ss")

library("r4ss")

# comparing models 

wd <- "C:/Kraken/MeroPYuc/SS-DL-tool-master/Scenarios"
setwd(wd)

# read the model outputs and print diagnostic messages 
Out <- SS_output(dir = paste(wd,"Modified_h84_freesel",sep="/")) 
Out1 <- SS_output(dir=paste(wd,"1983mexmidcpue_4cpues_h84_mixedgpar",sep="/"))
Out2 <- SS_output(dir=paste(wd,"1983mexmidcpue_4cpues_h84_mixedgpar2",sep="/"))
Out3 <- SS_output(dir=paste(wd,"1983mid_1984art_h84_4cpue_freeselhess",sep="/"))
Out4 <- SS_output(dir=paste(wd,"1983mid_1984art_h84_4cpue_selhess_mixdgpar",sep="/"))
Out5 <- SS_output(dir=paste(wd,"Scenario_paramest",sep="/"))
Out6 <- SS_output(dir=paste(wd,"Scenario_paramest_2",sep="/"))
Out7 <- SS_output(dir=paste(wd,"Short_catch_history",sep="/"))
Out8 <- SS_output(dir=paste(wd,"CatchIndexLengths_1986",sep="/"))
Out9 <- SS_output(dir=paste(wd,"CatchIndex2000Lengths_1986",sep="/"))
  
comparison.list <- list(Out, Out1, Out2, Out3, Out4, Out5, Out6, Out8, Out9)
comparison.summary <- SSsummarize(biglist = comparison.list)
SSplotComparisons(summaryoutput = comparison.summary, shadeForecast = TRUE, pdf=TRUE, plotdir = getwd(),
                  legendlabels = c("Base run","Run 1*","Run 2","Run 3","Run 4",
                                   "Run 5","Run 6","Run 8","Run 9"))

SStableComparisons(summaryoutput = comparison.summary)

SSplotPars(replist=Out7,showdev=TRUE)
SSplotProfile(summaryoutput=comparison.summary,plot=TRUE)

SSmohnsrho(summaryoutput=comparison.summary)

comparison.list <- list(Out1, Out7, Out8, Out9)
comparison.summary <- SSsummarize(biglist = comparison.list )
SSplotComparisons(summaryoutput = comparison.summary, shadeForecast = TRUE, pdf=TRUE, plotdir = getwd(),
                  legendlabels = c("Best model","Run 7(2000 catch-index)",
                                   "Run 8 (1986 catch&index)",
                                   "Run 9 (1986-catch&2000-index"))

SSplotProfile(summaryoutput = comparison.summary,plot=TRUE,models="all")
PinerPlot(summaryoutput = comparison.summary,plot=TRUE,models="all")

# Best model based on retrospectives and likelihood profiles

wd <- "C:/Kraken/MeroPYuc/SS-DL-tool-master/Scenarios/1983mexmidcpue_4cpues_h84_mixedgpar"
setwd(wd) 

# run SS from R
system("./ss3 ")

# read the model outputs and print diagnostic messages 
Outs1 <- SS_output(dir = "C:/Kraken/MeroPYuc/SS-DL-tool-master/Scenarios/1983mexmidcpue_4cpues_h84_mixedgpar")
# plot the results
SS_plots(Outs1, forecastplot=TRUE)

SS_ForeCatch(Outs1,yrs=2024:2030,average=FALSE,avg.yrs=2000:2023)
SS_decision_table_stuff(Outs1,yrs=2024:2030,digits=c(0,0,3))

TSCplot(Outs1,yrs="default")
SSplotTimeseries(Outs1,1)

SSplotCatch(OutS1,plot=TRUE)


# retrospective analysis, change dir 

retro(dir=wd,
      newsubdir="retrospectives",
      years=0:-5,
      overwrite = TRUE,
      exe="ss3")

retroModels <- SSgetoutput(
  dirvec = file.path(wd, "retrospectives", paste("retro", 0:-5, sep = ""))
                          )

retroSummary <- SSsummarize(retroModels)
endyrvec <- retroSummary[["endyrs"]] + 0:-5
SSplotComparisons(retroSummary,print=TRUE,plotdir="retrospectives",
                  endyrvec = endyrvec,
                  legendlabels = paste("Data", 0:-5, "years")
                  )

model_names <- c("Base run","Best model","Run 2","Run 3","Run 4",
                 "Run 5","Run 6","2000 catch-index","1986 catch-index",
                 "1986-catch-2000-index")

# Sensitivity plots
SS_Sensi_plot(model.summaries=comparison.summary,
              mod.names=model_names,
              dir=wd,
              current.year=2023,
              CI=0.95
              )


# jitter parameters for further diagnostics
numjitter<-10
jit_likes<-jitter(
                  dir=wd,Njitter=numjitter,
                  jitter_fraction=0.1
)

profilemodels<-SSgetoutput(dirvec=wd,keyvec=1:numjitter,getcovar=FALSE)
profilesummary<-SSsummarize(profilemodels) # summarize outputs
profilesummary[["likelihoods"]][1,]       # likelihoods
profilesummary[["pars"]]                  # parameters

jitter_results <- SS_output(dir = file.path(wd),
                            printstats = FALSE,
                            verbose=FALSE,
                            covar=FALSE
                            )

SSplotComparisons(profilesummary,
                  legendlabels=paste("Jitter",1:numjitter),
                  plot=TRUE,
                  print=TRUE,
                  plotdir=wd
                  )

# Load required packages
library(r4ss)

# ============================================
# FUNCTION TO RUN RETROSPECTIVE ANALYSIS
# ============================================

run_retrospective_analysis <- function(model_dir, 
                                       years = 0:-5,
                                       exe = "ss3",
                                       newsubdir = "retrospectives",
                                       overwrite = TRUE) {
  
  cat("\n========================================\n")
  cat("Running Retrospective Analysis\n")
  cat("Model directory:", model_dir, "\n")
  cat("Years:", paste(years, collapse = ", "), "\n")
  cat("========================================\n")
  
  # Check if directory exists
  if (!dir.exists(model_dir)) {
    stop("Model directory does not exist: ", model_dir)
  }
  
  # Check for required files
  required_files <- c("starter.ss", "controlfile.ctl", "datafile.dat", "forecast.ss")
  files_exist <- file.exists(file.path(model_dir, required_files))
  
  if (!all(files_exist)) {
    missing <- required_files[!files_exist]
    stop("Missing required files: ", paste(missing, collapse = ", "))
  }
  
  # Run retrospective analysis
  cat("\nRunning retrospective with", length(years), "peels...\n")
  
  tryCatch({
    retro_results <- r4ss::retro(
      dir = model_dir,
      newsubdir = newsubdir,
      years = years,
      overwrite = overwrite,
      exe = exe,
      verbose = TRUE
      )
    
    cat("✓ Retrospective runs completed\n")
    return(retro_results)
    
  }, error = function(e) {
    cat("ERROR running retrospective:", conditionMessage(e), "\n")
    return(NULL)
  })
}

# ============================================
# FUNCTION TO SUMMARIZE RETROSPECTIVE RESULTS
# ============================================

summarize_retrospective <- function(model_dir, 
                                    newsubdir = "retrospectives",
                                    years = 0:-5) {
  
  cat("\n========================================\n")
  cat("Summarizing Retrospective Results\n")
  cat("========================================\n")
  
  # Get retrospective directory
  retro_dir <- file.path(model_dir, newsubdir)
  
  if (!dir.exists(retro_dir)) {
    stop("Retrospective directory does not exist: ", retro_dir)
  }
  
  # Get subdirectories for each peel
  retro_subdirs <- file.path(retro_dir, paste0("retro", years))
  
  # Check which runs completed successfully
  valid_dirs <- retro_subdirs[sapply(retro_subdirs, function(x) {
    file.exists(file.path(x, "Report.sso"))
  })]
  
  if (length(valid_dirs) == 0) {
    stop("No valid retrospective runs found!")
  }
  
  cat("Found", length(valid_dirs), "valid retrospective runs\n")
  
  # Read all retrospective outputs
  cat("\nReading retrospective outputs...\n")
  retro_models <- r4ss::SSgetoutput(
    dirvec = valid_dirs,
    getcovar = FALSE,
    verbose = FALSE
  )
  
  # Summarize
  cat("Summarizing retrospective models...\n")
  retro_summary <- r4ss::SSsummarize(retro_models)
  
  # Add peel labels
  retro_summary$peel_years <- years[1:length(valid_dirs)]
  
  return(retro_summary)
}

# ============================================
# FUNCTION TO CALCULATE MOHN'S RHO
# ============================================

calculate_mohns_rho <- function(retro_summary) {
  
  cat("\n========================================\n")
  cat("Calculating Mohn's Rho\n")
  cat("========================================\n")
  
  n_peels <- length(retro_summary$peel_years)
  
  # Get reference model (peel 0)
  ref_values <- list()
  
  # Spawning biomass
  ssb_ref <- retro_summary$SpawnBio[, 2]  # Column 2 is peel 0
  years_ssb <- retro_summary$SpawnBio$Yr
  
  # Recruitment
  rec_ref <- retro_summary$recruits[, 2]
  years_rec <- retro_summary$recruits$Yr
  
  # F
  f_ref <- retro_summary$Fvalue[, 2]
  years_f <- retro_summary$Fvalue$Yr
  
  # Calculate relative differences for each peel
  rho_ssb <- numeric(n_peels - 1)
  rho_rec <- numeric(n_peels - 1)
  rho_f <- numeric(n_peels - 1)
  
  for (i in 2:n_peels) {
    peel_year <- retro_summary$peel_years[i]
    
    # SSB: compare at the terminal year of the peel
    ssb_peel <- retro_summary$SpawnBio[, i+1]
    idx_ssb <- which(years_ssb == abs(peel_year))
    if (length(idx_ssb) > 0) {
      rho_ssb[i-1] <- (ssb_peel[idx_ssb] - ssb_ref[idx_ssb]) / ssb_ref[idx_ssb]
    }
    
    # Recruitment
    rec_peel <- retro_summary$recruits[, i+1]
    idx_rec <- which(years_rec == abs(peel_year))
    if (length(idx_rec) > 0) {
      rho_rec[i-1] <- (rec_peel[idx_rec] - rec_ref[idx_rec]) / rec_ref[idx_rec]
    }
    
    # F
    f_peel <- retro_summary$Fvalue[, i+1]
    idx_f <- which(years_f == abs(peel_year))
    if (length(idx_f) > 0) {
      rho_f[i-1] <- (f_peel[idx_f] - f_ref[idx_f]) / f_ref[idx_f]
    }
  }
  
  # Calculate mean Mohn's rho
  mohns_rho <- list(
    SSB = mean(rho_ssb, na.rm = TRUE),
    Recruitment = mean(rho_rec, na.rm = TRUE),
    F = mean(rho_f, na.rm = TRUE)
  )
  
  # Print results
  cat("\nMohn's Rho values:\n")
  cat("  SSB:        ", round(mohns_rho$SSB, 4), 
      ifelse(abs(mohns_rho$SSB) > 0.2, " (WARNING: >0.2)", " (OK)"), "\n")
  cat("  Recruitment:", round(mohns_rho$Recruitment, 4),
      ifelse(abs(mohns_rho$Recruitment) > 0.2, " (WARNING: >0.2)", " (OK)"), "\n")
  cat("  F:          ", round(mohns_rho$F, 4),
      ifelse(abs(mohns_rho$F) > 0.15, " (WARNING: >0.15)", " (OK)"), "\n")
  
  cat("\nInterpretation:\n")
  cat("  |Rho| < 0.15-0.20: Acceptable retrospective pattern\n")
  cat("  |Rho| > 0.20: Concerning retrospective pattern\n")
  
  return(mohns_rho)
}

# ============================================
# FUNCTION TO PLOT RETROSPECTIVE RESULTS
# ============================================

plot_retrospective <- function(retro_summary, 
                               mohns_rho,
                               output_dir,
                               model_name = "Model") {
  
  cat("\n========================================\n")
  cat("Creating Retrospective Plots\n")
  cat("========================================\n")
  
  # Create output directory if needed
  if (!dir.exists(output_dir)) {
    dir.create(output_dir, recursive = TRUE)
  }
  
  # Try to use SSplotComparisons, but skip if it fails
  tryCatch({
    r4ss::SSplotComparisons(
      summaryoutput = retro_summary,
      legendlabels = paste("Peel", retro_summary$peel_years),
      plotdir = output_dir,
      png = TRUE,
      pdf = FALSE,
      plot = c(2, 4, 12),  # SSB, Recruitment, F plots
      legendloc = "topright",
      col = c("black", rainbow(length(retro_summary$peel_years) - 1)),
      lty = 1,
      lwd = 2,
      verbose = FALSE,
      uncertainty = FALSE  # Disable uncertainty plotting
    )
    cat("✓ SSplotComparisons plots created\n")
  }, error = function(e) {
    cat("Note: SSplotComparisons skipped (", conditionMessage(e), ")\n")
    cat("Creating custom plots only...\n")
  })
  
  # Create custom retrospective plot with Mohn's rho
  tryCatch({
    pdf(file.path(output_dir, "retrospective_summary.pdf"), width = 14, height = 10)
    
    par(mfrow = c(2, 2), mar = c(4, 4, 3, 2))
    
    n_peels <- length(retro_summary$peel_years)
    colors <- c("black", rainbow(n_peels - 1))
    
    # 1. Spawning Biomass
    ssb_df <- retro_summary$SpawnBio
    idx_ssb <- ssb_df$Yr > 0
    years_ssb <- ssb_df$Yr[idx_ssb]
    ssb_range <- range(as.matrix(ssb_df[idx_ssb, -1]), na.rm = TRUE)
    
    plot(range(years_ssb), ssb_range,
         type = "n", xlab = "Year", ylab = "Spawning Biomass (mt)",
         main = paste("Spawning Biomass - Mohn's Rho =", round(mohns_rho$SSB, 3)))
    
    for (i in 1:n_peels) {
      ssb_vals <- as.numeric(ssb_df[idx_ssb, i+1])
      peel_year <- abs(retro_summary$peel_years[i])
      idx_plot <- years_ssb <= peel_year
      if (sum(idx_plot) > 0) {
        lines(years_ssb[idx_plot], ssb_vals[idx_plot], col = colors[i], lwd = 2)
        if (i > 1) {
          last_idx <- which(idx_plot)[sum(idx_plot)]
          points(years_ssb[last_idx], ssb_vals[last_idx], pch = 16, col = colors[i])
        }
      }
    }
    legend("topright", legend = paste("Peel", retro_summary$peel_years),
           col = colors, lwd = 2, cex = 0.7, bty = "n")
    
    # 2. Recruitment
    rec_df <- retro_summary$recruits
    idx_rec <- rec_df$Yr > 0
    years_rec <- rec_df$Yr[idx_rec]
    rec_range <- range(as.matrix(rec_df[idx_rec, -1]), na.rm = TRUE)
    
    plot(range(years_rec), rec_range,
         type = "n", xlab = "Year", ylab = "Recruitment (1000s)",
         main = paste("Recruitment - Mohn's Rho =", round(mohns_rho$Recruitment, 3)))
    
    for (i in 1:n_peels) {
      rec_vals <- as.numeric(rec_df[idx_rec, i+1])
      peel_year <- abs(retro_summary$peel_years[i])
      idx_plot <- years_rec <= peel_year
      if (sum(idx_plot) > 0) {
        lines(years_rec[idx_plot], rec_vals[idx_plot], col = colors[i], lwd = 2)
        if (i > 1) {
          last_idx <- which(idx_plot)[sum(idx_plot)]
          points(years_rec[last_idx], rec_vals[last_idx], pch = 16, col = colors[i])
        }
      }
    }
    legend("topright", legend = paste("Peel", retro_summary$peel_years),
           col = colors, lwd = 2, cex = 0.7, bty = "n")
    
    # 3. Fishing Mortality
    f_df <- retro_summary$Fvalue
    idx_f <- f_df$Yr > 0
    years_f <- f_df$Yr[idx_f]
    f_range <- range(as.matrix(f_df[idx_f, -1]), na.rm = TRUE)
    
    plot(range(years_f), f_range,
         type = "n", xlab = "Year", ylab = "F",
         main = paste("Fishing Mortality - Mohn's Rho =", round(mohns_rho$F, 3)))
    
    for (i in 1:n_peels) {
      f_vals <- as.numeric(f_df[idx_f, i+1])
      peel_year <- abs(retro_summary$peel_years[i])
      idx_plot <- years_f <= peel_year
      if (sum(idx_plot) > 0) {
        lines(years_f[idx_plot], f_vals[idx_plot], col = colors[i], lwd = 2)
        if (i > 1) {
          last_idx <- which(idx_plot)[sum(idx_plot)]
          points(years_f[last_idx], f_vals[last_idx], pch = 16, col = colors[i])
        }
      }
    }
    legend("topright", legend = paste("Peel", retro_summary$peel_years),
           col = colors, lwd = 2, cex = 0.7, bty = "n")
    
    # 4. Depletion
    depl_df <- retro_summary$Bratio
    idx_depl <- depl_df$Yr > 0
    years_depl <- depl_df$Yr[idx_depl]
    depl_range <- c(0, max(as.matrix(depl_df[idx_depl, -1]), na.rm = TRUE))
    
    plot(range(years_depl), depl_range,
         type = "n", xlab = "Year", ylab = "Depletion (SSB/SSB0)",
         main = "Depletion")
    abline(h = c(0.25, 0.40), lty = 2, col = "gray")
    
    for (i in 1:n_peels) {
      depl_vals <- as.numeric(depl_df[idx_depl, i+1])
      peel_year <- abs(retro_summary$peel_years[i])
      idx_plot <- years_depl <= peel_year
      if (sum(idx_plot) > 0) {
        lines(years_depl[idx_plot], depl_vals[idx_plot], col = colors[i], lwd = 2)
        if (i > 1) {
          last_idx <- which(idx_plot)[sum(idx_plot)]
          points(years_depl[last_idx], depl_vals[last_idx], pch = 16, col = colors[i])
        }
      }
    }
    legend("topright", legend = paste("Peel", retro_summary$peel_years),
           col = colors, lwd = 2, cex = 0.7, bty = "n")
    
    dev.off()
    cat("✓ Custom plots saved to:", file.path(output_dir, "retrospective_summary.pdf"), "\n")
    
  }, error = function(e) {
    cat("ERROR creating plots:", conditionMessage(e), "\n")
    if (dev.cur() > 1) dev.off()  # Close PDF if open
  })
  
  cat("✓ Plots saved to:", output_dir, "\n")
}

# ============================================
# MAIN EXECUTION FUNCTION
# ============================================

run_complete_retrospective <- function(model_dir,
                                       years = 0:-5,
                                       exe = "ss3",
                                       model_name = "Model") {
  
  cat("\n╔════════════════════════════════════════╗\n")
  cat("║   RETROSPECTIVE ANALYSIS WORKFLOW      ║\n")
  cat("╚════════════════════════════════════════╝\n")
  
  # Step 1: Run retrospective
  retro_results <- run_retrospective_analysis(
    model_dir = model_dir,
    years = years,
    exe = exe
  )
  
  if (is.null(retro_results)) {
    stop("Retrospective analysis failed!")
  }
  
  # Step 2: Summarize results
  retro_summary <- summarize_retrospective(
    model_dir = model_dir,
    years = years
  )
  
  # Step 3: Calculate Mohn's rho
  mohns_rho <- calculate_mohns_rho(retro_summary)
  
  # Step 4: Create plots
  output_dir <- file.path(model_dir, "retrospectives", "plots")
  plot_retrospective(
    retro_summary = retro_summary,
    mohns_rho = mohns_rho,
    output_dir = output_dir,
    model_name = model_name
  )
  
  # Step 5: Save results
  saveRDS(list(
    summary = retro_summary,
    mohns_rho = mohns_rho
  ), file.path(model_dir, "retrospectives", "retro_results.rds"))
  
  cat("\n╔════════════════════════════════════════╗\n")
  cat("║   RETROSPECTIVE ANALYSIS COMPLETE      ║\n")
  cat("╚════════════════════════════════════════╝\n")
  
  return(list(
    summary = retro_summary,
    mohns_rho = mohns_rho,
    output_dir = output_dir
  ))
}

# ============================================
# USAGE EXAMPLE
# ============================================

# Run retrospective for a single model
retro_results <- run_complete_retrospective(
  model_dir = wd,
  years = 0:-5,
  exe = "ss3",
  model_name = "My Model"
)

# Access results
print(retro_results$mohns_rho)

# Or run for multiple models
model_dirs <- c(
  paste(wd, "Modified_h84_freesel", sep="/"),
  paste(wd, "1983mexmidcpue_4cpues_h84_mixedgpar", sep="/")
  # Add more models...
)

model_names <- c("Base run", "Best model")

# Loop through models
all_retro_results <- list()
for (i in seq_along(model_dirs)) {
  cat("\n\n╔════════════════════════════════════════╗\n")
  cat("║  Processing:", model_names[i], "\n")
  cat("╚════════════════════════════════════════╝\n")
  
  all_retro_results[[model_names[i]]] <- run_complete_retrospective(
    model_dir = model_dirs[i],
    years = 0:-5,
    exe = "ss3",
    model_name = model_names[i]
  )
}

# Compare Mohn's rho across models
cat("\n\nMohn's Rho Comparison:\n")
cat("═══════════════════════════════════════════════════════\n")
for (name in names(all_retro_results)) {
  rho <- all_retro_results[[name]]$mohns_rho
  cat(sprintf("%-25s SSB: %6.3f  Rec: %6.3f  F: %6.3f\n", 
              name, rho$SSB, rho$Recruitment, rho$F))
}

#------------------------------------------
# retros after running function
#------------------------------------------

base_endyr <- retro0$endyr
endyrvec <- c(base_endyr, 
              base_endyr - 1, 
              base_endyr - 2, 
              base_endyr - 3, 
              base_endyr - 4, 
              base_endyr - 5)

wd <- "C:/Kraken/MeroPYuc/SS-DL-tool-master/Scenarios/CatchIndexLengths_1986/retrospectives"
setwd(wd)

# read the model outputs and print diagnostic messages 
retro0 <- SS_output(dir = paste(wd,"retro0",sep="/")) 
# plot the results
#SS_plots(Out, forecastplot = TRUE)

retro1 <- SS_output(dir=paste(wd,"retro-1",sep="/"))
retro2 <- SS_output(dir=paste(wd,"retro-2",sep="/"))
retro3 <- SS_output(dir=paste(wd,"retro-3",sep="/"))
retro4 <- SS_output(dir=paste(wd,"retro-4",sep="/"))
retro5 <- SS_output(dir=paste(wd,"retro-5",sep="/"))

comparison.listr <- list(retro0,retro1,retro2,retro3,retro4,retro5)
comparison.summaryr <- SSsummarize(biglist = comparison.listr )
SSplotComparisons(summaryoutput = comparison.summaryr, shadeForecast = TRUE, pdf=TRUE, plotdir = getwd(),
                  endyrvec=endyrvec,
                  legendlabels = c("Base model","Data -1 year","Data -2 years",
                                   "Data -3 years","Data -4 years","Data - 5 years"))

SSmohnsrho(summaryoutput=comparison.summaryr)

wd <- "C:/Kraken/MeroPYuc/SS-DL-tool-master/Scenarios/CatchIndex2000Lengths_1986/retrospectives"
setwd(wd)

# read the model outputs and print diagnostic messages 
retro0 <- SS_output(dir = paste(wd,"retro0",sep="/")) 
# plot the results
#SS_plots(Out, forecastplot = TRUE)

retro1 <- SS_output(dir=paste(wd,"retro-1",sep="/"))
retro2 <- SS_output(dir=paste(wd,"retro-2",sep="/"))
retro3 <- SS_output(dir=paste(wd,"retro-3",sep="/"))
retro4 <- SS_output(dir=paste(wd,"retro-4",sep="/"))
retro5 <- SS_output(dir=paste(wd,"retro-5",sep="/"))

comparison.listr <- list(retro0,retro1,retro2,retro3,retro4,retro5)
comparison.summaryr <- SSsummarize(biglist = comparison.listr )
SSplotComparisons(summaryoutput = comparison.summaryr, shadeForecast = TRUE, pdf=TRUE, plotdir = getwd(),
                  endyrvec=endyrvec,
                  legendlabels = c("Base model","Data -1 year","Data -2 years",
                                   "Data -3 years","Data -4 years","Data - 5 years"))

SSmohnsrho(summaryoutput=comparison.summaryr)

wd <- "C:/Kraken/MeroPYuc/SS-DL-tool-master/Scenarios/Short_catch_history/retrospectives"
setwd(wd)

# read the model outputs and print diagnostic messages 
retro0 <- SS_output(dir = paste(wd,"retro0",sep="/")) 
# plot the results
#SS_plots(Out, forecastplot = TRUE)

retro1 <- SS_output(dir=paste(wd,"retro-1",sep="/"))
retro2 <- SS_output(dir=paste(wd,"retro-2",sep="/"))
retro3 <- SS_output(dir=paste(wd,"retro-3",sep="/"))
retro4 <- SS_output(dir=paste(wd,"retro-4",sep="/"))
retro5 <- SS_output(dir=paste(wd,"retro-5",sep="/"))

comparison.listr <- list(retro0,retro1,retro2,retro3,retro4,retro5)
comparison.summaryr <- SSsummarize(biglist = comparison.listr )


SSplotComparisons(summaryoutput = comparison.summaryr, shadeForecast = TRUE, pdf=TRUE, plotdir = getwd(),
                  endyrvec=endyrvec,
                  legendlabels = c("Base model","Data -1 year","Data -2 years",
                                   "Data -3 years","Data -4 years","Data - 5 years"))

SSmohnsrho(summaryoutput=comparison.summaryr)
