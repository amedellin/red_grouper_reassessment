# ============================================================
# Selectivity Likelihood Profiles — Red Grouper SS3 Model
# Fleet assignments:
#   Fleet 1: Mexican artisanal    (hooks)
#   Fleet 2: Mexican mid-range   (hooks)   ← P3 profiled
#   Fleet 3: Cuban mid-range     (hooks)   ← P3 profiled
#   Fleet 4: Mexican bottom trawlers (1970-1998, logistic)
# ============================================================

library(r4ss)
library(ggplot2)
library(dplyr)
library(patchwork) 

base_dir <- "C:/Kraken/MeroPYuc/SS-DL-tool-master/Scenarios/bestmodel2"

# ============================================================
# READ BASE MODEL
# ============================================================

base_out <- SS_output(base_dir, verbose = FALSE, printstats = FALSE)

B0_base       <- base_out$derived_quants["SSB_unfished", "Value"]
terminal_yr   <- max(base_out$timeseries$Yr[base_out$timeseries$Era == "TIME"])
bratio_label  <- paste0("Bratio_", terminal_yr)

cat("Base model terminal year:", terminal_yr, "\n")
cat("Base model terminal B/B0:",
    round(tail(base_out$timeseries$SpawnBio, 1) / B0_base, 3), "\n")
cat("Base model gradient:", base_out$maximum_gradient_component, "\n")


# ============================================================
# RUN P3 SCENARIO FUNCTION
# Profiles P3 (ascending width) for a given fleet
# ============================================================

run_p3_scenario <- function(base_dir, fleet_num, p3_value, scenario_name) {
  
  scenario_dir <- file.path(dirname(base_dir), scenario_name)
  dir.create(scenario_dir, showWarnings = FALSE)
  file.copy(list.files(base_dir, full.names = TRUE), scenario_dir, overwrite = TRUE)
  
  dat  <- SS_readdat(file.path(scenario_dir, "datafile.dat"), verbose = FALSE)
  ctrl <- SS_readctl(file.path(scenario_dir, "controlfile.ctl"), datlist = dat, verbose = FALSE)
  
  param_name <- paste0("SizeSel_P_3_Fleet_", fleet_num, "(", fleet_num, ")")
  
  if (!param_name %in% rownames(ctrl$size_selex_parms)) {
    cat("ERROR: Parameter not found:", param_name, "\n")
    return(NULL)
  }
  
  ctrl$size_selex_parms[param_name, "INIT"] <- p3_value
  ctrl$size_selex_parms[param_name, "LO"]   <- min(-8, p3_value - 0.5)
  
  SS_writectl(ctllist = ctrl,
              outfile = file.path(scenario_dir, "controlfile.ctl"),
              overwrite = TRUE)
  
  run_ok <- tryCatch({
    r4ss::run(dir = scenario_dir, exe = "ss3",
              skipfinished = FALSE, show_in_console = FALSE)
    TRUE
  }, error = function(e) FALSE)
  
  if (!run_ok) return(NULL)
  if (!file.exists(file.path(scenario_dir, "Report.sso"))) return(NULL)
  
  tryCatch(
    SS_output(scenario_dir, verbose = FALSE, printstats = FALSE),
    error = function(e) NULL
  )
}

# ============================================================
# RUN P3 SENSITIVITY LOOP
# Fleets 2 and 3 are both hook-based — these are the ones
# that hit their P3 lower bounds in the base model
# ============================================================

p3_values      <- seq(-7, 0, by = 0.5)
fleets_to_test <- c(2, 3)          # Fleet 2 (Mex mid-range) and Fleet 3 (Cuban)
results        <- list()

for (fleet in fleets_to_test) {
  for (val in p3_values) {
    scenario_name <- sprintf("fleet%d_P3_%.1f", fleet, val)
    cat("Running:", scenario_name, "\n")
    
    out <- run_p3_scenario(base_dir, fleet, val, scenario_name)
    
    if (!is.null(out)) {
      results[[scenario_name]] <- list(
        fleet     = fleet,
        p3_value  = val,
        output    = out
      )
      cat("  OK | gradient:", out$maximum_gradient_component, "\n")
    }
  }
}

cat("Total successful runs:", length(results),
    "of", length(p3_values) * length(fleets_to_test), "\n")

# ============================================================
# EXTRACT METRICS
# ============================================================

all_ts      <- list()
all_metrics <- list()

for (nm in names(results)) {
  res <- results[[nm]]
  out <- res$output
  B0  <- out$derived_quants["SSB_unfished", "Value"]
  
  ts <- out$timeseries %>%
    filter(Yr >= 1950) %>%
    mutate(
      depletion = SpawnBio / B0,
      fleet     = res$fleet,
      p3_value  = res$p3_value,
      scenario  = nm
    )
  
  all_ts[[nm]] <- ts
  
  all_metrics[[nm]] <- data.frame(
    scenario     = nm,
    fleet        = res$fleet,
    p3_value     = res$p3_value,
    terminal_dep = tail(ts$depletion, 1),
    B_Bmsy       = out$derived_quants[bratio_label, "Value"],
    total_like   = out$likelihoods_used["TOTAL", "values"],
    gradient     = out$maximum_gradient_component,
    converged    = out$maximum_gradient_component < 0.001
  )
}

all_ts_df      <- bind_rows(all_ts)
all_metrics_df <- bind_rows(all_metrics) %>%
  mutate(
    is_base     = p3_value == -4.0,
    plausible   = terminal_dep < 1.0 & terminal_dep > 0 & converged,
    fleet_label = case_when(
      fleet == 2 ~ "Fleet 2 (Mid-range Mexican)",
      fleet == 3 ~ "Fleet 3 (Cuban mid-range)"
    )
  )

all_ts_df <- all_ts_df %>%
  mutate(
    is_base     = p3_value == -4.0,
    fleet_label = case_when(
      fleet == 2 ~ "Fleet 2 (Mid-range Mexican)",
      fleet == 3 ~ "Fleet 3 (Cuban mid-range)"
    )
  )

cat("\nMetrics summary:\n")
print(all_metrics_df %>%
        select(fleet_label, p3_value, terminal_dep, converged) %>%
        arrange(fleet, p3_value))

# ============================================================
# DELTA LIKELIHOOD (relative to each fleet's minimum)
# ============================================================

like_df <- all_metrics_df %>%
  filter(converged) %>%
  group_by(fleet) %>%
  mutate(delta_like = total_like - min(total_like)) %>%
  ungroup()

best_fit <- like_df %>%
  group_by(fleet) %>%
  slice_min(total_like, n = 1) %>%
  ungroup()

cat("\nBest-fit P3 per fleet:\n")
print(best_fit %>% select(fleet_label, p3_value, total_like, terminal_dep))

plausible_scenarios <- all_metrics_df %>%
  filter(plausible) %>%
  pull(scenario)

# ============================================================
# P3 PROFILE PLOTS
# ============================================================

fleet_colors <- c(
  "Fleet 2 (Mid-range Mexican)" = "steelblue",
  "Fleet 3 (Cuban mid-range)"   = "darkorange"
)

# -- Plot 1: Likelihood profile --
p_like <- ggplot(like_df, aes(x = p3_value, y = delta_like, color = fleet_label)) +
  geom_line(linewidth = 1.2) +
  geom_point(size = 2.5) +
  geom_point(data = best_fit, aes(x = p3_value, y = 0),
             shape = 23, size = 4, fill = "white", stroke = 1.5) +
  geom_vline(xintercept = -4.0, linetype = "dashed",
             color = "grey40", linewidth = 0.8) +
  annotate("text", x = -3.85, y = max(like_df$delta_like) * 0.95,
           label = "Base bound\n(P\u2083 = -4.0)", hjust = 0, size = 3.2, color = "grey40") +
  geom_hline(yintercept = 1.92, linetype = "dotted", linewidth = 0.7) +
  annotate("text", x = min(like_df$p3_value) + 0.1, y = 2.1,
           label = "95% confidence interval threshold (\u0394 = 1.92)",
           hjust = 0, size = 3) +
  scale_color_manual(values = fleet_colors, name = NULL) +
  labs(
    title    = "Likelihood Profile: Selectivity Ascending Width (P\u2083)",
    subtitle = "Diamond = maximum likelihood estimate | Dashed = base model bound",
    x        = "Size_DblN_ascend_se (P\u2083) value",
    y        = expression(Delta ~ "negative log-likelihood")
  ) +
  theme_bw(base_size = 12) +
  theme(legend.position = "top")

