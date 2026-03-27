#----------------------------------------------------------------------------
# Recruitment deviation vs Environmental Index model to account for 
# poor recruitment deviation estimation in SS
#----------------------------------------------------------------------------

# ==============================================================================
# RED GROUPER RECRUITMENT DEVIATIONS: MULTIVARIATE ENVIRONMENTAL ANALYSIS
# ==============================================================================

# Install required packages if you don't have them
# install.packages(c("tidyverse", "stringr"))

library(tidyverse)
library(stringr)

# ------------------------------------------------------------------------------
# 1. PROCESS RECRUITMENT DEVIATIONS
# ------------------------------------------------------------------------------
cat("Processing Recruitment...\n")
rec_data <- read.csv("Rec_devs.csv", header = FALSE)

rec_clean <- rec_data %>%
  # Filter only rows containing "RecrDev"
  filter(grepl("RecrDev", V2)) %>%
  # Extract the 4-digit year from the string
  mutate(Year = as.numeric(str_extract(V2, "\\d{4}")),
         Dev = as.numeric(V3)) %>%
  dplyr::select(Year, Dev) %>%
  drop_na()

# ------------------------------------------------------------------------------
# 2. PROCESS COPERNICUS CURRENTS (Spawning Season Lag)
# ------------------------------------------------------------------------------
cat("Processing Ocean Currents...\n")
currents_df <- read.csv("copernicus_currents_monthly.csv")

season_currents <- currents_df %>%
  # Biological lag: If month is Sept-Dec, it affects the following year's recruitment class
  mutate(Rec_Year = ifelse(Month >= 9, Year + 1, Year)) %>%
  # Filter for the Spawning Season (Sept through March)
  filter(Month %in% c(9, 10, 11, 12, 1, 2, 3)) %>%
  group_by(Rec_Year) %>%
  summarize(Current_Speed = mean(Current_Speed_ms, na.rm = TRUE), .groups = "drop")

# ------------------------------------------------------------------------------
# 3. PROCESS SEA SURFACE TEMPERATURE (Spawning Season Lag)
# ------------------------------------------------------------------------------
cat("Processing Sea Surface Temperature...\n")
# check.names = FALSE prevents R from turning "-94" into "X.94"
sst_df <- read.csv("sstyuc.csv", check.names = FALSE) 

# Map month abbreviations to numbers
month_map <- c("Jan"=1, "Feb"=2, "Mar"=3, "Apr"=4, "May"=5, "Jun"=6,
               "Jul"=7, "Aug"=8, "Sep"=9, "Oct"=10, "Nov"=11, "Dec"=12)

season_sst <- sst_df %>%
  # Melt the longitude columns into a single column
  pivot_longer(cols = -c(month, year, Lat), names_to = "Lon", values_to = "SST") %>%
  mutate(SST = as.numeric(SST)) %>%
  # Remove null/missing values (-999)
  filter(SST != -999) %>%
  mutate(Month_Num = month_map[month],
         # Biological lag
         Rec_Year = ifelse(Month_Num >= 9, year + 1, year)) %>%
  # Filter for Spawning Season
  filter(Month_Num %in% c(9, 10, 11, 12, 1, 2, 3)) %>%
  group_by(Rec_Year) %>%
  summarize(SST_avg = mean(SST, na.rm = TRUE), .groups = "drop")

# ------------------------------------------------------------------------------
# 4. LOAD NAO AND RAIN ANOMALY
# ------------------------------------------------------------------------------
cat("Processing Climate Indices...\n")
nao_rain <- read.csv("NAO_rain.csv")

# ------------------------------------------------------------------------------
# 5. MERGE AND NORMALIZE DATA
# ------------------------------------------------------------------------------
cat("Merging datasets...\n")
model_data <- rec_clean %>%
  inner_join(season_currents, by = c("Year" = "Rec_Year")) %>%
  inner_join(nao_rain, by = c("Year" = "year")) %>%
  inner_join(season_sst, by = c("Year" = "Rec_Year")) %>%
  # Drop any years that don't have overlapping data for all variables
  drop_na(Dev, Current_Speed, NAO_index, rain_anomaly, SST_avg)

