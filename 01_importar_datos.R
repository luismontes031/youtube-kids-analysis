library(httr)
library(jsonlite)


file.exists("01_importar_youtube.R")


file.edit("~/.Renviron")

Sys.getenv("YOUTUBE_API_KEY")


# Leer la clave guardada en .Renviron
api_key <- Sys.getenv("YOUTUBE_API_KEY")

# ID de Baby Shark Dance
video_id <- "XqZsoesa55w"

# Consulta a YouTube
respuesta <- GET(
  "https://www.googleapis.com/youtube/v3/videos",
  query = list(
    part = "snippet,statistics,contentDetails",
    id = video_id,
    key = api_key
  )
)

# Ver si la solicitud funcionó
status_code(respuesta)

# Convertir la respuesta de YouTube a datos de R
datos <- fromJSON(
  content(respuesta, "text", encoding = "UTF-8")
)

datos$items$snippet$title

datos$items$snippet$channelTitle

datos$items$snippet$publishedAt
datos$items$statistics$viewCount
datos$items$contentDetails$duration

fecha_publicacion <- as.POSIXct(
  datos$items$snippet$publishedAt,
  format = "%Y-%m-%dT%H:%M:%SZ",
  tz = "UTC"
)

vistas <- as.numeric(datos$items$statistics$viewCount)

duracion_seg <- 2 * 60 + 17

fecha_recoleccion <- Sys.Date()

dias_publicado <- as.numeric(
  fecha_recoleccion - as.Date(fecha_publicacion)
)

vistas_dia <- vistas / dias_publicado

fila_v001 <- data.frame(
  id_video = "V001",
  titulo = datos$items$snippet$title,
  canal = datos$items$snippet$channelTitle,
  url = paste0("https://www.youtube.com/watch?v=", video_id),
  fecha_publicacion = as.Date(fecha_publicacion),
  fecha_recoleccion = fecha_recoleccion,
  vistas = vistas,
  duracion_seg = duracion_seg,
  dias_publicado = dias_publicado,
  vistas_dia = vistas_dia
)

fila_v001$objetivo_video <- NA
fila_v001$forma_contenido <- NA
fila_v001$funcion_musica <- NA
fila_v001$respuesta_al_ritmo <- NA
fila_v001$repeticion <- NA
fila_v001$tipo_protagonistas <- NA
fila_v001$grupo_edad_protagonista <- NA
fila_v001$complejidad_lenguaje <- NA
fila_v001$tipo_voces <- NA
fila_v001$texto_en_pantalla <- NA

names(fila_v001)

videos <- rbind(videos, fila_v001)

videos_piloto <- fila_v001

View(videos_piloto)

videos_piloto$objetivo_video[1] <- 1
videos_piloto$forma_contenido[1] <- 1
videos_piloto$funcion_musica[1] <- 2
videos_piloto$respuesta_al_ritmo[1] <- 3
videos_piloto$repeticion[1] <- 3

videos_piloto$tipo_protagonistas[1] <- 3
videos_piloto$grupo_edad_protagonista[1] <- 2

videos_piloto$complejidad_lenguaje[1] <- 2
videos_piloto$tipo_voces[1] <- 5
videos_piloto$texto_en_pantalla[1] <- 2

View(videos_piloto)

videos_piloto$complejidad_lenguaje[1] <- 2
videos_piloto$tipo_voces[1] <- 5
videos_piloto$texto_en_pantalla[1] <- 2

dir.create("data/processed", showWarnings = FALSE)

write.csv(
  videos_piloto,
  "data/processed/videos_piloto.csv",
  row.names = FALSE,
  fileEncoding = "UTF-8"
)

file.exists("data/processed/videos_piloto.csv")

video_id <- "e_04ZrNroTo"

library(GET)

respuesta <- GET(
  "https://www.googleapis.com/youtube/v3/videos",
  query = list(
    part = "snippet,statistics,contentDetails",
    id = video_id,
    key = api_key
  )
)

datos <- fromJSON(
  content(respuesta, "text", encoding = "UTF-8")
)

respuesta <- GET(
  "https://www.googleapis.com/youtube/v3/videos",
  query = list(
    part = "snippet,statistics,contentDetails",
    id = video_id,
    key = api_key
  )
)

datos$items$snippet$title
datos$items$snippet$channelTitle
datos$items$snippet$publishedAt
datos$items$statistics$viewCount
datos$items$contentDetails$duration

fecha_publicacion <- as.POSIXct(
  datos$items$snippet$publishedAt,
  format = "%Y-%m-%dT%H:%M:%SZ",
  tz = "UTC"
)

vistas <- as.numeric(datos$items$statistics$viewCount)

duracion_seg <- 229

fecha_recoleccion <- Sys.Date()

dias_publicado <- as.numeric(
  fecha_recoleccion - as.Date(fecha_publicacion)
)

vistas_dia <- vistas / dias_publicado