ggsave("likelihood_profile_P3_final.png", p_like, width = 9, height = 6, dpi = 300)

# -- Plot 2: Terminal depletion vs P3 --
p_terminal <- ggplot(like_df, aes(x = p3_value, y = terminal_dep, color = fleet_label)) +
  geom_ribbon(
    data  = like_df %>% filter(delta_like <= 1.92),
    aes(ymin = -Inf, ymax = Inf, fill = fleet_label),
    alpha = 0.08, color = NA
  ) +
  geom_line(linewidth = 1.2) +
  geom_point(size = 2.5) +
  geom_vline(xintercept = -4.0, linetype = "dashed", color = "grey40") +
  geom_hline(yintercept = 0.25, linetype = "dashed", color = "darkred", linewidth = 0.7) +
  geom_hline(yintercept = 0.40, linetype = "dashed", color = "red", linewidth = 0.7) +
  annotate("text", x = min(like_df$p3_value) + 0.1, y = 0.27,
           label = "Minimum threshold (0.25)", hjust = 0, size = 3, color = "darkred") +
  annotate("text", x = min(like_df$p3_value) + 0.1, y = 0.42,
           label = "Management target (0.40)",  hjust = 0, size = 3, color = "red") +
  scale_color_manual(values = fleet_colors, name = NULL) +
  scale_fill_manual(values  = fleet_colors, guide = "none") +
  labs(
    title    = "Terminal Year Depletion vs. P\u2083 Value",
    subtitle = "Shaded = within 95% confidence interval of best fit",
    x        = "Size_DblN_ascend_se (P\u2083) value",
    y        = "Terminal year B/B\u2080"
  ) +
  theme_bw(base_size = 12) +
  theme(legend.position = "top")

ggsave("terminal_depletion_P3_final.png", p_terminal, width = 9, height = 6, dpi = 300)

# -- Plot 3: Depletion trajectories (plausible range only) --
p_plausible <- ggplot(
  all_ts_df %>% filter(scenario %in% plausible_scenarios),
  aes(x = Yr, y = depletion, color = factor(p3_value),
      size = factor(is_base), group = scenario)
) +
  geom_line() +
  geom_hline(yintercept = 0.40, linetype = "dashed", color = "red", linewidth = 0.8) +
  geom_hline(yintercept = 0.25, linetype = "dashed", color = "darkred", linewidth = 0.6) +
  scale_color_viridis_d(name = "P\u2083 value", option = "turbo") +
  scale_size_manual(values = c("FALSE" = 0.5, "TRUE" = 1.8), guide = "none") +
  facet_wrap(~fleet_label) +
  labs(
    title    = "Depletion Trajectories — Biologically Plausible P\u2083 Range Only",
    subtitle = "Restricted to runs where B/B\u2080 remains within [0, 1] throughout",
    x        = "Year",
    y        = "Fraction of unfished biomass (B/B\u2080)"
  ) +
  theme_bw(base_size = 12) +
  theme(strip.background = element_rect(fill = "grey90"),
        strip.text = element_text(face = "bold"),
        legend.position = "right")

ggsave("sensitivity_P3_plausible_only.png", p_plausible, width = 12, height = 6, dpi = 300)

# -- Combined Figure S6.2: likelihood profile + terminal depletion side by side --
# Uses cowplot if available, otherwise saves side-by-side via png/grid

combine_ok <- FALSE

if (requireNamespace("patchwork", quietly = TRUE)) {
  library(patchwork)
  p_S6_2 <- p_like + p_terminal +
    patchwork::plot_layout(ncol = 2) +
    patchwork::plot_annotation(
      caption = "Left: delta-likelihood surface | Right: terminal B/B\u2080"
    )
  ggsave("figure_S6.2_combined.png", p_S6_2, width = 16, height = 6, dpi = 300)
  combine_ok <- TRUE
  cat("Figure S6.2 (combined via patchwork) saved.\n")
  
} else if (requireNamespace("cowplot", quietly = TRUE)) {
  library(cowplot)
  p_S6_2 <- cowplot::plot_grid(p_like, p_terminal, ncol = 2, align = "h")
  ggsave("figure_S6.2_combined.png", p_S6_2, width = 16, height = 6, dpi = 300)
  combine_ok <- TRUE
  cat("Figure S6.2 (combined via cowplot) saved.\n")
  
} else {
  # Base R fallback: write both panels into one png using gridExtra
  if (requireNamespace("gridExtra", quietly = TRUE)) {
    library(gridExtra)
    png("figure_S6.2_combined.png", width = 3200, height = 1200, res = 200)
    gridExtra::grid.arrange(
      ggplotGrob(p_like),
      ggplotGrob(p_terminal),
      ncol = 2
    )
    dev.off()
    combine_ok <- TRUE
    cat("Figure S6.2 (combined via gridExtra) saved.\n")
  }
}

if (!combine_ok) {
  # Last resort: pure base R - save as two separate files only
  # (already saved above as likelihood_profile_P3_final.png
  #  and terminal_depletion_P3_final.png)
  cat("NOTE: No combining package available (patchwork/cowplot/gridExtra).\n")
  cat("Install one with: install.packages('patchwork')\n")
  cat("Figure S6.2 panels saved separately as:\n")
  cat("  likelihood_profile_P3_final.png (left panel)\n")
  cat("  terminal_depletion_P3_final.png (right panel)\n")
}


# ============================================================
# REVISED MODEL
# Fix P3 at stable MLE for Fleet 2 and Fleet 3
# Steepness fixed at h = 0.84
# ============================================================

# Best stable P3 values from likelihood profile
fixed_p3_fleet2 <- -0.5   # update from best_fit if different
fixed_p3_fleet3 <- -3.0   # update from best_fit if different

# Build stable seed using Fleet 3 fix first
stable_seed_dir <- file.path(dirname(base_dir), "stable_seed_run")
dir.create(stable_seed_dir, showWarnings = FALSE)
file.copy(list.files(base_dir, full.names = TRUE), stable_seed_dir, overwrite = TRUE)

dat_seed  <- SS_readdat(file.path(stable_seed_dir, "datafile.dat"), verbose = FALSE)
ctrl_seed <- SS_readctl(file.path(stable_seed_dir, "controlfile.ctl"), datlist = dat_seed, verbose = FALSE)

ctrl_seed$size_selex_parms["SizeSel_P_3_Fleet_3(3)", "INIT"]  <- fixed_p3_fleet3
ctrl_seed$size_selex_parms["SizeSel_P_3_Fleet_3(3)", "PHASE"] <- -3
ctrl_seed$size_selex_parms["SizeSel_P_3_Fleet_3(3)", "LO"]    <- -8

SS_writectl(ctllist = ctrl_seed,
            outfile = file.path(stable_seed_dir, "controlfile.ctl"),
            overwrite = TRUE)

r4ss::run(dir = stable_seed_dir, exe = "ss3",
          skipfinished = FALSE, show_in_console = TRUE)

out_seed  <- SS_output(stable_seed_dir, verbose = FALSE, printstats = FALSE)
B0_seed   <- out_seed$derived_quants["SSB_unfished", "Value"]
term_seed <- tail(out_seed$timeseries$SpawnBio, 1) / B0_seed

cat("Seed run — gradient:", out_seed$maximum_gradient_component,
    "| terminal B/B0:", round(term_seed, 3), "\n")

