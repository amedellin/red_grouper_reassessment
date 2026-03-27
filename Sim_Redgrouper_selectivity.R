#-----------------------------------
# sim of q vs selectivity
#-----------------------------------

# Protogynous Fish Population Simulation with Fishing Effects
# Population starts as female, changes to male at 70 cm

library(ggplot2)
library(dplyr)
library(tidyr)

# ============================================================================
# PARAMETERS
# ============================================================================

# Population parameters
L_inf <- 100.9        # Asymptotic length (cm)
K <- 0.15           # Growth coefficient
t0 <- -0.09          # Theoretical age at length 0
M <- 0.255            # Natural mortality
max_age <- 22       # Maximum age

# Reproduction parameters
L_mat50 <- 50.9     # Length at 50% maturity (cm)
L_mat_min <- 30     # Minimum reproductive length (cm)
mat_slope <- 0.3    # Steepness of maturity curve

# Sex change parameters
L_sex_change <- 70  # Length at sex change (cm)
sex_change_slope <- 1.0  # Steepness of sex change probability

# Length-weight relationship
a_lw <- 0.0000123        # Length-weight coefficient
b_lw <- 3.035         # Length-weight exponent

# Recruitment
R0 <- 1000          # Unfished recruitment
steepness <- 0.84   # Beverton-Holt steepness

# ============================================================================
# SELECTIVITY FUNCTIONS
# ============================================================================

# Logistic selectivity
logistic_selectivity <- function(L, SL50, SL95, By = 1) {
  SelLen <- 1.0 / (1 + exp(-log(19) * (L - (SL50 + 0.5 * By)) / ((SL95 + 0.5 * By) - (SL50 + 0.5 * By))))
  return(SelLen)
}

# Dome-shaped selectivity
dome_selectivity <- function(L, L50_asc, slope_asc, L50_desc, slope_desc) {
  S_asc <- 1 / (1 + exp(-slope_asc * (L - L50_asc)))
  S_desc <- 1 - (1 / (1 + exp(-slope_desc * (L - L50_desc))))
  S_asc * S_desc
}

# ============================================================================
# BIOLOGICAL FUNCTIONS
# ============================================================================

# Von Bertalanffy growth
vb_length <- function(age, L_inf, K, t0) {
  L_inf * (1 - exp(-K * (age - t0)))
}

# Maturity ogive
maturity <- function(L, L50, slope) {
  1 / (1 + exp(-slope * (L - L50)))
}

# Sex change probability (female to male transition)
sex_change_prob <- function(L, L_change, slope) {
  1 / (1 + exp(-slope * (L - L_change)))
}

# Length to weight
length_to_weight <- function(L, a, b) {
  a * L^b
}

# ============================================================================
# POPULATION INITIALIZATION
# ============================================================================

initialize_population <- function() {
  ages <- 1:max_age
  lengths <- vb_length(ages, L_inf, K, t0)
  
  # Initial unfished population structure (exponential decay)
  N0 <- R0 * exp(-M * ages)
  
  # Determine sex based on length
  sex_change_p <- sex_change_prob(lengths, L_sex_change, sex_change_slope)
  prop_male <- sex_change_p
  
  N_female <- N0 * (1 - prop_male)
  N_male <- N0 * prop_male
  
  # Maturity
  mat <- maturity(lengths, L_mat50, mat_slope)
  
  # Weight
  weight <- length_to_weight(lengths, a_lw, b_lw)
  
  data.frame(
    age = ages,
    length = lengths,
    N_female = N_female,
    N_male = N_male,
    maturity = mat,
    weight = weight,
    sex_change_prob = sex_change_p
  )
}

# ============================================================================
# FISHING MORTALITY
# ============================================================================

apply_fishing <- function(pop, effort, catchability, selectivity_type = "logistic",
                          SL50 = 45, SL95 = 55, By = 1,
                          L50_asc = 40, slope_asc = 0.3,
                          L50_desc = 80, slope_desc = 0.3) {
  
  # Calculate selectivity
  if (selectivity_type == "logistic") {
    sel <- logistic_selectivity(pop$length, SL50, SL95, By)
  } else if (selectivity_type == "dome") {
    sel <- dome_selectivity(pop$length, L50_asc, slope_asc, L50_desc, slope_desc)
  } else {
    sel <- rep(1, nrow(pop))  # Flat selectivity
  }
  
  # Fishing mortality
  F_mort <- catchability * effort * sel
  
  # Total mortality
  Z <- M + F_mort
  
  # Apply mortality
  pop$N_female <- pop$N_female * exp(-Z)
  pop$N_male <- pop$N_male * exp(-Z)
  
  # Store fishing info
  pop$selectivity <- sel
  pop$F_mort <- F_mort
  pop$Z <- Z
  
  return(pop)
}