fila_v002 <- data.frame(
  id_video = "V002",
  titulo = datos$items$snippet$title,
  canal = datos$items$snippet$channelTitle,
  url = paste0("https://www.youtube.com/watch?v=", video_id),
  fecha_publicacion = as.Date(fecha_publicacion),
  fecha_recoleccion = fecha_recoleccion,
  vistas = vistas,
  duracion_seg = duracion_seg,
  dias_publicado = dias_publicado,
  vistas_dia = vistas_dia,
  objetivo_video = NA,
  forma_contenido = NA,
  funcion_musica = NA,
  respuesta_al_ritmo = NA,
  repeticion = NA,
  tipo_protagonistas = NA,
  grupo_edad_protagonista = NA,
  complejidad_lenguaje = NA,
  tipo_voces = NA,
  texto_en_pantalla = NA
)

View(fila_v002)

fila_v002$objetivo_video <- 5
fila_v002$forma_contenido <- 1
fila_v002$funcion_musica <- 2
fila_v002$respuesta_al_ritmo <- 3
fila_v002$repeticion <- 2
fila_v002$tipo_protagonistas <- 9
fila_v002$grupo_edad_protagonista <- 6
fila_v002$complejidad_lenguaje <- 2
fila_v002$tipo_voces <- 3
fila_v002$texto_en_pantalla <- 2

videos_piloto <- rbind(
  videos_piloto,
  fila_v002
)

View(videos_piloto)

write.csv(
  videos_piloto,
  "data/processed/videos_piloto.csv",
  row.names = FALSE,
  fileEncoding = "UTF-8"
)

nrow(videos_piloto)

videos_piloto[, c(
  "id_video",
  "titulo",
  "vistas",
  "duracion_seg",
  "objetivo_video",
  "repeticion"
)]

# --------------------------------------------------
# FUNCIÓN PARA CONVERTIR DURACIÓN A SEGUNDOS
# --------------------------------------------------

convertir_duracion <- function(duracion) {
  
  minutos <- as.numeric(
    sub(".*?([0-9]+)M.*", "\\1", duracion)
  )
  
  segundos <- as.numeric(
    sub(".*?([0-9]+)S$", "\\1", duracion)
  )
  
  duracion_seg <- (minutos * 60) + segundos
  
  return(duracion_seg)
}

convertir_duracion("PT2M17S")
convertir_duracion("PT3M49S")

# --------------------------------------------------
# FUNCIÓN PARA OBTENER DATOS DE UN VIDEO DE YOUTUBE
# --------------------------------------------------

obtener_video_youtube <- function(video_id, id_interno) {
  
  # 1. Consultar la API de YouTube
  respuesta <- GET(
    "https://www.googleapis.com/youtube/v3/videos",
    query = list(
      part = "snippet,statistics,contentDetails",
      id = video_id,
      key = api_key
    )
  )
  
  # 2. Convertir la respuesta JSON a un objeto de R
  datos <- fromJSON(
    content(respuesta, "text", encoding = "UTF-8")
  )
  
  # 3. Extraer y transformar los datos
  fecha_publicacion <- as.POSIXct(
    datos$items$snippet$publishedAt,
    format = "%Y-%m-%dT%H:%M:%SZ",
    tz = "UTC"
  )
  
  vistas <- as.numeric(
    datos$items$statistics$viewCount
  )
  
  duracion_seg <- convertir_duracion(
    datos$items$contentDetails$duration
  )
  
  fecha_recoleccion <- Sys.Date()
  
  dias_publicado <- as.numeric(
    fecha_recoleccion - as.Date(fecha_publicacion)
  )
  
  vistas_dia <- vistas / dias_publicado
  
  # 4. Construir la fila
  fila <- data.frame(
    id_video = id_interno,
    titulo = datos$items$snippet$title,
    canal = datos$items$snippet$channelTitle,
    url = paste0(
      "https://www.youtube.com/watch?v=",
      video_id
    ),
    fecha_publicacion = as.Date(fecha_publicacion),
    fecha_recoleccion = fecha_recoleccion,
    vistas = vistas,
    duracion_seg = duracion_seg,
    dias_publicado = dias_publicado,
    vistas_dia = vistas_dia
  )
  
  # 5. Devolver el resultado
  return(fila)
}

prueba <- obtener_video_youtube(
  video_id = "e_04ZrNroTo",
  id_interno = "V002"
)

View(prueba)

exists("obtener_video_youtube")

videos_piloto <- read.csv(
  "data/processed/videos_piloto.csv",
  fileEncoding = "UTF-8"
)
nrow(videos_piloto)

fila_v003 <- obtener_video_youtube(
  video_id = "WRVsOCh907o",
  id_interno = "V003"
)

fila_v003[, c(
  "id_video",
  "titulo",
  "canal",
  "fecha_publicacion",
  "vistas",
  "duracion_seg",
  "dias_publicado",
  "vistas_dia"
)]

videos_piloto[, c("id_video", "titulo")]

videos_piloto$idioma_audio <- NA
videos_piloto$idioma_texto <- NA

ncol(videos_piloto)

videos_piloto$idioma_audio[1] <- 2
videos_piloto$idioma_texto[1] <- 2

videos_piloto$idioma_audio[2] <- 1
videos_piloto$idioma_texto[2] <- 2

fila_v003$idioma_audio <- 1
fila_v003$idioma_texto <- 2

fila_v003[, c(
  "id_video",
  "idioma_audio",
  "idioma_texto"
)]

videos_piloto[, c(
  "id_video",
  "idioma_audio",
  "idioma_texto"
)]

videos_piloto <- rbind(
  videos_piloto,
  fila_v003
)

ncol(videos_piloto)
ncol(fila_v003)