# Scale variables (Z-score normalization) so their coefficients are comparable
model_data <- model_data %>%
  mutate(
    Current_norm = scale(Current_Speed)[,1],
    NAO_norm     = scale(NAO_index)[,1],
    Rain_norm    = scale(rain_anomaly)[,1],
    SST_norm     = scale(SST_avg)[,1]
  )

cat(sprintf("\nDataset successfully built! Years overlapping: %d to %d (N = %d)\n", 
            min(model_data$Year), max(model_data$Year), nrow(model_data)))

# ------------------------------------------------------------------------------
# 6. STATISTICAL MODELING: MULTIVARIATE & STEP-WISE SELECTION
# ------------------------------------------------------------------------------
cat("\n========================================================\n")
cat("          FULL MULTIVARIATE MODEL (ALL VARIABLES)          \n")
cat("========================================================\n")
# Test all variables together
full_model <- lm(Dev ~ Current_norm + NAO_norm + Rain_norm + SST_norm, data = model_data)
print(summary(full_model))

cat("\n========================================================\n")
cat("      OPTIMIZED MODEL (STEP-WISE AIC SELECTION)            \n")
cat("========================================================\n")
# The step() function iteratively adds/removes variables to find the lowest AIC
best_model <- step(full_model, direction = "both", trace = 0)
print(summary(best_model))

# Extract AIC for the final best model
cat(sprintf("\nAIC of the Best Model: %.2f\n", AIC(best_model)))

# ==============================================================================
# 7. GENERATE PUBLICATION-QUALITY FIGURE (UPDATED)
# ==============================================================================
library(ggplot2)

# 1. Extract the predicted values from our optimized model
model_data$Predicted_Dev <- predict(best_model)

# 2. Safely extract the statistics for the plot annotation
r_squared <- summary(best_model)$r.squared
f_stat <- summary(best_model)$fstatistic
aic_val <- AIC(best_model)

# Safety check: If the model dropped all variables, f_stat is NULL
if (is.null(f_stat)) {
  p_val <- NA
  stat_label <- sprintf("R-squared: %.3f\nModel p-value: NA\nAIC: %.1f\n(No variables selected)", 
                        r_squared, aic_val)
} else {
  p_val <- pf(f_stat[1], f_stat[2], f_stat[3], lower.tail = FALSE)
  stat_label <- sprintf("R-squared: %.3f\nModel p-value: %.3f\nAIC: %.1f", 
                        r_squared, p_val, aic_val)
}

# 3. Build the plot
final_plot <- ggplot(data = model_data, aes(x = Predicted_Dev, y = Dev)) +
  geom_point(size = 4, alpha = 0.7, color = "#2C3E50") +
  # Add the model's linear trendline
  geom_smooth(method = "lm", color = "#E74C3C", se = FALSE, linewidth = 1.2) +
  # Add the 1:1 perfect fit dashed line
  geom_abline(intercept = 0, slope = 1, linetype = "dashed", color = "black", linewidth = 1) +
  
  labs(
    title = "Optimized Multivariate Model (Extended ~30 Year Dataset)",
    subtitle = "Actual vs. Predicted Log Recruitment Deviations",
    x = "Predicted Log Recruitment Deviation",
    y = "Actual Log Recruitment Deviation"
  ) +
  
  annotate("label", 
           x = min(model_data$Predicted_Dev), 
           y = max(model_data$Dev), 
           label = stat_label, 
           hjust = 0, vjust = 1, 
           fill = "white", alpha = 0.9, fontface = "bold") +
  
  theme_bw() +
  theme(
    plot.title = element_text(face = "bold", size = 14),
    axis.title = element_text(face = "bold", size = 12),
    axis.text = element_text(size = 11)
  )

# Display and save
print(final_plot)
ggsave("multivariate_extended_results.png", plot = final_plot, width = 8, height = 6, dpi = 300)
cat("\nPlot successfully generated and saved!\n")