# ============================================================================
# REPRODUCTION AND RECRUITMENT
# ============================================================================

calculate_recruitment <- function(pop, R0, steepness) {
  # Calculate spawning stock biomass (only mature females contribute)
  SSB <- sum(pop$N_female * pop$maturity * pop$weight)
  
  # Unfished SSB (for reference)
  SSB0 <- sum(pop$N_female * pop$maturity * pop$weight) # Simplified
  
  # Beverton-Holt recruitment
  alpha <- (4 * steepness * R0) / (SSB0 * (1 - steepness))
  beta <- (5 * steepness - 1) / (SSB0 * (1 - steepness))
  
  R <- (alpha * SSB) / (1 + beta * SSB)
  
  return(max(R, 1))  # Minimum recruitment of 1
}

# ============================================================================
# SIMULATION FUNCTION
# ============================================================================

simulate_fishery <- function(years = 50, 
                             effort = 0.3, 
                             catchability = 0.5,
                             selectivity_type = "logistic",
                             SL50 = 45, 
                             SL95 = 55,
                             By = 0.1,
                             L50_asc = 40, 
                             slope_asc = 0.3,
                             L50_desc = 80, 
                             slope_desc = 0.3) {
  
  # Initialize
  pop <- initialize_population()
  results <- list()
  
  for (year in 1:years) {
    # Apply fishing mortality
    pop <- apply_fishing(pop, effort, catchability, selectivity_type,
                         SL50, SL95, By, L50_asc, slope_asc, L50_desc, slope_desc)
    
    # Calculate recruitment
    recruits <- calculate_recruitment(pop, R0, steepness)
    
    # Age population (shift ages forward)
    pop_next <- pop
    pop_next$N_female[2:max_age] <- pop$N_female[1:(max_age-1)]
    pop_next$N_male[2:max_age] <- pop$N_male[1:(max_age-1)]
    
    # Add recruits (all start as female)
    pop_next$N_female[1] <- recruits
    pop_next$N_male[1] <- 0
    
    # Apply sex change (females transition to males based on length)
    for (i in 1:nrow(pop_next)) {
      if (pop_next$length[i] >= L_sex_change) {
        transition <- pop_next$N_female[i] * pop_next$sex_change_prob[i] * 0.1
        pop_next$N_female[i] <- pop_next$N_female[i] - transition
        pop_next$N_male[i] <- pop_next$N_male[i] + transition
      }
    }
    
    pop <- pop_next
    
    # Store results
    results[[year]] <- pop %>%
      mutate(year = year,
             total_N = N_female + N_male,
             SSB = sum(N_female * maturity * weight),
             total_biomass = sum((N_female + N_male) * weight),
             catch_female = N_female * (1 - exp(-F_mort)),
             catch_male = N_male * (1 - exp(-F_mort)))
  }
  
  bind_rows(results)
}

# ============================================================================
# RUN SIMULATIONS
# ============================================================================

# Scenario 1: No fishing
no_fishing <- simulate_fishery(years = 70, effort = 0, catchability = 0)

# Scenario 2: Moderate fishing with logistic selectivity
logistic_fishing <- simulate_fishery(years = 70, effort = 0.5, catchability = 0.4,
                                     selectivity_type = "logistic", 
                                     SL50 = 25, SL95 = 55, By = 0.1)

# Scenario 3: Moderate fishing with dome selectivity
dome_fishing <- simulate_fishery(years = 70, effort = 0.5, catchability = 0.4,
                                 selectivity_type = "dome",
                                 L50_asc = 35, slope_asc = 0.3,
                                 L50_desc = 80, slope_desc = 0.3)

# Scenario 4: High fishing with logistic selectivity
high_fishing <- simulate_fishery(years = 70, effort = 1.0, catchability = 0.5,
                                 selectivity_type = "logistic",
                                 SL50 = 25, SL95 = 55, By = 0.1)

# ============================================================================
# VISUALIZATION
# ============================================================================