names(videos_piloto)
names(fila_v003)

ncol(fila_v003)

fila_v003$objetivo_video <- 3
fila_v003$forma_contenido <- 1
fila_v003$funcion_musica <- 2
fila_v003$respuesta_al_ritmo <- 2
fila_v003$repeticion <- 3
fila_v003$tipo_protagonistas <- 2
fila_v003$grupo_edad_protagonista <- 1
fila_v003$complejidad_lenguaje <- 2
fila_v003$tipo_voces <- 2
fila_v003$texto_en_pantalla <- 2

ncol(fila_v003)

videos_piloto <- rbind(
  videos_piloto,
  fila_v003
)

nrow(videos_piloto)

videos_piloto$id_video

write.csv(
  videos_piloto,
  "data/processed/videos_piloto.csv",
  row.names = FALSE,
  fileEncoding = "UTF-8"
)

file.exists("data/processed/videos_piloto.csv")

fila_v004 <- obtener_video_youtube(
  video_id = "F4tHL8reNCs",
  id_interno = "V004"
)

fila_v004[, c(
  "id_video",
  "titulo",
  "canal",
  "fecha_publicacion",
  "vistas",
  "duracion_seg",
  "dias_publicado",
  "vistas_dia"
)]

fila_v004$objetivo_video <- 4
fila_v004$forma_contenido <- 2
fila_v004$funcion_musica <- 1
fila_v004$respuesta_al_ritmo <- 1
fila_v004$repeticion <- 3
fila_v004$tipo_protagonistas <- 7
fila_v004$grupo_edad_protagonista <- 1
fila_v004$complejidad_lenguaje <- 2
fila_v004$tipo_voces <- 3
fila_v004$texto_en_pantalla <- 2
fila_v004$idioma_audio <- 2
fila_v004$idioma_texto <- 2

ncol(fila_v004)fila_v004 <- fila_v004[, names(videos_piloto)]
identical(names(videos_piloto), names(fila_v004))

videos_piloto <- rbind(
  videos_piloto,
  fila_v004
)

nrow(videos_piloto)
videos_piloto$id_video

write.csv(
  videos_piloto,
  "data/processed/videos_piloto.csv",
  row.names = FALSE,
  fileEncoding = "UTF-8"
)

fila_v005 <- obtener_video_youtube(
  video_id = "2n4enj6YMnw",
  id_interno = "V005"
)

fila_v005[, c(
  "id_video",
  "titulo",
  "canal",
  "fecha_publicacion",
  "vistas",
  "duracion_seg",
  "dias_publicado",
  "vistas_dia"
)]

fila_v005 <- obtener_video_youtube(
  video_id = "hq3yfQnllfQ",
  id_interno = "V005"
)

fila_v005[, c(
  "id_video",
  "titulo",
  "canal",
  "fecha_publicacion",
  "vistas",
  "duracion_seg",
  "dias_publicado",
  "vistas_dia"
)]

fila_v005$objetivo_video <- 2
fila_v005$forma_contenido <- 1
fila_v005$funcion_musica <- 2
fila_v005$respuesta_al_ritmo <- 1
fila_v005$repeticion <- 3
fila_v005$tipo_protagonistas <- 9
fila_v005$grupo_edad_protagonista <- 0
fila_v005$complejidad_lenguaje <- 2
fila_v005$tipo_voces <- 1
fila_v005$texto_en_pantalla <- 2
fila_v005$idioma_audio <- 2
fila_v005$idioma_texto <- 2

ncol(fila_v005)

fila_v005 <- fila_v005[, names(videos_piloto)]
identical(names(videos_piloto), names(fila_v005))

videos_piloto <- rbind(
  videos_piloto,
  fila_v005
  
  nrow(videos_piloto)
  videos_piloto$id_video
)

fila_v005 <- fila_v005[, names(videos_piloto)]

fila_v005 <- fila_v005[, names(videos_piloto)]

identical(names(videos_piloto), names(fila_v005))

videos_piloto <- rbind(videos_piloto, fila_v005)

nrow(videos_piloto)

write.csv(
  videos_piloto,
  "data/processed/videos_piloto.csv",
  row.names = FALSE,
  fileEncoding = "UTF-8"
)

write.csv(
  videos_piloto,
  "data/processed/videos_piloto.csv",
  row.names = FALSE,
  fileEncoding = "UTF-8"
)

file.exists("data/processed/videos_piloto.csv")

videos_piloto$id_video

#empezamos proyecto de los siguientes 5 videos,aqui realizamos un pequeño cambio
#ya que los videos pueden durar horas o segunso y la estructua antes era para minutos

convertir_duracion <- function(duracion) {
  
  horas <- if (grepl("[0-9]+H", duracion)) {
    as.numeric(sub(".*?([0-9]+)H.*", "\\1", duracion))
  } else {
    0
  }
  
  minutos <- if (grepl("[0-9]+M", duracion)) {
    as.numeric(sub(".*?([0-9]+)M.*", "\\1", duracion))
  } else {
    0
  }
  
  segundos <- if (grepl("[0-9]+S", duracion)) {
    as.numeric(sub(".*?([0-9]+)S.*", "\\1", duracion))
  } else {
    0
  }
  
  horas * 3600 + minutos * 60 + segundos
}

#funcion actualizada para peticion youtube

