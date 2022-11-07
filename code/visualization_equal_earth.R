# load packages
list.of.packages <-
  c(
    'rnaturalearth',
    #'rnaturalearthhires',
    'sp',
    'rgdal',
    'ggplot2',
    'dplyr',
    'sf',
    'raster',
    'RColorBrewer'
  )
new.packages <-
  list.of.packages[!(list.of.packages %in% installed.packages()[, 'Package'])]
if (length(new.packages))
  install.packages(new.packages)

# load libraries
library(rnaturalearth); library(sp); library(rgdal); library(ggplot2); library(dplyr); library(sf); library(raster); library(RColorBrewer)

# projection CRS
crs_raw <- '+proj=longlat'
crs_eqearth <- '+proj=eqearth +lon_0=200'

## use naturalearth map, see tutorial: https://pjbartlein.github.io/REarthSysSci/RMaps.html

# load downloaded naturalearth shapefile for bounding box
shape_path <- '/home/donzhu/Scripts/'
bb_lines <- readOGR(paste0(shape_path, 'ne_10m_wgs84_bounding_box/ne_10m_wgs84_bounding_box.shp'))
bb_lines_proj <- spTransform(bb_lines,
                          CRS('+proj=eqearth'))
bb_lines_proj <- as(bb_lines_proj, 'SpatialLinesDataFrame')
plot(bb_lines_proj)


# load naturalearth coastline map
coastline <- ne_coastline(scale = 'medium', returnclass = "sf") %>%
  st_make_valid()
plot(coastline)

# centered at lon 160W (200)
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
plot(polygon)


# modify coastline map to remove overlapping portions with world's polygons
coastline_proj <- coastline %>% st_difference(polygon)
#> Warning: attribute variables are assumed to be spatially constant throughout all geometries
plot(st_geometry(coastline_proj))


# transform coastline to eqearth projection
coastline_proj <- coastline_proj %>% st_transform(crs = crs_eqearth)
ggplot(data = coastline_proj) +
  geom_sf()

# transform sf to SpatialLinesDataFrame
coastline_proj <- as_Spatial(coastline_proj)

# read dcant dataframe from csv file and transform coordinate
dcant <- read.csv(file = '/home/donzhu/Scripts/dcant_column_inventor_example.csv') %>%
  mutate(lon = if_else(lon >= 360, lon - 360, lon))

# transform dataframe to dcant raster
dcant_raster <- rasterFromXYZ(dcant[, c('lon', 'lat', 'dcant')], crs = crs_raw)
plot(dcant_raster)

# extend extent to (0, 360,-90, 90)
dcant_raster <- extend(dcant_raster, extent(0, 360,-90, 90)) #########################
#dcant_raster <- setExtent(dcant_raster, extent(0, 360,-90, 90), keepres=T, snap =T)
plot(dcant_raster)


# load naturalearth coastline map
coastline <- ne_coastline(scale = 'medium', returnclass = "sf") %>%
  st_make_valid()
plot(coastline)

file_raw <- as(rotate(dcant_raster), "SpatialPolygonsDataFrame")
plot(rotate(dcant_raster))
plot(file_raw)


dcant_sf <- st_as_sf(x = file_raw,
                     coords = c("lon", "lat"),
                     crs = crs_raw)
plot(dcant_sf)


dcant_sf <- as(file_raw, 'sf')
plot(dcant_sf)

# centered at lon 160W (200)
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
plot(polygon)

# modify coastline map to remove overlapping portions with world's polygons
dcant_sf_proj <- dcant_sf %>% st_difference(polygon)
#> Warning: attribute variables are assumed to be spatially constant throughout all geometries
plot(dcant_sf_proj)


# transform coastline to eqearth projection
dcant_sf_proj <- dcant_sf_proj %>% st_transform(crs = crs_eqearth)
plot(dcant_sf_proj)


#%>% st_sf %>% st_cast
#
# a <- sf:::as_Spatial(dcant_sf_proj)
# a <- as(st_geometry(dcant_sf_proj), Class="Spatial")
# a <- as.data.frame(dcant_sf_proj)
#
# ggplot(data = coastline_proj) +
#   geom_sf()
#
# # transform sf to SpatialLinesDataFrame
# coastline_proj <- as_Spatial(coastline_proj)
#
#
#
# file_raw <- as(rotate(dcant_raster), "SpatialPolygonsDataFrame")
# file_proj <- spTransform(file_raw, CRS(crs_eqearth))
#
# # prepare SPDF for ggplot
# file_proj@data$id <- rownames(file_proj@data)
# file_proj.points <- fortify(file_proj, region = "id")
# file_proj.df <-
#   left_join(file_proj.points, file_proj@data, by = "id")
#
# #file_proj@data$id <- rownames(file_proj@data)
# file_proj.points <- fortify(file_proj)
# file_proj.df <-
#   cbind(file_proj.points, file_proj@data)
#

# ggplot() +
#   geom_sf(data = coastline_proj) +
#   geom_sf(data = dcant_sf_proj, aes(color = dcant))
#
# dcant_raster_df <- as.data.frame(dcant_raster, xy = T)

ggplot() +
 geom_sf(data = dcant_sf_proj, aes(color = dcant)) +
 # geom_polygon(data = file_proj.df, aes(
 #   long,
 #   lat,
 #   group = group,
 #   fill = dcant)
 # ) +
  # geom_raster(c, aes(x = x, y = y,
  #                    fill = dcant))
  coord_sf() +
  scale_color_stepsn(
    #trans = scales::pseudo_log_trans(sigma = 1),
    colours = colorRampPalette(brewer.pal(11, 'BrBG'))(15),
   # breaks = breaks,
    limits = c(-20, 20),
   n.breaks = 11,
    oob = scales::squish,
    guide = "colourbar"
  ) +
  geom_path(data = coastline_proj,
            aes(
              x = long,
              y = lat,
              group = group
            ),
            size = 0.3) +
  geom_path(data = bb_lines_proj,
            aes(
              x = long,
              y = lat,
              group = group
            ),
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
      #title = bquote(Delta * .(sub("\\-.*", "", files_s[['variable']])) ~ .(u)),
      #title = bquote(Delta * .(substr(files_s[['variable']], 0, 11)) ~ .(u)),
      title = '',
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