# Build full revised model using seed par file
revised_dir <- file.path(dirname(base_dir), "model_revised_v3")
dir.create(revised_dir, showWarnings = FALSE)
file.copy(list.files(base_dir, full.names = TRUE), revised_dir, overwrite = TRUE)

# Copy seed par file
par_file <- list.files(stable_seed_dir, pattern = "\\.par$")[1]
file.copy(file.path(stable_seed_dir, par_file),
          file.path(revised_dir, par_file), overwrite = TRUE)

# Fix both hook fleets P3 + steepness
dat_rev  <- SS_readdat(file.path(revised_dir, "datafile.dat"), verbose = FALSE)
ctrl_rev <- SS_readctl(file.path(revised_dir, "controlfile.ctl"), datlist = dat_rev, verbose = FALSE)

ctrl_rev$size_selex_parms["SizeSel_P_3_Fleet_2(2)", "INIT"]  <- fixed_p3_fleet2
ctrl_rev$size_selex_parms["SizeSel_P_3_Fleet_2(2)", "PHASE"] <- -3
ctrl_rev$size_selex_parms["SizeSel_P_3_Fleet_2(2)", "LO"]    <- -8

ctrl_rev$size_selex_parms["SizeSel_P_3_Fleet_3(3)", "INIT"]  <- fixed_p3_fleet3
ctrl_rev$size_selex_parms["SizeSel_P_3_Fleet_3(3)", "PHASE"] <- -3
ctrl_rev$size_selex_parms["SizeSel_P_3_Fleet_3(3)", "LO"]    <- -8

ctrl_rev$SR_parms["SR_BH_steep", "INIT"]  <- 0.84
ctrl_rev$SR_parms["SR_BH_steep", "PHASE"] <- -3

SS_writectl(ctllist = ctrl_rev,
            outfile = file.path(revised_dir, "controlfile.ctl"),
            overwrite = TRUE)

# Tell SS3 to start from par file
starter_rev <- SS_readstarter(file.path(revised_dir, "starter.ss"), verbose = FALSE)
starter_rev$init_values_src <- 1
SS_writestarter(starter_rev, revised_dir, overwrite = TRUE)

# Run no-hess check first
r4ss::run(dir = revised_dir, exe = "ss3", extras = "-nohess",
          skipfinished = FALSE, show_in_console = TRUE)

out_rev_check <- SS_output(revised_dir, verbose = FALSE, printstats = FALSE)
B0_check      <- out_rev_check$derived_quants["SSB_unfished", "Value"]
term_check    <- tail(out_rev_check$timeseries$SpawnBio, 1) / B0_check
cat("No-hess check — terminal B/B0:", round(term_check, 3), "\n")

if (term_check < 0.5) {
  # In correct mode — run full estimation
  starter_rev$init_values_src <- 0
  SS_writestarter(starter_rev, revised_dir, overwrite = TRUE)
  
  r4ss::run(dir = revised_dir, exe = "ss3",
            skipfinished = FALSE, show_in_console = TRUE)
  
  out_revised <- SS_output(revised_dir, verbose = FALSE, printstats = FALSE)
  B0_rev      <- out_revised$derived_quants["SSB_unfished", "Value"]
  term_rev    <- tail(out_revised$timeseries$SpawnBio, 1) / B0_rev
  
  cat("\n===== REVISED MODEL RESULTS =====\n")
  cat("Gradient     :", out_revised$maximum_gradient_component, "\n")
  cat("Terminal B/B0:", round(term_rev, 3), "\n")
  cat("Total like   :", out_revised$likelihoods_used["TOTAL", "values"], "\n")
} else {
  cat("WARNING: Still in wrong mode — try jitter approach\n")
}

# ============================================================
# CUBAN FLEET CPUE SENSITIVITY
# Remove Fleet 3 CPUE observations AND its Q parameter from control
# SS3 error: "no survey obs but Q setup was read" if obs removed
# but Q parameter left in control file
# ============================================================

no_cuban_dir <- file.path(dirname(base_dir), "model_no_cuban_cpue")
unlink(no_cuban_dir, recursive = TRUE)  # force clean copy from base_dir
dir.create(no_cuban_dir, showWarnings = FALSE)
file.copy(list.files(base_dir, full.names = TRUE), no_cuban_dir, overwrite = TRUE)

# --- Step 1: Remove Fleet 3 CPUE rows from data file ---
dat_nc <- SS_readdat(file.path(no_cuban_dir, "datafile.dat"), verbose = FALSE)

cat("CPUE fleets in data file:", unique(dat_nc$CPUE$index), "\n")
cat("CPUE rows before:", nrow(dat_nc$CPUE), "\n")

dat_nc$CPUE <- dat_nc$CPUE %>% filter(index != 3)  # remove Fleet 3 (Cuban) CPUE

cat("CPUE rows after :", nrow(dat_nc$CPUE), "\n")

SS_writedat(datlist   = dat_nc,
            outfile   = file.path(no_cuban_dir, "datafile.dat"),
            overwrite = TRUE)

# --- Step 2: Remove Fleet 3 Q setup from control file ---
# SS3 error "no survey obs but Q setup was read" means the Q fleet
# count in the control file still includes Fleet 3 even after removing
# it from Q_parms. SS_writectl does not always update this count.
# Fix: edit the control.ss text directly after SS_writectl.

remove_fleet_q <- function(ctrl_dir, fleet_to_remove) {
  # Edit all control files in ctrl_dir to remove a fleet's Q setup.
  # Both control.ss and controlfile.ctl are edited to handle cases
  # where starter.ss points to either one.
  
  # Find which file starter.ss declares as the control file
  starter_path <- file.path(ctrl_dir, "starter.ss")
  ctl_from_starter <- NULL
  if (file.exists(starter_path)) {
    starter_lines <- readLines(starter_path)
    data_ctrl <- starter_lines[!grepl("^#|^\\s*$", starter_lines)]
    if (length(data_ctrl) >= 2) {
      ctl_from_starter <- trimws(sub("#.*$", "", data_ctrl[2]))
      cat("  starter.ss declares control file:", ctl_from_starter, "\n")
    }
  }
  
  # Build list of control files to edit:
  # Always edit the starter-declared file first, plus any others present
  all_candidates <- c(ctl_from_starter,
                      "controlfile.ctl", "control.ss", "control.ctl")
  all_candidates <- unique(all_candidates[!is.null(all_candidates)])
  
  ctl_files_edited <- 0
  
  for (fn in all_candidates) {
    fp <- file.path(ctrl_dir, fn)
    if (!file.exists(fp)) next
    
    ctl <- readLines(fp)
    removed_setup <- 0
    removed_param <- 0
    
    for (i in seq_along(ctl)) {
      ln <- trimws(ctl[i])
      
      # (a) Q_setup row — tab or space separated, #_Fleet_N comment
      if (grepl(paste0("^", fleet_to_remove, "[[:space:]]+[0-9]"), ln) &&
          grepl(paste0("[Ff]leet[_[:space:]]+", fleet_to_remove,
                       "([^0-9]|$)"), ctl[i])) {
        cat("  [", fn, "] Setup row  line", i, ":", ln, "\n")
        ctl[i] <- paste0("# REMOVED ", ctl[i])
        removed_setup <- removed_setup + 1
      }
      
      # (b) LnQ parameter line
      if (grepl(paste0("LnQ_base_Fleet_", fleet_to_remove,
                       "\\(", fleet_to_remove, "\\)"), ln)) {
        cat("  [", fn, "] LnQ param   line", i, ":", ln, "\n")
        ctl[i] <- paste0("# REMOVED ", ctl[i])
        removed_param <- removed_param + 1
      }
    }
    
    if (removed_setup > 0 || removed_param > 0) {
      writeLines(ctl, fp, sep = "\r\n")
      cat("  [", fn, "] Saved —", removed_setup,
          "setup row(s),", removed_param, "LnQ param(s) removed\n")
      ctl_files_edited <- ctl_files_edited + 1
    } else {
      cat("  [", fn, "] No Fleet", fleet_to_remove,
          "Q entries found — skipping\n")
    }
  }
  
  if (ctl_files_edited == 0)
    warning("Fleet ", fleet_to_remove,
            " Q entries not found in any control file in ", ctrl_dir)
  
  cat("Done — edited", ctl_files_edited, "control file(s)\n")
}


