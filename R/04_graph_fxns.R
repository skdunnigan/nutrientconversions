# ----01 create a new df for analysis and graphics----
dat3 <- dat2 %>%
  tidyr::separate(station_code, 
                  into = c("station_code", "num"), 
                  sep = "(?<=[A-Za-z])(?=[0-9])") %>%
  tidyr::separate(num,
                  into = c("monitoringprogram", "replicate"),
                  sep = "[.]")

# ----02 figure function all stations----
# run code, then use function.
allstation_plot <- function(param, axis_y_title) {
  
  dat3 %>%
    dplyr::filter(monitoringprogram == 1) %>%
    dplyr::mutate(date = lubridate::date(date_sampled)) %>%
    dplyr::select(station_code, date, cdmo_name, result) %>%
    dplyr::group_by(station_code, date, cdmo_name) %>%
    dplyr::summarise(result2 = mean(result, na.rm = TRUE)) %>%
    dplyr::filter(cdmo_name == param) %>%
    ggplot(aes(x = date, y = result2, color = station_code)) +
    geom_point(size = 3) +
    geom_line(size = 1, linetype = "dashed") +
    scale_x_date(limits = c(as.Date("2019-01-01"), as.Date("2019-12-31")),
      date_breaks = "month", date_labels = "%b") +
    theme_cowplot() +
    labs(y = axis_y_title,
         title = param)
}

# ----03 figure function for thresholds----
chla_threshold_plot <- function(station, threshold_low) {
  
  dat3 %>%
    dplyr::filter(monitoringprogram == 1) %>%
    dplyr::mutate(date = lubridate::date(date_sampled)) %>%
    dplyr::select(station_code, date, cdmo_name, result) %>%
    dplyr::group_by(station_code, date, cdmo_name) %>%
    dplyr::summarise(result2 = mean(result, na.rm = TRUE)) %>%
    dplyr::filter(cdmo_name == 'CHLA_N' & station_code == station) %>%
    ggplot(aes(x = date, y = result2)) +
    geom_point(size = 3) +
    geom_line(size = 1) +
    geom_hline(yintercept = threshold_low, linetype = "dashed", 
               size = 2, color = "lightblue") +
    geom_hline(yintercept = 20, linetype = "dashed", 
               size = 2, color = "orange") +
    theme_cowplot() +
    labs(y = chla_y_title,
         title = station,  
         subtitle = paste('low threshold =', threshold_low))
}
  

