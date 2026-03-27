#-------------------------------------
# Red grouper SS3 diagnostics
#-------------------------------------

library("r4ss")

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

comparison.list <- list(Out, Out1, Out2, Out3, Out4, Out5, Out6, Out7, Out8, Out9)
comparison.summary <- SSsummarize(biglist = comparison.list)

# Define model list
model_list <- list(
  list(out = Out, name = "Base run"),
  list(out = Out1, name = "Run 1"),
  list(out = Out2, name = "Run 2"),
  list(out = Out3, name = "Run 3"),
  list(out = Out4, name = "Run 4"),
  list(out = Out5, name = "Run 5"),
  list(out = Out6, name = "Run 6"),
  list(out = Out7, name = "Run 7"),
  list(out = Out8, name = "Run 8"),
  list(out = Out9, name = "Run 9")
)

# STEP 1: Simple check of what's available
cat("=== STEP 1: Checking Model Output Structure ===\n")

simple_diagnostics <- function(out, model_name) {
  data.frame(
    Model = model_name,
    Loaded = !is.null(out),
    HasGradient = !is.null(out$maximum_gradient_component),
    HasLikelihood = !is.null(out$likelihoods_used),
    HasCoVar = !is.null(out$CoVar),
    HasAIC = !is.null(out$AIC),
    stringsAsFactors = FALSE
  )
}

simple_table <- do.call(rbind, lapply(model_list, function(x) {
  simple_diagnostics(x$out, x$name)
}))

print(simple_table)

# STEP 2: Detailed diagnostics for models that have the necessary components
cat("\n\n=== STEP 2: Detailed Diagnostics ===\n")

extract_diagnostics <- function(out, model_name) {
  
  # Safe extraction function
  safe_extract <- function(value, default = NA) {
    if (is.null(value) || length(value) == 0) {
      return(default)
    }
    return(value)
  }
  
  # Extract maximum gradient
  max_grad <- safe_extract(out$maximum_gradient_component, NA)
  
  # Extract likelihood
  nll <- if (!is.null(out$likelihoods_used) && nrow(out$likelihoods_used) > 0) {
    out$likelihoods_used[1, "values"]
  } else {
    NA
  }
  
  # Extract parameters count
  n_params <- safe_extract(out$N_estimated_parameters, NA)
  
  # Extract AIC/BIC
  aic_val <- safe_extract(out$AIC, NA)
  bic_val <- safe_extract(out$BIC, NA)
  
  # Check convergence
  converged <- if (!is.na(max_grad)) {
    max_grad < 0.001
  } else {
    NA
  }
  
  # Check Hessian
  hessian_pd <- if (!is.null(out$CoVar)) {
    !any(is.na(out$CoVar))
  } else {
    NA
  }
  
  data.frame(
    Model = model_name,
    MaxGradient = max_grad,
    NegativeLogLikelihood = nll,
    TotalParameters = n_params,
    AIC = aic_val,
    BIC = bic_val,
    Converged = converged,
    Hessian_PD = hessian_pd,
    stringsAsFactors = FALSE
  )
}

diagnostics_table <- do.call(rbind, lapply(model_list, function(x) {
  extract_diagnostics(x$out, x$name)
}))

print(diagnostics_table)
write.csv(diagnostics_table, "model_diagnostics_summary.csv", row.names = FALSE)

# STEP 3: Identify problematic models
cat("\n\n=== STEP 3: Problem Models ===\n")

if (any(is.na(diagnostics_table$MaxGradient))) {
  cat("\nModels missing gradient information:\n")
  print(diagnostics_table[is.na(diagnostics_table$MaxGradient), "Model"])
}

if (any(!diagnostics_table$Converged, na.rm = TRUE)) {
  cat("\nModels that did not converge (gradient >= 0.001):\n")
  bad_models <- diagnostics_table[which(!diagnostics_table$Converged & !is.na(diagnostics_table$Converged)), ]
  print(bad_models[, c("Model", "MaxGradient")])
}

if (any(!diagnostics_table$Hessian_PD, na.rm = TRUE)) {
  cat("\nModels with non-positive definite Hessian:\n")
  print(diagnostics_table[which(!diagnostics_table$Hessian_PD & !is.na(diagnostics_table$Hessian_PD)), "Model"])
}

# STEP 4: Model comparison (only for valid models)
cat("\n\n=== STEP 4: Information Criteria Comparison ===\n")
valid_models <- diagnostics_table[!is.na(diagnostics_table$AIC), ]

if (nrow(valid_models) > 0) {
  valid_models$DeltaAIC <- valid_models$AIC - min(valid_models$AIC, na.rm = TRUE)
  valid_models$DeltaBIC <- valid_models$BIC - min(valid_models$BIC, na.rm = TRUE)
  valid_models <- valid_models[order(valid_models$AIC), ]
  
  print(valid_models[, c("Model", "AIC", "DeltaAIC", "BIC", "DeltaBIC")])
}

# ============================================================================
# 2. RESIDUAL ANALYSIS - Critical for model validation
# ============================================================================

# For each model, examine residuals
for (i in seq_along(model_list)) {
  model <- model_list[[i]]
  
  # Generate comprehensive residual plots
  SS_plots(replist = model$out, 
           plot = c(11, 12, 13, 14, 15), # Residual plots
           pdf = FALSE,
           plotdir = paste0(getwd(), "/", model$name, "_residuals"))
  
  # Additional residual diagnostics
  if (!is.null(model$out$cpue)) {
    # Index residuals
    cpue_res <- model$out$cpue
    if (nrow(cpue_res) > 0) {
      # Runs test for randomness
      residuals <- cpue_res$Obs - cpue_res$Exp
      cat("\n", model$name, "- Index Residuals Summary:\n")
      print(summary(residuals))
      
      # Check for autocorrelation
      if (length(residuals) > 3) {
        acf_result <- acf(residuals, plot = FALSE)
        cat("First lag autocorrelation:", acf_result$acf[2], "\n")
      }
    }
  }
}