obtener_video_youtube <- function(video_id, id_interno) {
  
  respuesta <- httr::GET(
    "https://www.googleapis.com/youtube/v3/videos",
    query = list(
      part = "snippet,statistics,contentDetails",
      id = video_id,
      key = api_key
    )
  )
  
  httr::stop_for_status(respuesta)
  
  datos <- jsonlite::fromJSON(
    httr::content(respuesta, "text", encoding = "UTF-8")
  )
  
  if (is.null(datos$items) || length(datos$items) == 0) {
    stop("YouTube no devolvió información para ese video.")
  }
  
  fecha_publicacion <- as.POSIXct(
    datos$items$snippet$publishedAt[1],
    format = "%Y-%m-%dT%H:%M:%SZ",
    tz = "UTC"
  )
  
  vistas <- as.numeric(
    datos$items$statistics$viewCount[1]
  )
  
  duracion_seg <- convertir_duracion(
    datos$items$contentDetails$duration[1]
  )
  
  fecha_recoleccion <- Sys.Date()
  
  dias_publicado <- as.numeric(
    fecha_recoleccion - as.Date(fecha_publicacion)
  )
  
  vistas_dia <- vistas / dias_publicado
  
  fila <- data.frame(
    id_video = id_interno,
    titulo = datos$items$snippet$title[1],
    canal = datos$items$snippet$channelTitle[1],
    url = paste0(
      "https://www.youtube.com/watch?v=",
      video_id
    ),
    fecha_publicacion = as.Date(fecha_publicacion),
    fecha_recoleccion = fecha_recoleccion,
    vistas = vistas,
    duracion_seg = duracion_seg,
    dias_publicado = dias_publicado,
    vistas_dia = vistas_dia,
    stringsAsFactors = FALSE
  )
  
  return(fila)
}


#comproabamos que quedo lista


fila_v006 <- obtener_video_youtube(
  video_id = "AQUI_VAMOS_A_PONER_EL_ID",
  id_interno = "V006"
)

fila_v006 <- obtener_video_youtube(
  video_id = "amTmnnqQf_E",
  id_interno = "V006"
)

fila_v006[, c(
  "id_video",
  "titulo",
  "canal",
  "fecha_publicacion",
  "vistas",
  "duracion_seg",
  "dias_publicado",
  "vistas_dia"
)]

ncol(fila_v006)
ncol(videos_piloto)

fila_v006 <- fila_v006[, names(videos_piloto)]

identical(
  names(videos_piloto),
  names(fila_v006)
)

fila_v006$objetivo_video <- 2
fila_v006$forma_contenido <- 5
fila_v006$funcion_musica <- 1
fila_v006$respuesta_al_ritmo <- 0
fila_v006$repeticion <- 1
fila_v006$tipo_protagonistas <- 2
fila_v006$grupo_edad_protagonista <- 1
fila_v006$complejidad_lenguaje <- 1
fila_v006$tipo_voces <- 1
fila_v006$texto_en_pantalla <- 0
fila_v006$idioma_audio <- 2
fila_v006$idioma_texto <- 0

videos_piloto <- rbind(
  videos_piloto,
  fila_v006
)

nrow(videos_piloto)
videos_piloto$id_video

write.csv(
  videos_piloto,
  "data/processed/videos_piloto.csv",
  row.names = FALSE,
  fileEncoding = "UTF-8"
)

fila_v007 <- obtener_video_youtube(
  video_id = "OO53j1uN2oE",
  id_interno = "V007"
)

fila_v007[, c(
  "id_video",
  "titulo",
  "canal",
  "fecha_publicacion",
  "vistas",
  "duracion_seg",
  "dias_publicado",
  "vistas_dia"
)]

fila_v007$objetivo_video <- 1
fila_v007$forma_contenido <- 1
fila_v007$funcion_musica <- 2
fila_v007$respuesta_al_ritmo <- 3
fila_v007$repeticion <- 3
fila_v007$tipo_protagonistas <- 9
fila_v007$grupo_edad_protagonista <- 4
fila_v007$complejidad_lenguaje <- 2
fila_v007$tipo_voces <- 4
fila_v007$texto_en_pantalla <- 0
fila_v007$idioma_audio <- 2
fila_v007$idioma_texto <- 0

fila_v007 <- fila_v007[, names(videos_piloto)]

videos_piloto <- rbind(
  videos_piloto,
  fila_v007
)

write.csv(
  videos_piloto,
  "data/processed/videos_piloto.csv",
  row.names = FALSE,
  fileEncoding = "UTF-8"
)

nrow(videos_piloto)

fila_v007 <- fila_v007[, names(videos_piloto)]

videos_piloto <- rbind(
  videos_piloto,
  fila_v007
)

write.csv(
  videos_piloto,
  "data/processed/videos_piloto.csv",
  row.names = FALSE,
  fileEncoding = "UTF-8"
)

nrow(videos_piloto)

fila_v008 <- obtener_video_youtube(
  video_id = "cT-H83-TkTk",
  id_interno = "V008"
)

fila_v008[, c(
  "id_video",
  "titulo",
  "canal",
  "fecha_publicacion",
  "vistas",
  "duracion_seg",
  "dias_publicado",
  "vistas_dia"
)]

