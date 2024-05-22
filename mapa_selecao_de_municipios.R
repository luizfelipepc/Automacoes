library(geobr)
library(tidyverse)
library(sf)

#br <- read_country(2020)
#estados <- read_state(code_state = 'AP')
#municipios <- read_municipality()

#plot(estados)


########################################################
#######              Amazonas                    ######
#######################################################


# Baixe os limites do estado
estado <- read_state(code_state = "AM", year = 2020)

# Baixe os dados dos municípios do estado
municipios <- read_municipality(code_muni = "AM", year = 2020)


# Lista de municípios a serem destacados
municipios_destacados <- c("Amaturá",
                           "Autazes",
                           "Carauari",
                           "Fonte Boa",
                           "Jutaí",
                           "São Gabriel Da Cachoeira",
                           "Tonantins")

# Crie uma coluna para destacar os municípios
municipios <- municipios %>%
  mutate(destaque = ifelse(name_muni %in% municipios_destacados, "Destaque", "Outros"))

ggplot() +
  geom_sf(data = estado, fill = NA, color = "gray40", size = 1) +  # Adiciona o contorno do estado
  geom_sf(data = municipios, aes(fill = destaque), color = "gray40", size = 1) +  # Adiciona os municípios (contorno)
  scale_fill_manual(values = c("Destaque" = "darkgreen", "Outros" = "lightblue"), guide = "none") +  # Cores personalizadas
  theme_minimal() +
  labs(title = "Mapa dos Municípios do Amazonas",
       subtitle = "Municípios Destacados: Amaturá, Autazes, Carauari,\nFonte Boa, Jutaí, São Gabriel da Cachoeira, Tonantins",
       caption = "Fonte: IBGE e geobr") +
  theme(legend.position = "none") +
  theme_void()

ggsave("mapa_municipios_AM.jpg", plot = last_plot(), width = 15, height = 15, units = "in", dpi = 300)