# ============================================================================
# 3. RETROSPECTIVE ANALYSIS - Essential stability check
# ============================================================================

# Perform retrospective analysis for your best model(s)
# Using base model as example
SS_doRetro(masterdir = wd,
           oldsubdir = "Modified_h84_freesel",
           newsubdir = "Modified_h84_freesel_retro",
           years = 0:-5)  # 5-year retrospective

# Summarize retrospective runs
retro_list <- SSgetoutput(dirvec = file.path(wd, "Modified_h84_freesel_retro",
                                             paste0("retro", 0:-5)))
retro_summary <- SSsummarize(retro_list)

# Calculate Mohn's rho (retrospective bias metric)
SSplotComparisons(retro_summary, 
                  legendlabels = paste("Retro", 0:-5),
                  pdf = TRUE,
                  plotdir = paste0(wd, "/Modified_h84_freesel_retro"))

# Mohn's rho calculation (you may need to implement this)
# Acceptable range: -0.15 to 0.20 for biomass
# Acceptable range: -0.10 to 0.15 for F

# ============================================================================
# 4. JITTER ANALYSIS - Test for local minima
# ============================================================================

# Run jitter analysis to ensure global minimum
jitter(mydir = file.path(wd, "1983mexmidcpue_4cpues_h84_mixedgpar"),
             Njitter = 20,
             jitter_fraction = 0.1)

# Read jitter results
jitter_results <- SS_output(dir = file.path(wd, "1983mexmidcpue_4cpues_h84_mixedgpar"),
                            covar = FALSE, forecast = FALSE)

# Check if jitter found better solutions
cat("\nJitter Analysis Results:\n")
cat("Number of runs with lower likelihood:", 
    sum(jitter_results$jitter_like < jitter_results$likelihoods_used[1, "values"]), "\n")

# ============================================================================
# 5. LIKELIHOOD PROFILE ANALYSIS - Parameter uncertainty
# ============================================================================

# Profile key parameters (e.g., steepness, M, R0)
# Example for R0
profile(dir = file.path(wd, "1983mexmidcpue_4cpues_h84_mixedgpar"),
           masterctlfile = "controlfile.ctl",
           newctlfile = "control_modified.ss",
           #linenum = 42,  # Line number for R0 in control file
           string = "SR_LN(R0)",
           profilevec = seq(8, 12, 0.5))  # Adjust range as appropriate

profile_output <- SSgetoutput(dirvec = file.path(wd, "1983mexmidcpue_4cpues_h84_mixedgpar",
                                                 paste0("R0_", seq(8, 12, 0.5))))
profile_summary <- SSsummarize(profile_output)

SSplotProfile(profile_summary,
              profile.string = "R0",
              profile.label = "Log(R0)")

# ============================================================================
# 6. SENSITIVITY ANALYSIS - Structural uncertainty
# ============================================================================

# You've already started this with multiple model configurations
# Evaluate sensitivity to:
# - Data weighting schemes
# - Selectivity assumptions
# - Natural mortality
# - Growth parameters
# - Start year of model

# Compare information criteria
ic_comparison <- diagnostics_table[, c("Model", "AIC", "BIC")]
ic_comparison$DeltaAIC <- ic_comparison$AIC - min(ic_comparison$AIC)
ic_comparison$DeltaBIC <- ic_comparison$BIC - min(ic_comparison$BIC)
ic_comparison <- ic_comparison[order(ic_comparison$AIC), ]

print("\nInformation Criteria Comparison:")
print(ic_comparison)

# ============================================================================
# 7. RESIDUAL PATTERN ANALYSIS
# ============================================================================

# Check for systematic patterns in length/age composition residuals
for (i in seq_along(model_list)) {
  model <- model_list[[i]]
  
  # Francis tuning weights for composition data
  if (!is.null(model$out$lendbase)) {
    cat("\n", model$name, "- Length composition fit statistics\n")
    # Look at effective sample sizes vs input sample sizes
    print(summary(model$out$lendbase))
  }
}

# ============================================================================
# 8. PARAMETER CORRELATIONS AND ESTIMABILITY
# ============================================================================

for (i in seq_along(model_list)) {
  model <- model_list[[i]]
  
  # Check parameter correlations
  if (!is.null(model$out$CoVar)) {
    cor_matrix <- cov2cor(model$out$CoVar)
    high_corr <- which(abs(cor_matrix) > 0.95 & abs(cor_matrix) < 1, arr.ind = TRUE)
    
    if (nrow(high_corr) > 0) {
      cat("\n", model$name, "- High parameter correlations detected:\n")
      print(high_corr)
    }
  }
  
  # Check CVs of key parameters
  if (!is.null(model$out$parameters)) {
    key_params <- model$out$parameters[grep("SR_LN|NatM|L_at|K_Fem|VonBert", 
                                            model$out$parameters$Label), ]
    if (nrow(key_params) > 0) {
      cat("\n", model$name, "- Key parameter CVs:\n")
      print(key_params[, c("Label", "Value", "Parm_StDev")])
    }
  }
}

# ============================================================================
# 9. FORECAST EVALUATION (if applicable)
# ============================================================================

# Compare forecast variability across models
SSplotComparisons(comparison.summary, 
                  subplots = c(2, 4, 10),  # Biomass, recruitment, F
                  shadeForecast = TRUE,
                  pdf = TRUE,
                  plotdir = getwd(),
                  legendlabels = c("Base run","Run 1","Run 2","Run 3","Run 4",
                                   "Run 5","Run 6","Run 7","Run 8","Run 9"))
