#### LIBRARIES ####

library(fredr)
library(tidyverse)

#### SETUP ####
fredr::fredr_set_key("a5a00a1ff22c31dc7e48134171e9cbe2")

fredr::fredr_get_key()

#### TODAY DATE ####
today_date <- Sys.Date()
inicial_date <- as.Date("2000-01-01")

#### INDICATORS ####

#### UNEMPLOYMENT RATE ####
unemployment_rate <- fredr::fredr(series_id = "UNRATE", 
                                  frequency = "m", 
                                  observation_start = inicial_date,
                                  observation_end = today_date)

average_weeks_unemployed <- fredr::fredr(series_id = "UEMPMEAN",
                                           frequency = "m",
                                           observation_start = inicial_date,
                                           observation_end = today_date)

#### Average Weeks Unemployed x Unemployment rate ####

eixo_duplo <- data.frame(
  dates = unemployment_rate$date, 
  average_weeks = average_weeks_unemployed$value,
  unemploy = unemployment_rate$value)

eixo_duplo %>%
  ggplot(aes(x=dates,y=average_weeks,color="average_weeks")) +
  geom_line() +
  geom_line(aes(x=dates,y=unemploy*2,color="unemploy")) +
  scale_y_continuous(sec.axis = sec_axis(~./2))


