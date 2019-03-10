########################
# Carregue os pacotes
devtools::install_github("slowkow/ggrepel")
devtools::install_github("oswaldosantos/ggsn")
library(ggplot2)
library(ggmap)
library(ggsn)
library(maps)
library(mapdata)
library(ggrepel)
#######################

setwd("CAMINHO PARA A PASTA QUE VOCÊ BAIXOU NO GITHUB E DESCOMPRIMIU//")
pontos = read.delim("pontos.txt",sep=",", na.strings = "na")

area <-map_data("nz") # Brasil seria Brazil
pontosf <- fortify(na.omit(pontos), region = "pontos")

g <- ggplot() + geom_polygon(data = area,
                             aes(x=long, y = lat, group = group),
                             fill = "lightgrey", color = "lightgrey") +
  coord_fixed(1.1) +
  geom_polygon(data = area, 
               aes(x = long, y = lat, group = group), 
               color = "white", fill = NA, size = 0.04) +
  geom_point(data = pontos, aes(x = long, y = lat), 
             color = "purple", 
             size = 2,
             alpha = 0.6) + #transparência quanto mais próximo de 1, menos transparente
  geom_text_repel(data=pontos, aes(x=long, y=lat, label=ponto))+
  theme_bw() +
  ggtitle("Pontos visitados") +
  labs(x="Longitude", y = "Latitude") +
  theme(text = element_text(size=14),
        plot.title = element_text(size=20, hjust=0.5),
        axis.text.x = element_text(size = 10, angle=0, hjust=1),
        axis.text.y = element_text(size = 10, angle=0, vjust=1),
        axis.title.x = element_text(size = 12, angle=0),
        axis.title.y = element_text(size = 12, angle=90))
#Visualizando a figura
plot(g)
#Exportando a figura
png(filename= "mapa_simples.png", res= 300,  height= 20, width=16, unit="cm")
g +
  ggsn::scalebar(area, dist = 100,location = "bottomright", transform = TRUE,
                 dist_unit = "km", st.dist = 0.03, st.size = 2, model = 'WGS84') +
  ggsn::north(area, scale = .1) 
dev.off()