# Apply to Fleet 3 (Cuban mid-range)
remove_fleet_q(no_cuban_dir, fleet_to_remove = 3)

# Verify: print Q section lines after edit
ctl_v <- readLines(file.path(no_cuban_dir, "controlfile.ctl"))
cat("
=== Q section after Fleet 3 removal ===
")
for (ln in grep("Q_setup|LnQ|Fleet_[0-9]|-9999", ctl_v)) {
  cat(sprintf("  Line %3d: %s
", ln, trimws(ctl_v[ln])))
}
cat("=======================================

")

# --- Step 3: Run model ---
r4ss::run(dir             = no_cuban_dir,
          exe             = "ss3",
          skipfinished    = FALSE,
          show_in_console = TRUE)

# Check for errors before reading output
warn_file <- file.path(no_cuban_dir, "warning.sso")
if (file.exists(warn_file)) {
  warns <- readLines(warn_file)
  fatal <- warns[grepl("Fatal|Error", warns, ignore.case = TRUE)]
  if (length(fatal) > 0) {
    cat("\nFatal warnings:\n")
    cat(fatal, sep = "\n")
    stop("Model run failed — check warning.sso")
  }
}

out_nc  <- SS_output(no_cuban_dir, verbose = FALSE, printstats = FALSE)
B0_nc   <- out_nc$derived_quants["SSB_unfished", "Value"]
ts_nc   <- out_nc$timeseries %>% filter(Era == "TIME", !is.na(SpawnBio))
term_nc <- tail(ts_nc$SpawnBio, 1) / B0_nc

cat("No-Cuban-CPUE model — gradient:", out_nc$maximum_gradient_component,
    "| terminal B/B0:", round(term_nc, 3), "\n")

# Compare trajectories
compare_ts <- bind_rows(
  base_out$timeseries %>%
    filter(Yr >= 1950) %>%
    mutate(depletion = SpawnBio / B0_base,
           model = "Base (with Cuban CPUE)"),
  out_nc$timeseries %>%
    filter(Yr >= 1950) %>%
    mutate(depletion = SpawnBio / B0_nc,
           model = "No Cuban CPUE")
)

p_compare <- ggplot(compare_ts, aes(x = Yr, y = depletion,
                                    color = model, linetype = model)) +
  geom_line(linewidth = 1.2) +
  geom_hline(yintercept = 0.40, linetype = "dashed", color = "red",    linewidth = 0.7) +
  geom_hline(yintercept = 0.25, linetype = "dashed", color = "darkred", linewidth = 0.7) +
  scale_color_manual(values = c("Base (with Cuban CPUE)" = "steelblue",
                                "No Cuban CPUE"          = "darkorange"),
                     name = NULL) +
  scale_linetype_manual(values = c("Base (with Cuban CPUE)" = "solid",
                                   "No Cuban CPUE"          = "dashed"),
                        name = NULL) +
  labs(title    = "Base Model vs. Model Without Cuban Fleet CPUE",
       subtitle = "Testing whether Cuban CPUE (Fleet 3) is source of instability",
       x = "Year", y = "Fraction of unfished biomass (B/B\u2080)") +
  theme_bw(base_size = 12) +
  theme(legend.position = "top")

ggsave("comparison_base_vs_no_cuban_cpue.png", p_compare, width = 9, height = 6, dpi = 300)

# ============================================================
# FLEET 2 CPUE SENSITIVITY
# Remove Fleet 2 (Mexican mid-range) CPUE, keep catch
# Mirrors Section 9 (Fleet 3 / Cuban CPUE sensitivity)
# Allows comparison: which fleet CPUE drives stock status?
# ============================================================

no_fleet2_dir <- file.path(dirname(base_dir), "model_no_fleet2_cpue")
unlink(no_fleet2_dir, recursive = TRUE)  # force clean copy from base_dir
dir.create(no_fleet2_dir, showWarnings = FALSE)
file.copy(list.files(base_dir, full.names = TRUE), no_fleet2_dir, overwrite = TRUE)

# --- Step 1: Remove Fleet 2 CPUE rows from data file ---
dat_f2 <- SS_readdat(file.path(no_fleet2_dir, "datafile.dat"), verbose = FALSE)

cat("CPUE fleets before removal:", unique(dat_f2$CPUE$index), "\n")
cat("CPUE rows before:", nrow(dat_f2$CPUE), "\n")

dat_f2$CPUE <- dat_f2$CPUE %>% filter(index != 2)  # remove Fleet 2 (Mexican mid-range) CPUE

cat("CPUE rows after :", nrow(dat_f2$CPUE), "\n")
cat("CPUE fleets after removal:", unique(dat_f2$CPUE$index), "\n")

SS_writedat(datlist   = dat_f2,
            outfile   = file.path(no_fleet2_dir, "datafile.dat"),
            overwrite = TRUE)

# --- Step 2: Remove Fleet 2 Q setup from controlfile.ctl ---
# Re-source the function to ensure the latest version is loaded,
# then edit controlfile.ctl directly by line number as a fallback.

# Primary: use the function
remove_fleet_q(no_fleet2_dir, fleet_to_remove = 2)

# Fallback: direct line edit if function used wrong/old version
# (run this block if SS3 still gives Q setup error after above)
# {
#   ctl_path <- file.path(no_fleet2_dir, "controlfile.ctl")
#   ctl <- readLines(ctl_path)
#   # Find and comment out Fleet 2 rows
#   for (i in seq_along(ctl)) {
#     if (grepl("^\\s*2\\s+[0-9].*Fleet_2", trimws(ctl[i]))) {
#       ctl[i] <- paste0("# REMOVED ", ctl[i]); cat("Setup removed line", i, "\n")
#     }
#     if (grepl("LnQ_base_Fleet_2\\(2\\)", ctl[i])) {
#       ctl[i] <- paste0("# REMOVED ", ctl[i]); cat("LnQ removed line", i, "\n")
#     }
#   }
#   writeLines(ctl, ctl_path, sep = "\r\n")
#   cat("Direct edit saved.\n")
# }

# Verify the edit worked — print Q section of modified control.ss
ctl_check <- readLines(file.path(no_fleet2_dir, "controlfile.ctl"))
q_section_lines <- grep("Q_setup|LnQ|Fleet_[0-9]|\\-9999", ctl_check)
cat("\n=== Q section in modified control.ss ===\n")
for (ln in q_section_lines) {
  cat(sprintf("  Line %3d: %s\n", ln, trimws(ctl_check[ln])))
}
cat("=========================================\n")



# --- Step 3: Run model ---
r4ss::run(dir             = no_fleet2_dir,
          exe             = "ss3",
          skipfinished    = FALSE,
          show_in_console = TRUE)

# Check for fatal errors
warn_f2 <- file.path(no_fleet2_dir, "warning.sso")
if (file.exists(warn_f2)) {
  warns_f2 <- readLines(warn_f2)
  fatal_f2 <- warns_f2[grepl("Fatal|Error", warns_f2, ignore.case = TRUE)]
  if (length(fatal_f2) > 0) {
    cat("Fatal warnings:\n")
    cat(fatal_f2, sep = "\n")
    stop("Fleet 2 model run failed — check warning.sso")
  }
}

out_f2   <- SS_output(no_fleet2_dir, verbose = FALSE, printstats = FALSE)
B0_f2    <- out_f2$derived_quants["SSB_unfished", "Value"]
ts_f2    <- out_f2$timeseries %>% filter(Era == "TIME", !is.na(SpawnBio))
term_f2  <- tail(ts_f2$SpawnBio, 1) / B0_f2

cat("\nNo-Fleet2-CPUE model — gradient:", out_f2$maximum_gradient_component,
    "| terminal B/B0:", round(term_f2, 3), "\n")

# ============================================================
# THREE-WAY COMPARISON: Base vs. No Fleet 3 CPUE vs. No Fleet 2 CPUE
# ============================================================

# Reload no-Cuban result if not already in environment
if (!exists("out_nc")) {
  out_nc  <- SS_output(no_cuban_dir, verbose = FALSE, printstats = FALSE)
  B0_nc   <- out_nc$derived_quants["SSB_unfished", "Value"]
  ts_nc   <- out_nc$timeseries %>% filter(Era == "TIME", !is.na(SpawnBio))
  term_nc <- tail(ts_nc$SpawnBio, 1) / B0_nc
}

compare_ts3 <- bind_rows(
  base_out$timeseries %>%
    filter(Era == "TIME", Yr >= 1950) %>%
    mutate(depletion = SpawnBio / B0_base,
           model     = "Base (all CPUE indices)"),
  out_nc$timeseries %>%
    filter(Era == "TIME", Yr >= 1950) %>%
    mutate(depletion = SpawnBio / B0_nc,
           model     = "No Fleet 3 CPUE (Cuban)"),
  out_f2$timeseries %>%
    filter(Era == "TIME", Yr >= 1950) %>%
    mutate(depletion = SpawnBio / B0_f2,
           model     = "No Fleet 2 CPUE (Mex mid-range)")
)

# Summary table
cat("\n===== CPUE SENSITIVITY COMPARISON =====\n")
cat(sprintf("%-38s %-10s %-10s %-10s\n",
            "Metric", "Base", "No Flt3", "No Flt2"))
cat(strrep("-", 70), "\n")
cat(sprintf("%-38s %-10.3f %-10.3f %-10.3f\n",
            "Terminal B/B0 (last data year)",
            tail(base_out$timeseries$SpawnBio[
              base_out$timeseries$Era == "TIME" &
                !is.na(base_out$timeseries$SpawnBio)], 1) / B0_base,
            term_nc, term_f2))
cat(sprintf("%-38s %-10.2e %-10.2e %-10.2e\n",
            "Max gradient",
            base_out$maximum_gradient_component,
            out_nc$maximum_gradient_component,
            out_f2$maximum_gradient_component))
cat(sprintf("%-38s %-10.2f %-10.2f %-10.2f\n",
            "Total likelihood",
            base_out$likelihoods_used["TOTAL", "values"],
            out_nc$likelihoods_used["TOTAL", "values"],
            out_f2$likelihoods_used["TOTAL", "values"]))
cat(sprintf("%-38s %-10s %-10s %-10s\n",
            "CPUE removed",
            "none", "Fleet 3", "Fleet 2"))
cat(strrep("-", 70), "\n")

# Plot: three-way comparison
model_colors <- c(
  "Base (all CPUE indices)"            = "black",
  "No Fleet 3 CPUE (Cuban)"            = "darkorange",
  "No Fleet 2 CPUE (Mex mid-range)"    = "steelblue"
)
model_linetypes <- c(
  "Base (all CPUE indices)"            = "solid",
  "No Fleet 3 CPUE (Cuban)"            = "dashed",
  "No Fleet 2 CPUE (Mex mid-range)"    = "dotdash"
)

p_cpue_compare <- ggplot(compare_ts3,
                         aes(x        = Yr,
                             y        = depletion,
                             color    = model,
                             linetype = model)) +
  geom_line(linewidth = 1.2) +
  geom_hline(yintercept = 0.40, linetype = "dashed",
             color = "red",     linewidth = 0.7) +
  geom_hline(yintercept = 0.25, linetype = "dashed",
             color = "darkred", linewidth = 0.7) +
  annotate("text", x = 1953, y = 0.42,
           label = "Management target (0.40)",
           color = "red",     hjust = 0, size = 3) +
  annotate("text", x = 1953, y = 0.27,
           label = "Minimum threshold (0.25)",
           color = "darkred", hjust = 0, size = 3) +
  scale_color_manual(values = model_colors,    name = NULL) +
  scale_linetype_manual(values = model_linetypes, name = NULL) +
  labs(
    title    = "CPUE Index Sensitivity: Base vs. Fleet-Removed Models",
    subtitle = paste0(
      "Base B/B\u2080 = ", round(tail(base_out$timeseries$SpawnBio[
        base_out$timeseries$Era == "TIME" &
          !is.na(base_out$timeseries$SpawnBio)], 1) / B0_base, 3),
      " | No Fleet 3: ", round(term_nc, 3),
      " | No Fleet 2: ", round(term_f2, 3)),
    x = "Year",
    y = "Fraction of unfished biomass (B/B\u2080)"
  ) +
  theme_bw(base_size = 12) +
  theme(legend.position = "top",
        legend.text     = element_text(size = 10))

ggsave("comparison_cpue_sensitivity_3way.png", p_cpue_compare,
       width = 10, height = 6, dpi = 300)
cat("Three-way CPUE comparison figure saved.\n")

# Individual panel comparison (2 x 1 layout)
p_nc_panel <- ggplot(
  compare_ts3 %>% filter(model != "No Fleet 2 CPUE (Mex mid-range)"),
  aes(x = Yr, y = depletion, color = model, linetype = model)) +
  geom_line(linewidth = 1.2) +
  geom_hline(yintercept = 0.40, linetype = "dashed", color = "red",     linewidth = 0.7) +
  geom_hline(yintercept = 0.25, linetype = "dashed", color = "darkred", linewidth = 0.7) +
  scale_color_manual(
    values = model_colors[c("Base (all CPUE indices)", "No Fleet 3 CPUE (Cuban)")],
    name   = NULL) +
  scale_linetype_manual(
    values = model_linetypes[c("Base (all CPUE indices)", "No Fleet 3 CPUE (Cuban)")],
    name   = NULL) +
  labs(title = "Fleet 3 (Cuban) CPUE removed",
       x = "Year", y = "B/B\u2080") +
  theme_bw(base_size = 11) +
  theme(legend.position = "bottom")

p_f2_panel <- ggplot(
  compare_ts3 %>% filter(model != "No Fleet 3 CPUE (Cuban)"),
  aes(x = Yr, y = depletion, color = model, linetype = model)) +
  geom_line(linewidth = 1.2) +
  geom_hline(yintercept = 0.40, linetype = "dashed", color = "red",     linewidth = 0.7) +
  geom_hline(yintercept = 0.25, linetype = "dashed", color = "darkred", linewidth = 0.7) +
  scale_color_manual(
    values = model_colors[c("Base (all CPUE indices)", "No Fleet 2 CPUE (Mex mid-range)")],
    name   = NULL) +
  scale_linetype_manual(
    values = model_linetypes[c("Base (all CPUE indices)", "No Fleet 2 CPUE (Mex mid-range)")],
    name   = NULL) +
  labs(title = "Fleet 2 (Mexican mid-range) CPUE removed",
       x = "Year", y = "B/B\u2080") +
  theme_bw(base_size = 11) +
  theme(legend.position = "bottom")

# Combine panels
if (requireNamespace("patchwork", quietly = TRUE)) {
  p_panels <- patchwork::wrap_plots(p_nc_panel, p_f2_panel, ncol = 2)
} else if (requireNamespace("cowplot", quietly = TRUE)) {
  p_panels <- cowplot::plot_grid(p_nc_panel, p_f2_panel, ncol = 2)
} else if (requireNamespace("gridExtra", quietly = TRUE)) {
  p_panels <- gridExtra::arrangeGrob(
    ggplotGrob(p_nc_panel), ggplotGrob(p_f2_panel), ncol = 2)
}

if (exists("p_panels")) {
  ggsave("comparison_cpue_panels.png", p_panels,
         width = 14, height = 6, dpi = 300)
  cat("Two-panel CPUE comparison figure saved.\n")
}

# ============================================================
# RETROSPECTIVE ANALYSIS ON REVISED MODEL
# ============================================================

retro_dir <- file.path(dirname(base_dir), "revised_retrospective")
dir.create(retro_dir, showWarnings = FALSE)
file.copy(list.files(revised_dir, full.names = TRUE), retro_dir, overwrite = TRUE)

r4ss::retro(dir = retro_dir, exe = "ss3", years = 0:-5, verbose = TRUE)

# Read all peel outputs
retro_models <- list()
peel_dirs    <- list.dirs(file.path(retro_dir, "retrospectives"),
                          recursive = FALSE, full.names = TRUE)

for (pd in peel_dirs) {
  nm <- basename(pd)
  retro_models[[nm]] <- tryCatch(
    SS_output(pd, repfile = "Report.sso", compfile = "CompReport.sso",
              covarfile = "covar.sso", forefile = "Forecast-report.sso",
              verbose = FALSE, printstats = FALSE),
    error = function(e) { cat("Error reading", nm, "\n"); NULL }
  )
}

# Sort reference (longest time series) first
# Sort: retro0 first (reference), then retro-1 to retro-5 by peel number
# Do NOT sort by end year — SS3 forecast years inflate max(Yr) for all models
retro_models <- Filter(Negate(is.null), retro_models)
peel_order   <- c("retro0", paste0("retro-", 1:5))
peel_order   <- peel_order[peel_order %in% names(retro_models)]
retro_models <- retro_models[peel_order]

cat("\nModel order (retro0 = reference, then peels):\n")
for (nm in names(retro_models)) {
  ts_nm    <- retro_models[[nm]]$timeseries
  data_yrs <- ts_nm$Yr[ts_nm$Era == "TIME" & !is.na(ts_nm$SpawnBio)]
  cat(" ", nm, "| last data yr:", max(data_yrs), "\n")
}

# ============================================================
# Manual Mohn's rho — stable peels only
# ============================================================

calculate_mohns <- function(model_list, b0_threshold = 1.0) {
  # IMPORTANT: use Era == "TIME" to exclude forecast years from terminal year
  # detection. SS3 timeseries includes forecast years which have inflated SSB.
  
  # Reference model must be retro0 (full data, longest series)
  ref_nm <- if ("retro0" %in% names(model_list)) "retro0" else names(model_list)[1]
  ref    <- model_list[[ref_nm]]
  
  ref_ts <- ref$timeseries %>%
    filter(!is.na(SpawnBio), SpawnBio > 0, Era == "TIME")
  
  ref_endyr <- max(ref_ts$Yr)
  cat("Reference model:", ref_nm, "| last data year:", ref_endyr, "\n")
  
  cat(sprintf("\n%-10s %-6s %-12s %-12s %-10s %-10s\n",
              "Peel", "EndYr", "SSB_ref", "SSB_peel", "rho", "status"))
  cat(strrep("-", 65), "\n")
  
  rho_stable <- c()
  
  for (nm in names(model_list)) {
    if (nm == ref_nm) next
    peel <- model_list[[nm]]
    if (is.null(peel)) next
    
    # Use Era == "TIME" for peel terminal year too
    peel_ts <- peel$timeseries %>%
      filter(!is.na(SpawnBio), SpawnBio > 0, Era == "TIME")
    B0_peel <- peel$derived_quants["SSB_unfished", "Value"]
    term_yr <- max(peel_ts$Yr)
    
    ssb_peel <- peel_ts$SpawnBio[peel_ts$Yr == term_yr]
    ssb_ref  <- ref_ts$SpawnBio[ref_ts$Yr  == term_yr]
    dep_peel <- ssb_peel / B0_peel
    grad     <- peel$maximum_gradient_component
    
    is_stable <- dep_peel < b0_threshold & dep_peel > 0 & grad < 0.001
    
    if (length(ssb_ref) > 0 && length(ssb_peel) > 0) {
      rho_i <- (ssb_peel - ssb_ref) / ssb_ref
      if (is_stable) rho_stable <- c(rho_stable, setNames(rho_i, nm))
      cat(sprintf("%-10s %-6d %-12.1f %-12.1f %-10.4f %-10s\n",
                  nm, term_yr,
                  ssb_ref, ssb_peel, rho_i,
                  ifelse(is_stable, "OK", "excluded")))
    } else {
      cat(sprintf("%-10s %-6d %-12s %-12s %-10s %-10s\n",
                  nm, term_yr, "NA", "NA", "NA",
                  "data missing"))
    }
  }
  
  mohn <- mean(rho_stable)
  cat(strrep("-", 65), "\n")
  cat("Mohn's rho (stable peels):", round(mohn, 4),
      "(n =", length(rho_stable), ")\n")
  cat("Status:", ifelse(abs(mohn) <= 0.20, "ACCEPTABLE",
                        ifelse(abs(mohn) <= 0.30, "MARGINAL", "CONCERNING")), "\n")
  return(list(rho = mohn, n = length(rho_stable), values = rho_stable))
}

# Re-run unstable peels with jitter if needed
rerun_with_jitter <- function(peel_name, retro_models, n_jitter = 20) {
  # retro0 may be directly in retro_dir or in retrospectives subdir
  peel_path <- file.path(retro_dir, "retrospectives", peel_name)
  if (!dir.exists(peel_path)) {
    peel_path <- file.path(retro_dir, peel_name)
  }
  if (!dir.exists(peel_path)) {
    cat("Cannot find directory for", peel_name, "\n")
    return(NULL)
  }
  best <- NULL; best_like <- Inf
  
  for (j in 1:n_jitter) {
    jd <- file.path(dirname(base_dir), sprintf("jitter_%s_%02d", peel_name, j))
    dir.create(jd, showWarnings = FALSE)
    file.copy(list.files(peel_path, full.names = TRUE), jd, overwrite = TRUE)
    
    s <- SS_readstarter(file.path(jd, "starter.ss"), verbose = FALSE)
    s$jitter_fraction <- 0.1
    SS_writestarter(s, jd, overwrite = TRUE)
    
    r4ss::run(dir = jd, exe = "ss3", skipfinished = FALSE, show_in_console = FALSE)
    
    out_j <- tryCatch(
      SS_output(jd, repfile = "Report.sso", compfile = "CompReport.sso",
                covarfile = "covar.sso", forefile = "Forecast-report.sso",
                verbose = FALSE, printstats = FALSE),
      error = function(e) NULL
    )
    
    if (!is.null(out_j)) {
      B0_j   <- out_j$derived_quants["SSB_unfished", "Value"]
      term_j <- tail(out_j$timeseries$SpawnBio[!is.na(out_j$timeseries$SpawnBio)], 1) / B0_j
      like_j <- out_j$likelihoods_used["TOTAL", "values"]
      grad_j <- out_j$maximum_gradient_component
      cat(sprintf("  jitter %02d | B/B0: %.3f | like: %.2f | grad: %.2e\n",
                  j, term_j, like_j, grad_j))
      
      if (term_j < 1.0 & term_j > 0 & grad_j < 0.001 & like_j < best_like) {
        best_like <- like_j
        best      <- out_j
      }
    }
  }
  return(best)
}

# Check stability of each peel
cat("\nPeel stability check (data years only, Era == TIME):\n")
for (nm in names(retro_models)) {
  if (is.null(retro_models[[nm]])) next
  B0_nm   <- retro_models[[nm]]$derived_quants["SSB_unfished", "Value"]
  ts_nm   <- retro_models[[nm]]$timeseries %>%
    filter(!is.na(SpawnBio), SpawnBio > 0, Era == "TIME")
  term_nm <- tail(ts_nm$SpawnBio, 1) / B0_nm
  grad_nm <- retro_models[[nm]]$maximum_gradient_component
  term_yr_nm <- max(ts_nm$Yr)
  cat(sprintf("  %-10s | end yr: %4d | B/B0: %.3f | grad: %.2e | %s\n",
              nm, term_yr_nm, term_nm, grad_nm,
              ifelse(term_nm < 1 & grad_nm < 0.001, "OK", "UNSTABLE — jitter needed")))
}

# Re-run unstable peels with jitter automatically
unstable_peels <- c()
for (nm in names(retro_models)) {
  if (is.null(retro_models[[nm]])) next
  if (nm == "retro0") next  # reference — handle separately below
  B0_nm    <- retro_models[[nm]]$derived_quants["SSB_unfished", "Value"]
  ts_nm    <- retro_models[[nm]]$timeseries %>%
    filter(!is.na(SpawnBio), SpawnBio > 0, Era == "TIME")
  term_nm  <- tail(ts_nm$SpawnBio, 1) / B0_nm
  grad_nm  <- retro_models[[nm]]$maximum_gradient_component
  if (term_nm >= 1 | grad_nm >= 0.001) {
    unstable_peels <- c(unstable_peels, nm)
  }
}

# Also check retro0 reference model
if (!is.null(retro_models[["retro0"]])) {
  grad_ref <- retro_models[["retro0"]]$maximum_gradient_component
  if (grad_ref >= 0.001) {
    cat("WARNING: retro0 (reference) gradient =", grad_ref,
        "— re-running with jitter\n")
    retro_models[["retro0"]] <- rerun_with_jitter("retro0", retro_models, n_jitter = 20)
  }
}

if (length(unstable_peels) > 0) {
  cat("Unstable peels to re-run:", paste(unstable_peels, collapse = ", "), "\n")
  for (peel_nm in unstable_peels) {
    cat("Re-running", peel_nm, "with jitter...\n")
    result <- rerun_with_jitter(peel_nm, retro_models, n_jitter = 20)
    if (!is.null(result)) {
      retro_models[[peel_nm]] <- result
      cat("  Replaced", peel_nm, "with stable jitter result\n")
    } else {
      cat("  No stable solution found for", peel_nm,
          "— will be excluded from Mohn's rho\n")
    }
  }
} else {
  cat("All peels stable — no jitter needed\n")
}

# Calculate Mohn's rho
mohns <- calculate_mohns(retro_models)

# ============================================================
# RETROSPECTIVE PLOT
# ============================================================

retro_ts_df <- bind_rows(
  lapply(names(retro_models), function(nm) {
    out <- retro_models[[nm]]
    if (is.null(out)) return(NULL)
    B0    <- out$derived_quants["SSB_unfished", "Value"]
    ts_data <- out$timeseries %>%
      filter(!is.na(SpawnBio), SpawnBio > 0, Era == "TIME")
    dep <- tail(ts_data$SpawnBio, 1) / B0
    # Plot only data years (Era == TIME) to avoid forecast tail distortion
    ts_data %>%
      filter(Yr >= 1950) %>%
      mutate(depletion = SpawnBio / B0,
             model     = nm,
             is_ref    = nm == "retro0",
             stable    = dep < 1.0 & out$maximum_gradient_component < 0.001)
  })
) %>%
  mutate(model = factor(model, levels = names(retro_models)))

n_peels     <- length(retro_models) - 1
peel_colors <- setNames(
  c("black", RColorBrewer::brewer.pal(max(n_peels, 3), "Set1")[1:n_peels]),
  names(retro_models)
)
peel_labels <- setNames(
  c("Reference (full)", paste0("Retro \u2212", 1:n_peels)),
  names(retro_models)
)

# Use manual calculation result (mohns$rho from calculate_mohns above)
# NOTE: SSmohnsrho() returned an erroneous value (47467.718) because all
# peels initially had the same end year. The manual calculation gives the
# correct value (+0.276) and is used for Figure S6.5.
mohn_label <- paste0("Mohn's rho (SSB) = ", round(mohns$rho, 3))
cat("\nFigure S6.5 Mohn's rho label:", mohn_label, "\n")

p_retro <- ggplot(retro_ts_df,
                  aes(x = Yr, y = depletion, color = model,
                      linetype = stable, linewidth = is_ref)) +
  geom_line() +
  geom_hline(yintercept = 0.25, linetype = "dashed", color = "darkred", linewidth = 0.7) +
  geom_hline(yintercept = 0.40, linetype = "dashed", color = "red",     linewidth = 0.7) +
  annotate("text", x = 1953, y = 0.42, label = "Management target (0.40)",
           color = "red",     size = 3) +
  annotate("text", x = 1953, y = 0.27, label = "Minimum threshold (0.25)",
           color = "darkred", size = 3) +
  annotate("text",
           x        = max(retro_ts_df$Yr) - 3,
           y        = 0.88,
           label    = mohn_label,
           hjust    = 1,
           size     = 4,
           fontface = "bold") +
  scale_color_manual(values = peel_colors, labels = peel_labels, name = NULL) +
  scale_linetype_manual(values = c("TRUE" = "solid", "FALSE" = "dashed"), guide = "none") +
  scale_discrete_manual("linewidth", values = c("TRUE" = 1.5, "FALSE" = 0.8), guide = "none") +
  labs(title    = "Retrospective Analysis - Revised Model",
       subtitle = paste0("Sequential removal of 1-5 terminal years | Mohn's rho (SSB) = ",
                         round(mohns$rho, 3)),
       x = "Year", y = "Fraction of unfished biomass (B/B\u2080)") +
  theme_bw(base_size = 12) +
  theme(legend.position = "right")

ggsave("retrospective_revised_final.png", p_retro, width = 10, height = 6, dpi = 300)

# ============================================================
# FINAL SUMMARY
# ============================================================

cat("\n========== FINAL SUMMARY ==========\n")
cat(sprintf("%-38s %-15s %-15s\n", "Metric", "Base model", "Revised model"))
cat(strrep("-", 70), "\n")
cat(sprintf("%-38s %-15.3f %-15.3f\n", "Terminal B/B0",
            round(tail(base_out$timeseries$SpawnBio, 1) / B0_base, 3),
            round(term_rev, 3)))
cat(sprintf("%-38s %-15.2f %-15.2f\n", "Total likelihood",
            base_out$likelihoods_used["TOTAL", "values"],
            out_revised$likelihoods_used["TOTAL", "values"]))
cat(sprintf("%-38s %-15s %-15s\n", "Max gradient",
            formatC(base_out$maximum_gradient_component, format = "e", digits = 2),
            formatC(out_revised$maximum_gradient_component, format = "e", digits = 2)))
cat(sprintf("%-38s %-15s %-15.3f\n", "SSB Mohn's rho", "-0.330", mohns$rho))
cat(sprintf("%-38s %-15s %-15s\n", "Fleet 2 P\u2083 (Mex mid-range)",
            "LO (at bound)", paste0("Fixed at ", fixed_p3_fleet2)))
cat(sprintf("%-38s %-15s %-15s\n", "Fleet 3 P\u2083 (Cuban mid-range)",
            "LO/CHECK (bound)", paste0("Fixed at ", fixed_p3_fleet3)))
cat("\n--- CPUE sensitivity (terminal B/B0) ---\n")
if (exists("term_nc") && exists("term_f2")) {
  cat(sprintf("  Base model              : %.3f\n",
              tail(base_out$timeseries$SpawnBio[
                base_out$timeseries$Era == "TIME" &
                  !is.na(base_out$timeseries$SpawnBio)], 1) / B0_base))
  cat(sprintf("  No Fleet 3 CPUE (Cuban) : %.3f\n", term_nc))
  cat(sprintf("  No Fleet 2 CPUE (Mex)   : %.3f\n", term_f2))
}
cat(sprintf("%-38s %-15s %-15s\n", "Fleet 4 P\u2083 (trawlers)",
            "not applicable", "logistic selectivity"))
cat(sprintf("%-38s %-15s %-15s\n", "Steepness (h)",
            "HI/CHECK (bound)", "Fixed at 0.84"))
cat(strrep("-", 70), "\n")

write.csv(all_metrics_df, "sensitivity_P3_summary.csv", row.names = FALSE)
cat("Summary CSV saved.\n")

# ============================================================
# STEEPNESS SENSITIVITY (Figure S6.1)
# IMPORTANT: Run from REVISED model (P3 fixed) not base model.
# Base model has unconstrained P3 which causes wrong-mode solutions
# when h is fixed at low values.
# ============================================================

run_steepness_scenario <- function(revised_dir, h_value, scenario_name,
                                   n_jitter = 15) {
  
  scenario_dir <- file.path(dirname(revised_dir), scenario_name)
  dir.create(scenario_dir, showWarnings = FALSE)
  file.copy(list.files(revised_dir, full.names = TRUE),
            scenario_dir, overwrite = TRUE)
  
  dat  <- SS_readdat(file.path(scenario_dir, "datafile.dat"),  verbose = FALSE)
  ctrl <- SS_readctl(file.path(scenario_dir, "controlfile.ctl"),
                     datlist = dat, verbose = FALSE)
  
  # Fix steepness at target value
  ctrl$SR_parms["SR_BH_steep", "INIT"]  <- h_value
  ctrl$SR_parms["SR_BH_steep", "PHASE"] <- -3
  
  SS_writectl(ctllist = ctrl,
              outfile = file.path(scenario_dir, "controlfile.ctl"),
              overwrite = TRUE)
  
  # First attempt (no jitter)
  run_ok <- tryCatch({
    r4ss::run(dir = scenario_dir, exe = "ss3",
              skipfinished = FALSE, show_in_console = FALSE)
    TRUE
  }, error = function(e) FALSE)
  
  if (!run_ok || !file.exists(file.path(scenario_dir, "Report.sso")))
    return(NULL)
  
  out <- tryCatch(
    SS_output(scenario_dir, verbose = FALSE, printstats = FALSE),
    error = function(e) NULL
  )
  if (is.null(out)) return(NULL)
  
  # Check for biologically plausible result
  B0_h   <- out$derived_quants["SSB_unfished", "Value"]
  ts_h   <- out$timeseries %>%
    filter(Era == "TIME", !is.na(SpawnBio))
  term_h <- tail(ts_h$SpawnBio, 1) / B0_h
  grad_h <- out$maximum_gradient_component
  
  is_stable <- term_h <= 1.0 & term_h > 0 & grad_h < 0.001
  
  # If implausible, jitter to find correct mode
  if (!is_stable) {
    cat("    h =", h_value, "| B/B0 =", round(term_h, 3),
        "— implausible, jittering...\n")
    
    best_out  <- NULL
    best_like <- Inf
    
    for (j in seq_len(n_jitter)) {
      jd <- file.path(dirname(revised_dir),
                      paste0(scenario_name, "_jitter", sprintf("%02d", j)))
      dir.create(jd, showWarnings = FALSE)
      file.copy(list.files(scenario_dir, full.names = TRUE), jd, overwrite = TRUE)
      
      s <- SS_readstarter(file.path(jd, "starter.ss"), verbose = FALSE)
      s$jitter_fraction <- 0.1
      SS_writestarter(s, jd, overwrite = TRUE)
      
      r4ss::run(dir = jd, exe = "ss3",
                skipfinished = FALSE, show_in_console = FALSE)
      
      out_j <- tryCatch(
        SS_output(jd, verbose = FALSE, printstats = FALSE),
        error = function(e) NULL
      )
      
      if (!is.null(out_j)) {
        B0_j   <- out_j$derived_quants["SSB_unfished", "Value"]
        ts_j   <- out_j$timeseries %>% filter(Era == "TIME", !is.na(SpawnBio))
        term_j <- tail(ts_j$SpawnBio, 1) / B0_j
        like_j <- out_j$likelihoods_used["TOTAL", "values"]
        grad_j <- out_j$maximum_gradient_component
        
        if (term_j <= 1.0 & term_j > 0 & grad_j < 0.001 & like_j < best_like) {
          best_like <- like_j
          best_out  <- out_j
          cat("      jitter", j, "| B/B0:", round(term_j, 3),
              "| like:", round(like_j, 2), "✓\n")
        }
      }
    }
    
    if (!is.null(best_out)) {
      out <- best_out
      cat("    h =", h_value, "— stable solution found via jitter\n")
    } else {
      cat("    h =", h_value, "— no stable solution found, EXCLUDED\n")
      return(NULL)
    }
  }
  
  return(out)
}

# Point to REVISED model, not base model
revised_dir <- file.path(dirname(base_dir), "model_revised_v3")

h_values <- seq(0.60, 0.90, by = 0.02)
h_results <- list()
h_ts      <- list()

cat("Running steepness sensitivity from REVISED model",
    "(h =", min(h_values), "to", max(h_values), ")\n")

for (h in h_values) {
  scenario_name <- sprintf("steep_h%.2f", h)
  cat("h =", h, "\n")
  
  out <- run_steepness_scenario(revised_dir, h, scenario_name, n_jitter = 15)
  
  if (!is.null(out)) {
    B0_h <- out$derived_quants["SSB_unfished", "Value"]
    ts_h <- out$timeseries %>%
      filter(Era == "TIME", Yr >= 1950) %>%
      mutate(depletion = SpawnBio / B0_h,
             h_value   = h,
             is_base   = abs(h - 0.84) < 0.001)
    h_ts[[scenario_name]] <- ts_h
    h_results[[scenario_name]] <- list(
      h_value      = h,
      terminal_dep = tail(ts_h$depletion, 1),
      gradient     = out$maximum_gradient_component
    )
    cat("  OK | terminal B/B0:", round(tail(ts_h$depletion, 1), 3), "\n")
  }
}

h_ts_df <- bind_rows(h_ts)

# Build label: match steepness figure style from manuscript
# Bold/thicker line for base model (h = 0.84), others thin
# Color ramp from dark blue (low h) to red (high h) via viridis

p_steep <- ggplot(h_ts_df,
                  aes(x     = Yr,
                      y     = depletion,
                      color = factor(h_value),
                      size  = factor(is_base),
                      group = factor(h_value))) +
  geom_line() +
  geom_hline(yintercept = 1.00, linetype = "dashed", color = "grey60", linewidth = 0.5) +
  geom_hline(yintercept = 0.40, linetype = "dashed", color = "red",    linewidth = 0.8) +
  geom_hline(yintercept = 0.25, linetype = "dashed", color = "darkred",linewidth = 0.6) +
  annotate("text", x = 1953, y = 0.42, label = "Management target",
           color = "red",     hjust = 0, size = 3) +
  annotate("text", x = 1953, y = 0.27, label = "Minimum stock size threshold",
           color = "darkred", hjust = 0, size = 3) +
  scale_color_manual(
    values = setNames(
      colorRampPalette(c("navy", "steelblue", "cyan3",
                         "green3", "yellow2", "orange", "red"))(length(h_values)),
      as.character(h_values)
    ),
    name   = "h value",
    labels = setNames(
      ifelse(abs(h_values - 0.84) < 0.001,
             paste0(h_values, " (base)"),
             as.character(h_values)),
      as.character(h_values)
    )
  ) +
  scale_size_manual(values = c("FALSE" = 0.5, "TRUE" = 1.8), guide = "none") +
  labs(
    title    = "Fraction of unfished",
    subtitle = NULL,
    x        = "Year",
    y        = "Fraction of unfished"
  ) +
  theme_bw(base_size = 12) +
  theme(legend.position = "right",
        legend.text      = element_text(size = 8),
        legend.key.height = unit(0.4, "cm"))

ggsave("SR_BH_steep_trajectories_compare3_Bratio.png", p_steep,
       width = 10, height = 6, dpi = 300)

cat("Figure S6.1 saved: SR_BH_steep_trajectories_compare3_Bratio.png\n")
cat("Terminal B/B0 range:",
    round(min(sapply(h_results, "[[", "terminal_dep")), 3), "to",
    round(max(sapply(h_results, "[[", "terminal_dep")), 3), "\n")