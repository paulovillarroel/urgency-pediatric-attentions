library(tidyverse)

url <- "https://repositoriodeis.minsal.cl/SistemaAtencionesUrgencia/AtencionesUrgencia2023.zip"
download.file(url, destfile = "raw-data/AtencionesUrgencia2023.zip")
unzip("raw-data/AtencionesUrgencia2023.zip", exdir = "raw-data/")

data <- data.table::fread("raw-data/AtencionesUrgencia2023.csv", encoding = "Latin-1") |>
  janitor::clean_names()

# Upload official health facility data

hospitals_deis <- readxl:::read_xlsx("tables/Establecimientos_Chile_DEIS.xlsx", skip = 1) |> 
  janitor::clean_names()

data_joined <- left_join(data, hospitals_deis, by = c("id_establecimiento" = "codigo_antiguo"))
