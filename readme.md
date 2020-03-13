# manosaladataR <img src="man/figures/polarowl1.png" align="right" height=140/>

Behavioral Economics & Data Science Team (BEST)

[![License:
MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

{manosaladataR} tiene como objetivo principal hacer más sencillo participar en el proyecto [\#Manosaladata](https://github.com/BESTDATASCIENCE/manos-a-la-data). 

## Instalación

Actualmente este paquete es exclusivo de Github por lo que si no tienes instalado el paquete devtools, debes instalarlo primero y luego este paquete.

``` r
install.packages("devtools") #solo en caso no lo tengas instalado
devtools::install_github("BESTDATASCIENCE/manosaladataR") #para instalar este paquete
```

## ¿Cómo usarlo?
Aquí algunos ejemplos de cómo poder usar este paquete!

``` r
library(manosaladataR)
library(stringi)
library(dplyr)
library(ggplot2)
library(RColorBrewer)
data <- tt_load("2020-03-11")
encuesta <- data$encuesta
head(encuesta) # para ver que hemos descargado correctamente
colourCount = length(unique(encuesta$`Tipo de actividad`))
getPalette = colorRampPalette(brewer.pal(9, "Set1"))
ggplot(data=encuesta, aes(x=Genero, y=Edad1,fill=`Tipo de actividad`)) + geom_bar(stat="identity") + scale_fill_manual(name="Actividades",values = colorRampPalette(brewer.pal(12, "Set2"))(colourCount))+
  labs(title = "Promedio de horas a la semana que dedican mujeres y hombres adultos a actividades diarias, 2010", subtitle = "Adultos entre 30 y 49 años",caption = "Fuente: INEI",
       x="Genero", y="Horas a la semana")
```
