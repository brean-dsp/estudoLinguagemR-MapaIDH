library(geobr)
library(ggplot2)
library(readxl)
library(dplyr)
library(RColorBrewer)
library(ggspatial)

muni <- read_municipality(code_muni = 'SP')
sp <- read_state(code_state = "SP")


ggplot(muni)+geom_sf(aes(fill=code_muni))


setwd('C:/Users/Master/Desktop/R/')


dados <- read_excel('atlas2013_dadosbrutos_pt.xlsx', sheet = 2) %>%
         filter(ANO==2010 & UF==35) %>% 
         select(Codmun7, IDHM) %>% 
         rename(code_muni=Codmun7)
    
juntos <- inner_join(muni, dados, by="code_muni")


ggplot(juntos)+
              geom_sf(aes(fill=IDHM, col=IDHM))+
              geom_sf(data = sp, fill='transparent')+
              scale_color_gradientn(colours = brewer.pal(9, 'Spectral'))+
              scale_fill_gradientn(colours = brewer.pal(9, 'Spectral'))+
              theme_minimal()+
              annotation_scale(location='bl')+
              annotation_north_arrow(location='tl', style = north_arrow_nautical(),
                                     width = unit(2.8,'cm'), 
                                     height = unit(2.8, 'cm'))+
              labs(title = "IDH Médio Para o Estado de São Paulo")
  

