
# load packages
list.of.packages <-
  c('rnaturalearth',
    #'rnaturalearthhires', if you want to have higher resolution of land map
    'sp',
    'sf',
    'rgdal',
    'ggplot2',
    'dplyr',
    'raster',
    'RColorBrewer')
new.packages <-
  list.of.packages[!(list.of.packages %in% installed.packages()[, 'Package'])]
if (length(new.packages))
  install.packages(new.packages)

# load libraries
library(rnaturalearth)
library(sp)
library(rgdal)
library(ggplot2)
library(dplyr)
library(sf)
library(raster)
library(RColorBrewer)

# projection CRS
crs_raw <- '+proj=longlat'
################### if want to change the map center, please provide longitude in (0, 360) ######################
crs_eqearth <- '+proj=eqearth +lon_0=200'

## use naturalearth map, see tutorial: https://pjbartlein.github.io/REarthSysSci/RMaps.html

# load downloaded naturalearth shapefile for bounding box
## download bounding box at: https://www.naturalearthdata.com/downloads/10m-physical-vectors/ -> 'Graticules' -> 'Download bounding box'
shape_path <- '/home/donzhu/Scripts/'
bb_lines <- readOGR(paste0(shape_path, 'ne_10m_wgs84_bounding_box/ne_10m_wgs84_bounding_box.shp'))
bb_lines_proj <- spTransform(bb_lines,
                          CRS('+proj=eqearth'))
bb_lines_proj <- as(bb_lines_proj, 'SpatialLinesDataFrame')

# load naturalearth coastline map
coastline <- ne_coastline(scale = 'small', returnclass = "sf") %>%
  st_make_valid()

# centered at lon 160W (200)
################### if want to change the map center, please provide longitude in (0, 360) ######################
offset <- 180 - 200

# define a long & slim polygon that overlaps the meridian line & set its CRS to match that of world
polygon <- st_polygon(x = list(rbind(
  c(-0.0001 - offset, 90),
  c(0 - offset, 90),
  c(0 - offset, -90),
  c(-0.0001 - offset, -90),
  c(-0.0001 - offset, 90)
))) %>%
  st_sfc() %>%
  st_set_crs(4326)

# modify coastline map to remove overlapping portions with world's polygons
coastline_proj <- coastline %>% st_difference(polygon)
#> Warning: attribute variables are assumed to be spatially constant throughout all geometries

# transform coastline to eqearth projection
coastline_proj <- coastline_proj %>% st_transform(crs = crs_eqearth)
ggplot(data = coastline_proj) +
  geom_sf()

# transform sf to SpatialLinesDataFrame for ggplot geom_path
coastline_proj <- as_Spatial(coastline_proj)

# read dcant dataframe from csv file and transform coordinate
dcant <- read.csv(file = '/home/donzhu/Scripts/dcant_column_inventor_example.csv') %>%
  mutate(lon = if_else(lon >= 360, lon - 360, lon))

# transform dataframe to dcant raster
dcant_raster <- rasterFromXYZ(dcant[, c('lon', 'lat', 'dcant')], crs = crs_raw)

# extend extent to (0, 360,-90, 90), otherwise cause failure for later transform
dcant_raster <- extend(dcant_raster, extent(0, 360, -90, 90))
plot(dcant_raster)

# rotate file to (-180, 180,-90, 90) and SPDF for later sf transform
file_raw <- as(rotate(dcant_raster), "SpatialPolygonsDataFrame")

# SPDF to sf
dcant_sf <- as(file_raw, 'sf')

# define a long & slim polygon that overlaps the meridian line & set its CRS to match that of world
polygon <- st_polygon(x = list(rbind(
  c(-0.0001 - offset, 90),
  c(0 - offset, 90),
  c(0 - offset, -90),
  c(-0.0001 - offset, -90),
  c(-0.0001 - offset, 90)
))) %>%
  st_sfc() %>%
  st_set_crs(4326)

# modify coastline map to remove overlapping portions with world's polygons
dcant_sf_proj <- dcant_sf %>% st_difference(polygon)
#> Warning: attribute variables are assumed to be spatially constant throughout all geometries

# transform coastline to eqearth projection
dcant_sf_proj <- dcant_sf_proj %>% st_transform(crs = crs_eqearth)

# final visualization
ggplot() +
  geom_sf(data = dcant_sf_proj, aes(fill = cut(dcant, c(-Inf,seq(0,16,2),Inf))), lwd = 0) +
  coord_sf() +
  scale_fill_viridis_d(
    drop = FALSE)+
  # scale_fill_stepsn(
  #   colours = viridis::viridis(9),
  #   breaks = seq(0,16,2),
  #   oob = scales::squish,
  #   guide = 'colorbar'
  # ) +
  geom_path(data = coastline_proj,
            aes(x = long,
                y = lat,
                group = group),
            size = 0.3) +
  geom_path(data = bb_lines_proj,
            aes(x = long,
                y = lat,
                group = group),
            size = 0.3) +
  theme(
    # bg of the panel
    panel.background = element_rect(fill = 'transparent', color = NA),
    # bg of the plot
    plot.background = element_rect(fill = 'transparent', color = NA),
    panel.grid = element_blank(),
    rect = element_rect(fill = "transparent"),
    plot.title = element_text(
      size = 9,
      hjust = 0.33,
      vjust = -10
    ),
    plot.subtitle = element_text(
      size = 8,
      hjust = 0.71,
      vjust = -4
    ),
    legend.position = 'bottom',
    legend.title.align = 0.5,
    legend.margin = margin(t = -14),
    legend.title = element_text(size = 8),
    legend.text = element_text(size = 8),
    axis.title = element_blank(),
    axis.text = element_blank(),
    axis.ticks = element_blank()
  ) +
  guides(
    fill = guide_colorsteps(
      title = bquote(Delta * .('Cant Column Inventory')),
      #legend.position = "bottom",
      title.position = "bottom",
      title.vjust = 2,
      label.vjust = 1.5,
      frame.linewidth = 0.8,
      show.limits = F,
      # draw border around the legend
      frame.colour = "black",
      barwidth = 10,
      barheight = 0.4
    )
  )

