library(ggmap)
library(tidyverse)
library(osmdata)
library(sf)


load(file="generated_data/bATM.Rdata")


#range(sATM$atm_lat)
#range(sATM$atm_lon)

# Specifikations ----------------------------------------------------------

coord <- as.matrix(data.frame(min = c(8, 55), 
                              max = c(13, 58), 
                              row.names = c("x","y")))

s <- bATM %>% filter(atm_lat > coord[2,1] & atm_lat < coord[2,2] & 
                     atm_lon < coord[1,2] & atm_lon > coord[1,1]) %>% 
  group_by(atm_id) %>% 
  summarize(n   = n(),
            lat = first(atm_lat),
            lon = first(atm_lon),
            man = first(atm_manufacturer))





# First map ---------------------------------------------------------------

map8  <- get_stamenmap(coord, zoom = 8,  maptype = "toner-lite", force = TRUE)
map9  <- get_stamenmap(coord, zoom = 9,  maptype = "toner-lite", force = TRUE)
map10 <- get_stamenmap(coord, zoom = 10, maptype = "toner-lite", force = TRUE)
map11 <- get_stamenmap(coord, zoom = 11, maptype = "toner-lite", force = TRUE)




ggmap(map9) +
  geom_point(data = s, aes(lon,lat, size=n), alpha = 0.8) + 
  scale_size_continuous(limits=c(1,6000)) + 
  labs(title="SparNord number of ATM transactions in 2017", 
       subtitle = "size equals number of transactions")



ggmap(map9) +
  stat_density_2d(data = s, aes(lon,lat, fill = stat(level)), geom = "polygon", alpha = .3) +
  geom_point(data = s, aes(lon,lat), alpha = 0.4, color = "black") + 
  scale_fill_viridis_c(option = "magma") +
  labs(title="SparNord number of ATM transactions in 2017", subtitle = "260.000 casesfrom 2011 - 2018")


























s <- bATM %>% filter(atm_lat > coord[2,1] & atm_lat < coord[2,2] & 
                       atm_lon < coord[1,2] & atm_lon > coord[1,1]) %>% 
  group_by(atm_id, month) %>% 
  summarize(n   = n(),
            lat = first(atm_lat),
            lon = first(atm_lon),
            man = first(atm_manufacturer))



ggmap(map9) +
  stat_density_2d(data = s, aes(lon,lat, fill = stat(level)), geom = "polygon", alpha = .3) +
  geom_point(data = s, aes(lon,lat), alpha = 0.4, color = "black") + 
  scale_fill_viridis_c(option = "magma") +
  labs(title="SparNord number of ATM transactions in 2017", subtitle = "") + 
  facet_wrap(~month)







ggmap(map9) +
  stat_density_2d(data = bATM, aes(atm_lon, atm_lat), geom = "polygon", alpha = .3) +
  geom_point(data = s, aes(lon,lat), alpha = 0.4, color = "black") + 
  scale_fill_viridis_c(option = "magma") +
  labs(title="SparNord number of ATM transactions in 2017", subtitle = "") + 
  facet_wrap(~currency)