fila_v008$objetivo_video <- 2
fila_v008$forma_contenido <- 5
fila_v008$funcion_musica <- 2
fila_v008$respuesta_al_ritmo <- 3
fila_v008$repeticion <- 3
fila_v008$tipo_protagonistas <- 9
fila_v008$grupo_edad_protagonista <- 4
fila_v008$complejidad_lenguaje <- 2
fila_v008$tipo_voces <- 5
fila_v008$texto_en_pantalla <- 0
fila_v008$idioma_audio <- 2
fila_v008$idioma_texto <- 0

fila_v008 <- fila_v008[, names(videos_piloto)]

identical(
  names(videos_piloto),
  names(fila_v008)
)

videos_piloto <- rbind(
  videos_piloto,
  fila_v008
)

write.csv(
  videos_piloto,
  "data/processed/videos_piloto.csv",
  row.names = FALSE,
  fileEncoding = "UTF-8"
)

nrow(videos_piloto)

fila_v009 <- obtener_video_youtube(
  video_id = "qBp1rCz_yQU",
  id_interno = "V009"
)

fila_v009[, c(
  "id_video",
  "titulo",
  "canal",
  "fecha_publicacion",
  "vistas",
  "duracion_seg",
  "dias_publicado",
  "vistas_dia"
)]

fila_v009 <- obtener_video_youtube(
  video_id = "NvdUSZyCGRs",
  id_interno = "V009"
)

fila_v009[, c(
  "id_video",
  "titulo",
  "canal",
  "fecha_publicacion",
  "vistas",
  "duracion_seg",
  "dias_publicado",
  "vistas_dia"
)]

fila_v009$objetivo_video <- 2
fila_v009$forma_contenido <- 5
fila_v009$funcion_musica <- 1
fila_v009$respuesta_al_ritmo <- 1
fila_v009$repeticion <- 3
fila_v009$tipo_protagonistas <- 1
fila_v009$grupo_edad_protagonista <- 1
fila_v009$complejidad_lenguaje <- 1
fila_v009$tipo_voces <- 3
fila_v009$texto_en_pantalla <- 1
fila_v009$idioma_audio <- 2
fila_v009$idioma_texto <- 2

fila_v009 <- fila_v009[, names(videos_piloto)]

identical(
  names(videos_piloto),
  names(fila_v009)
)

videos_piloto <- rbind(
  videos_piloto,
  fila_v009
)

write.csv(
  videos_piloto,
  "data/processed/videos_piloto.csv",
  row.names = FALSE,
  fileEncoding = "UTF-8"
)

nrow(videos_piloto)


fila_v010 <- obtener_video_youtube(
  video_id = "_nAu9D-8srA",
  id_interno = "V010"
)

fila_v010[, c(
  "id_video",
  "titulo",
  "canal",
  "fecha_publicacion",
  "vistas",
  "duracion_seg",
  "dias_publicado",
  "vistas_dia"
)]

fila_v010$objetivo_video <- 2
fila_v010$forma_contenido <- 4
fila_v010$funcion_musica <- 1
fila_v010$respuesta_al_ritmo <- 0
fila_v010$repeticion <- 3
fila_v010$tipo_protagonistas <- 8
fila_v010$grupo_edad_protagonista <- 0
fila_v010$complejidad_lenguaje <- 1
fila_v010$tipo_voces <- 1
fila_v010$texto_en_pantalla <- 0
fila_v010$idioma_audio <- 2
fila_v010$idioma_texto <- 0

fila_v010 <- fila_v010[, names(videos_piloto)]

identical(
  names(videos_piloto),
  names(fila_v010)
)

videos_piloto <- rbind(
  videos_piloto,
  fila_v010
)

write.csv(
  videos_piloto,
  "data/processed/videos_piloto.csv",
  row.names = FALSE,
  fileEncoding = "UTF-8"
)

nrow(videos_piloto)

fila_v011 <- obtener_video_youtube(
  video_id = "xfBgELKf0_U",
  id_interno = "V011"
)

fila_v011[, c(
  "id_video",
  "titulo",
  "canal",
  "fecha_publicacion",
  "vistas",
  "duracion_seg",
  "dias_publicado",
  "vistas_dia"
)]


fila_v011 <- fila_v011[, names(videos_piloto)]

identical(
  names(videos_piloto),
  names(fila_v011)
)

videos_piloto <- rbind(
  videos_piloto,
  fila_v011
)

write.csv(
  videos_piloto,
  "data/processed/videos_piloto.csv",
  row.names = FALSE,
  fileEncoding = "UTF-8"
)

nrow(videos_piloto)

fila_v012 <- obtener_video_youtube(
  video_id = "FWobizewBVU",
  id_interno = "V012"
)

fila_v012[, c(
  "id_video",
  "titulo",
  "canal",
  "fecha_publicacion",
  "vistas",
  "duracion_seg",
  "dias_publicado",
  "vistas_dia"
)]

fila_v012$objetivo_video <- 5
fila_v012$forma_contenido <- 5
fila_v012$funcion_musica <- 2
fila_v012$respuesta_al_ritmo <- 3
fila_v012$repeticion <- 3
fila_v012$tipo_protagonistas <- 7
fila_v012$grupo_edad_protagonista <- 5
fila_v012$complejidad_lenguaje <- 2
fila_v012$tipo_voces <- 3
fila_v012$texto_en_pantalla <- 2
fila_v012$idioma_audio <- 2
fila_v012$idioma_texto <- 2

