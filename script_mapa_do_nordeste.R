# Mapa do Nordeste

install.packages("brazilmaps")
install.packages("tidyverse")
devtools::install_github("oswaldosantos/ggsn")

library(brazilmaps)
library(ggsn)

# Encontre a regiao de interesse

nordeste <- get_brmap(geo = "City",
                      geo.filter = list(Region = 2))

# Plote
plot_brmap(nordeste) +
  ggsn::scalebar(nordeste, dist = 100,location = "bottomright", transform = TRUE, #Adicione uma barra de escala
                                    dist_unit = "km", st.dist = 0.03, st.size = 2, model = 'WGS84') +
  ggsn::north(nordeste, scale = .1) #Adicione uma seta com o norte

