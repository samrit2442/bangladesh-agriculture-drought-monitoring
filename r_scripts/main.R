library(tidyverse)
library(readxl)

drought_data1 <- read_excel("./datasets/Drought Dataset.xlsx",
                            sheet = "PDSI")

drought_data2 <- read_excel("./datasets/Drought Dataset.xlsx",
                            sheet = "SPEI")

drought_data3 <- read_excel("./datasets/Drought Dataset.xlsx",
                            sheet = "Production")

response_var <- as.vector(drought_data3[17, -1]) |> unlist()

predictor_var <- full_join(drought_data1, drought_data2,
                           join_by(Year, Month)) |> 
  group_by(Year) |> 
  summarise(PDSI_new = sum(PDSI),
            `SPEI-3_new` = sum(`SPEI-3`),
            `SPEI-6_new` = sum(`SPEI-6`, na.rm = T),
            `SPEI-12_new` = sum(`SPEI-12`, na.rm = T))