fila_v012 <- fila_v012[, names(videos_piloto)]

identical(
  names(videos_piloto),
  names(fila_v012)
)

videos_piloto <- rbind(
  videos_piloto,
  fila_v012
)

write.csv(
  videos_piloto,
  "data/processed/videos_piloto.csv",
  row.names = FALSE,
  fileEncoding = "UTF-8"
)

nrow(videos_piloto)

fila_v013 <- obtener_video_youtube(
  video_id = "JrlVNPZmT4s",
  id_interno = "V013"
)

fila_v013[, c(
  "id_video",
  "titulo",
  "canal",
  "fecha_publicacion",
  "vistas",
  "duracion_seg",
  "dias_publicado",
  "vistas_dia"
)]

fila_v013$objetivo_video <- 5
fila_v013$forma_contenido <- 5
fila_v013$funcion_musica <- 2
fila_v013$respuesta_al_ritmo <- 3
fila_v013$repeticion <- 3
fila_v013$tipo_protagonistas <- 9
fila_v013$grupo_edad_protagonista <- 2
fila_v013$complejidad_lenguaje <- 2
fila_v013$tipo_voces <- 5
fila_v013$texto_en_pantalla <- 2
fila_v013$idioma_audio <- 2
fila_v013$idioma_texto <- 2

fila_v013 <- fila_v013[, names(videos_piloto)]

identical(
  names(videos_piloto),
  names(fila_v013)
)

videos_piloto <- rbind(
  videos_piloto,
  fila_v013
)

write.csv(
  videos_piloto,
  "data/processed/videos_piloto.csv",
  row.names = FALSE,
  fileEncoding = "UTF-8"
)

nrow(videos_piloto)


candidatos_v014 <- data.frame(
  video_id = busqueda$items$id$videoId,
  titulo = busqueda$items$snippet$title,
  canal = busqueda$items$snippet$channelTitle,
  fecha_publicacion = as.Date(
    busqueda$items$snippet$publishedAt
  ),
  stringsAsFactors = FALSE
)

candidatos_v014

candidatos_v014[, c(
  "video_id",
  "titulo",
  "canal",
  "fecha_publicacion"
)]

candidatos_v014[6, ]

fila_v014 <- obtener_video_youtube(
  "-DcWfIBtrEM",
  "V014"
)

fila_v014


fila_v014$objetivo_video <- 2
fila_v014$forma_contenido <- 5
fila_v014$funcion_musica <- 2
fila_v014$respuesta_al_ritmo <- 1
fila_v014$repeticion <- 2
fila_v014$tipo_protagonistas <- 7
fila_v014$grupo_edad_protagonista <- 5
fila_v014$complejidad_lenguaje <- 2
fila_v014$tipo_voces <- 3
fila_v014$texto_en_pantalla <- 0
fila_v014$idioma_audio <- 2
fila_v014$idioma_texto <- 0

fila_v014 <- fila_v014[, names(videos_piloto)]

videos_piloto <- rbind(
  videos_piloto,
  fila_v014
)

write.csv(
  videos_piloto,
  "data/processed/videos_piloto.csv",
  row.names = FALSE,
  fileEncoding = "UTF-8"
)

nrow(videos_piloto)

candidatos_v014[11, ]

fila_v015 <- obtener_video_youtube(
  "uRjMN0eVGJE",
  "V015"
)

fila_v015

fila_v015$objetivo_video <- 4
fila_v015$forma_contenido <- 5
fila_v015$funcion_musica <- 2
fila_v015$respuesta_al_ritmo <- 1
fila_v015$repeticion <- 3
fila_v015$tipo_protagonistas <- 7
fila_v015$grupo_edad_protagonista <- 5
fila_v015$complejidad_lenguaje <- 2
fila_v015$tipo_voces <- 3
fila_v015$texto_en_pantalla <- 2
fila_v015$idioma_audio <- 2
fila_v015$idioma_texto <- 2

fila_v015 <- fila_v015[, names(videos_piloto)]

videos_piloto <- rbind(
  videos_piloto,
  fila_v015
)

write.csv(
  videos_piloto,
  "data/processed/videos_piloto.csv",
  row.names = FALSE,
  fileEncoding = "UTF-8"
)

nrow(videos_piloto)

respuesta_medio <- httr::GET(
  "https://www.googleapis.com/youtube/v3/search",
  query = list(
    part = "snippet",
    q = "kids songs nursery rhymes",
    type = "video",
    order = "viewCount",
    maxResults = 25,
    key = api_key
  )
)


dim(videos_piloto)

names(videos_piloto)

table(videos_piloto$objetivo_video)

summary(videos_piloto$vistas)
summary(videos_piloto$vistas_dia)
summary(videos_piloto$duracion_seg)
httr::stop_for_status(respuesta_medio)

busqueda_medio <- jsonlite::fromJSON(
  httr::content(
    respuesta_medio,
    "text",
    encoding = "UTF-8"
  )
)

candidatos_medio <- data.frame(
  video_id = busqueda_medio$items$id$videoId,
  titulo = busqueda_medio$items$snippet$title,
  canal = busqueda_medio$items$snippet$channelTitle,
  fecha_publicacion = as.Date(
    busqueda_medio$items$snippet$publishedAt
  ),
  stringsAsFactors = FALSE
)