# Plot 1: Population trajectories
pop_summary <- bind_rows(
  no_fishing %>% group_by(year) %>% 
    summarize(SSB = first(SSB), Biomass = first(total_biomass), 
              N_female = sum(N_female), N_male = sum(N_male)) %>%
    mutate(scenario = "No Fishing"),
  
  logistic_fishing %>% group_by(year) %>% 
    summarize(SSB = first(SSB), Biomass = first(total_biomass),
              N_female = sum(N_female), N_male = sum(N_male)) %>%
    mutate(scenario = "Logistic Selectivity"),
  
  dome_fishing %>% group_by(year) %>% 
    summarize(SSB = first(SSB), Biomass = first(total_biomass),
              N_female = sum(N_female), N_male = sum(N_male)) %>%
    mutate(scenario = "Dome Selectivity"),
  
  high_fishing %>% group_by(year) %>% 
    summarize(SSB = first(SSB), Biomass = first(total_biomass),
              N_female = sum(N_female), N_male = sum(N_male)) %>%
    mutate(scenario = "High Fishing (Logistic)")
)

p1 <- ggplot(pop_summary, aes(x = year, y = SSB, color = scenario)) +
  geom_line(linewidth = 1) +
  labs(title = "Spawning Stock Biomass Over Time",
       x = "Year", y = "SSB (kg)", color = "Scenario") +
  theme_minimal() +
  theme(legend.position = "bottom")

# Plot 2: Sex ratio over time
sex_ratio <- pop_summary %>%
  mutate(sex_ratio = N_male / (N_female + N_male))

p2 <- ggplot(sex_ratio, aes(x = year, y = sex_ratio, color = scenario)) +
  geom_line(linewidth = 1) +
  labs(title = "Proportion of Males Over Time",
       x = "Year", y = "Proportion Male", color = "Scenario") +
  theme_minimal() +
  theme(legend.position = "bottom")

# Plot 3: Selectivity curves
length_seq <- seq(0, 100, by = 1)
sel_data <- data.frame(
  length = rep(length_seq, 2),
  selectivity = c(
    logistic_selectivity(length_seq, SL50 = 45, SL95 = 55, By = 1),
    dome_selectivity(length_seq, 40, 0.3, 80, 0.3)
  ),
  type = rep(c("Logistic", "Dome"), each = length(length_seq))
)

p3 <- ggplot(sel_data, aes(x = length, y = selectivity, color = type)) +
  geom_line(linewidth = 1) +
  geom_vline(xintercept = 70, linetype = "dashed", color = "red") +
  annotate("text", x = 72, y = 0.9, label = "Sex change (70 cm)", 
           hjust = 0, color = "red") +
  labs(title = "Selectivity Curves",
       x = "Length (cm)", y = "Selectivity", color = "Type") +
  theme_minimal()

# Plot 4: Length composition in final year
final_year <- 50
length_comp <- bind_rows(
  logistic_fishing %>% filter(year == final_year) %>%
    mutate(scenario = "Logistic"),
  dome_fishing %>% filter(year == final_year) %>%
    mutate(scenario = "Dome")
) %>%
  pivot_longer(cols = c(N_female, N_male), 
               names_to = "sex", values_to = "abundance")

p4 <- ggplot(length_comp, aes(x = length, y = abundance, fill = sex)) +
  geom_bar(stat = "identity", position = "stack") +
  facet_wrap(~scenario) +
  labs(title = paste("Length Composition by Sex (Year", final_year, ")"),
       x = "Length (cm)", y = "Abundance", fill = "Sex") +
  theme_minimal()

# Display plots

ggarrange(p1,p2,p3,p4,align="hv",ncol=2,nro2=2)


# Summary statistics
cat("\n=== SUMMARY STATISTICS (Final Year) ===\n\n")
for (scenario in c("No Fishing", "Logistic Selectivity", 
                   "Dome Selectivity", "High Fishing (Logistic)")) {
  data <- pop_summary %>% filter(scenario == !!scenario, year == final_year)
  cat(scenario, ":\n")
  cat("  SSB:", round(data$SSB, 2), "kg\n")
  cat("  Total Biomass:", round(data$Biomass, 2), "kg\n")
  cat("  Sex Ratio (M/F+M):", round(data$N_male / (data$N_female + data$N_male), 3), "\n\n")
}