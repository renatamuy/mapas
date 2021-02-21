# Mapas no R 
# Update 2020 run in R 3.6.3
# Renata Muylaert

# Para versões novas do R

https://cran.r-project.org/bin/windows/Rtools/index.html

#Instale estes pacotes direto dos GitHubs dos autores

devtools::install_github("slowkow/ggrepel", force = TRUE)
devtools::install_github("oswaldosantos/ggsn", force = TRUE)
devtools::install_github(“rpradosiqueira/brazilmaps”, force = TRUE)

# Carregue os pacotes necessarios
library(ggplot2)
library(ggmap)
library(maps)
library(mapdata)
library(ggrepel)
library(ggsn)

#######################

#Indique a pasta (diretorio) onde estao os arquivos

#Metodo 1: diga que eh a mesma pasta onde esta o script que voce acaba de abrir
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

#Metodo 2: escreva o caminho completo da pasta para onde baixou os arquivos do GitHub
#setwd("CAMINHO PARA A PASTA QUE VOCE BAIXOU NO GITHUB E DESCOMPRIMIU//")

#Cheque o diretório de trabalho
getwd()
#######################

#Importe o arquivo com os pontos do GPS em graus decimais e transforme-o em um objeto de R
pontos = read.delim("pontos.txt",sep=",", na.strings = "na")

#De uma olhada no objeto que acabou de criar para conferir se esta como voce esperava
head(pontos)

#Defina qual sera a area usada como base do mapa
area <-map_data("nz") #Aqui usamos a Nova Zelandia; para Brasil seria area <-map_data("world", region="Brazil", zoom=5) 

#######################

#Plote o mapa usando o ggplot2 como um objeto, ainda sem desenha-lo na tela
g <- ggplot() + geom_polygon(data = area,
                             aes(x=long, y = lat, group = group),
                             fill = "lightgrey", color = "lightgrey") + #Note que voce pode mudar as cores do fundo e da borda
  coord_fixed(1.1) + #Use isto para o mapa ficar proporcional
  geom_point(data = pontos, aes(x = long, y = lat), 
             color = "purple", #Escolha a cor dos pontos
             size = 2, #Tamanho dos pontos
             alpha = 0.6) + #Transparencia: quanto mais proximo de 1, menos transparente
  
  geom_text_repel(data=pontos, aes(x=long, y=lat, label=ponto))+ #Use isto para os rotulos dos pontos nao ficarem sobrepostos
  
  theme_bw() +
  ggtitle("Pontos visitados") + #De nome ao plot, caso seja necessario
  labs(x="Longitude", y = "Latitude") + #De nome aos eixos
  
  theme(text = element_text(size=14), #Ajuste os tamanhos das fontes 
        plot.title = element_text(size=20, hjust=0.5),
        axis.text.x = element_text(size = 10, angle=0, hjust=1),
        axis.text.y = element_text(size = 10, angle=0, vjust=1),
        axis.title.x = element_text(size = 12, angle=0),
        axis.title.y = element_text(size = 12, angle=90))

#Vizualize o mapa 
plot(g)

#######################

#Exporte o mapa como uma figura PNG, incluindo agora um norte e uma escala
png(filename= "mapa_simples.png", #Defina o nome do arquivo
    res= 300,  height= 20, width=16, unit="cm") #Aqui voce define a resolucao e tamanho da imagem

g +
  ggsn::scalebar(area, dist = 100,location = "bottomright", transform = TRUE, #Adicione uma barra de escala
                 dist_unit = "km", st.dist = 0.03, st.size = 2, model = 'WGS84') +
  ggsn::north(area, scale = .1) #Adicione uma seta com o norte

dev.off()

#######################