candidatos_medio

colSums(is.na(videos_piloto))

ranking_piloto <- videos_piloto[
  order(videos_piloto$vistas_dia, decreasing = TRUE),
  c(
    "id_video",
    "titulo",
    "vistas",
    "vistas_dia",
    "duracion_seg",
    "objetivo_video",
    "forma_contenido",
    "funcion_musica",
    "respuesta_al_ritmo",
    "repeticion"
  )
]

ranking_piloto

variables_categoricas <- c(
  "objetivo_video",
  "forma_contenido",
  "funcion_musica",
  "respuesta_al_ritmo",
  "repeticion",
  "tipo_protagonistas",
  "grupo_edad_protagonista",
  "complejidad_lenguaje",
  "tipo_voces",
  "texto_en_pantalla",
  "idioma_audio",
  "idioma_texto"
)

lapply(
  videos_piloto[variables_categoricas],
  table
)


aggregate(
  vistas_dia ~ objetivo_video,
  data = videos_piloto,
  FUN = function(x) c(
    n = length(x),
    mediana = median(x),
    media = mean(x),
    minimo = min(x),
    maximo = max(x)
  )
)

aggregate(
  vistas_dia ~ respuesta_al_ritmo,
  data = videos_piloto,
  FUN = function(x) c(
    n = length(x),
    mediana = median(x),
    media = mean(x),
    minimo = min(x),
    maximo = max(x)
  )
)

summary(videos_piloto$duracion_seg)

cor(
  videos_piloto$duracion_seg,
  videos_piloto$vistas_dia,
  method = "spearman"
)

videos_piloto[
  order(videos_piloto$duracion_seg),
  c(
    "id_video",
    "duracion_seg",
    "vistas_dia",
    "fecha_publicacion",
    "objetivo_video"
  )
]

class(videos_piloto$fecha_publicacion)

str(videos_piloto$fecha_publicacion)

videos_piloto[, c(
  "id_video",
  "fecha_publicacion"
)]

es_fecha_correcta <- grepl(
  "^\\d{4}-\\d{2}-\\d{2}$",
  videos_piloto$fecha_publicacion
)

fecha_corregida <- videos_piloto$fecha_publicacion

fecha_corregida[!es_fecha_correcta] <- as.character(
  as.Date(
    as.numeric(fecha_corregida[!es_fecha_correcta]),
    origin = "1970-01-01"
  )
)

videos_piloto$fecha_publicacion <- as.Date(fecha_corregida)

class(videos_piloto$fecha_publicacion)

videos_piloto[, c(
  "id_video",
  "fecha_publicacion"
)]

write.csv(
  videos_piloto,
  "data/processed/videos_piloto.csv",
  row.names = FALSE,
  fileEncoding = "UTF-8"
)

class(videos_piloto$fecha_publicacion)

cor(
  videos_piloto$duracion_seg,
  videos_piloto$vistas_dia,
  method = "spearman"
)

cor(
  videos_piloto$vistas_dia[videos_piloto$duracion_seg < 1000],
  videos_piloto$duracion_seg[videos_piloto$duracion_seg < 1000],
  method = "spearman"
)

videos_piloto$tipo_formato <- 1

videos_piloto$tipo_formato[
  videos_piloto$id_video %in% c("V011", "V012", "V013")
] <- 2

table(videos_piloto$tipo_formato)

videos_piloto$tipo_formato <- 1

videos_piloto$tipo_formato[
  videos_piloto$id_video %in% c("V011", "V012", "V013")
] <- 2

table(videos_piloto$tipo_formato)

aggregate(
  vistas_dia ~ tipo_formato,
  data = videos_piloto,
  FUN = function(x) c(
    n = length(x),
    mediana = median(x),
    media = mean(x),
    minimo = min(x),
    maximo = max(x)
  )
)

aggregate(
  duracion_seg ~ tipo_formato,
  data = videos_piloto,
  FUN = function(x) c(
    n = length(x),
    mediana = median(x),
    minimo = min(x),
    maximo = max(x)
  )
)

write.csv(
  videos_piloto,
  "data/processed/videos_piloto.csv",
  row.names = FALSE,
  fileEncoding = "UTF-8"
)

dim(videos_piloto)

colSums(is.na(videos_piloto))

resumen_variable <- function(variable) {
  
  resultado <- aggregate(
    videos_piloto$vistas_dia,
    by = list(categoria = videos_piloto[[variable]]),
    FUN = function(x) c(
      n = length(x),
      mediana = median(x),
      media = mean(x)
    )
  )
  
  resultado
}

resumen_variable("forma_contenido")
resumen_variable("funcion_musica")
resumen_variable("repeticion")
resumen_variable("tipo_protagonistas")
resumen_variable("tipo_voces")
resumen_variable("texto_en_pantalla")

videos_individuales <- subset(
  videos_piloto,
  tipo_formato == 1
)

nrow(videos_individuales)

resumen_individuales <- function(variable) {
  
  aggregate(
    videos_individuales$vistas_dia,
    by = list(
      categoria = videos_individuales[[variable]]
    ),
    FUN = function(x) c(
      n = length(x),
      mediana = median(x),
      media = mean(x)
    )
  )
}

resumen_individuales("forma_contenido")
resumen_individuales("funcion_musica")
resumen_individuales("repeticion")

mediana_rendimiento <- median(
  videos_individuales$vistas_dia
)

mediana_rendimiento


videos_individuales$rendimiento_piloto <- ifelse(
  videos_individuales$vistas_dia >= mediana_rendimiento,
  "Mayor",
  "Menor"
)

table(videos_individuales$rendimiento_piloto)


videos_individuales[
  order(videos_individuales$vistas_dia, decreasing = TRUE),
  c(
    "id_video",
    "vistas_dia",
    "rendimiento_piloto",
    "objetivo_video",
    "forma_contenido",
    "funcion_musica",
    "respuesta_al_ritmo",
    "repeticion",
    "tipo_protagonistas"
  )
]

file.exists("data/processed/videos_piloto.csv")

write.csv(
  videos_piloto,
  "data/processed/videos_piloto.csv",
  row.names = FALSE,
  fileEncoding = "UTF-8"
)

dim(videos_piloto)

videos_individuales <- subset(
  videos_piloto,
  tipo_formato == 1
)

mediana_rendimiento <- median(
  videos_individuales$vistas_dia
)

videos_individuales$rendimiento_piloto <- ifelse(
  videos_individuales$vistas_dia >= mediana_rendimiento,
  "Mayor",
  "Menor"
)

table(videos_individuales$rendimiento_piloto)

prop.table(
  table(
    videos_individuales$rendimiento_piloto,
    videos_individuales$forma_contenido
  ),
  margin = 1
) * 100

prop.table(
  table(
    videos_individuales$rendimiento_piloto,
    videos_individuales$funcion_musica
  ),
  margin = 1
) * 100

prop.table(
  table(
    videos_individuales$rendimiento_piloto,
    videos_individuales$respuesta_al_ritmo
  ),
  margin = 1
) * 100

prop.table(
  table(
    videos_individuales$rendimiento_piloto,
    videos_individuales$repeticion
  ),
  margin = 1
) * 100

forma_contenido
funcion_musica
respuesta_al_ritmo


prop.table(
  table(
    videos_individuales$rendimiento_piloto,
    videos_individuales$forma_contenido
  ),
  margin = 1
) * 100

prop.table(
  table(
    videos_individuales$rendimiento_piloto,
    videos_individuales$funcion_musica
  ),
  margin = 1
) * 100

barplot(
  videos_individuales$vistas_dia[
    order(videos_individuales$vistas_dia)
  ],
  names.arg = videos_individuales$id_video[
    order(videos_individuales$vistas_dia)
  ],
  horiz = TRUE,
  las = 1,
  xlab = "Vistas promedio por día",
  main = "Rendimiento de los videos individuales"
)

abline(
  v = mediana_rendimiento,
  lty = 2,
  lwd = 2
)


plot(
  videos_individuales$duracion_seg,
  videos_individuales$vistas_dia,
  pch = 19,
  xlab = "Duración del video (segundos)",
  ylab = "Vistas promedio por día",
  main = "Duración y rendimiento de videos individuales"
)

text(
  videos_individuales$duracion_seg,
  videos_individuales$vistas_dia,
  labels = videos_individuales$id_video,
  pos = 3,
  cex = 0.8
)

aggregate(
  vistas_dia ~ forma_contenido,
  data = videos_individuales,
  FUN = median
)

subset(
  videos_individuales,
  forma_contenido %in% c(1, 5),
  select = c(
    id_video,
    forma_contenido,
    duracion_seg,
    vistas_dia,
    objetivo_video,
    repeticion
  )
)

subset(
  videos_individuales,
  forma_contenido %in% c(1, 5),
  select = c(
    id_video,
    fecha_publicacion,
    forma_contenido,
    vistas_dia
  )
)

videos_individuales$anio_publicacion <- as.numeric(
  format(videos_individuales$fecha_publicacion, "%Y")
)

cor(
  videos_individuales$anio_publicacion,
  videos_individuales$vistas_dia,
  method = "spearman"
)

sin_v006 <- subset(
  videos_individuales,
  id_video != "V006"
)

cor(
  sin_v006$anio_publicacion,
  sin_v006$vistas_dia,
  method = "spearman"
)

plot(
  videos_individuales$anio_publicacion,
  videos_individuales$vistas_dia,
  pch = 19,
  xlab = "Año de publicación",
  ylab = "Vistas promedio por día",
  main = "Año de publicación y rendimiento"
)

text(
  videos_individuales$anio_publicacion,
  videos_individuales$vistas_dia,
  labels = videos_individuales$id_video,
  pos = 3,
  cex = 0.8
)

prop.table(
  table(
    videos_individuales$rendimiento_piloto,
    videos_individuales$tipo_protagonistas
  ),
  margin = 1
) * 100

prop.table(
  table(
    videos_individuales$rendimiento_piloto,
    videos_individuales$complejidad_lenguaje
  ),
  margin = 1
) * 100

prop.table(
  table(
    videos_individuales$rendimiento_piloto,
    videos_individuales$tipo_voces
  ),
  margin = 1
) * 100

prop.table(
  table(
    videos_individuales$rendimiento_piloto,
    videos_individuales$texto_en_pantalla
  ),
  margin = 1
) * 100

