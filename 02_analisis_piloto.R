
# ============================================================
# ANALISIS EXPLORATORIO - VIDEOS INFANTILES
# Proyecto: YouTube Kids Analysis
# ============================================================

getwd()



# 1. Cargar base procesada

videos_piloto <- read.csv(
  "data/processed/videos_piloto.csv",
  stringsAsFactors = FALSE,
  fileEncoding = "UTF-8"
)

# Convertir fecha de publicacion a tipo Date
videos_piloto$fecha_publicacion <- as.Date(
  videos_piloto$fecha_publicacion
)

# Verificar dimensiones
dim(videos_piloto)


# ============================================================
# 2. Separar videos individuales y compilaciones
# ============================================================

videos_individuales <- subset(
  videos_piloto,
  tipo_formato == 1
)

videos_compilaciones <- subset(
  videos_piloto,
  tipo_formato == 2
)

# Verificar cantidad de videos en cada grupo
nrow(videos_individuales)
nrow(videos_compilaciones)

# ============================================================
# 3. Clasificacion del rendimiento de videos individuales
# ============================================================

# Mediana de vistas promedio por dia
mediana_rendimiento <- median(
  videos_individuales$vistas_dia
)

mediana_rendimiento

# Clasificar cada video respecto a la mediana
videos_individuales$rendimiento_piloto <- ifelse(
  videos_individuales$vistas_dia >= mediana_rendimiento,
  "Mayor",
  "Menor"
)

# Verificar distribucion
table(videos_individuales$rendimiento_piloto)

# ============================================================
# 4. Comparacion de caracteristicas: Mayor vs Menor
# ============================================================

comparar_rendimiento <- function(variable) {
  
  tabla <- table(
    videos_individuales$rendimiento_piloto,
    videos_individuales[[variable]]
  )
  
  round(
    prop.table(tabla, margin = 1) * 100,
    1
  )
}

# Comparaciones principales

comparar_rendimiento("forma_contenido")
comparar_rendimiento("funcion_musica")
comparar_rendimiento("respuesta_al_ritmo")
comparar_rendimiento("repeticion")
comparar_rendimiento("tipo_protagonistas")
comparar_rendimiento("complejidad_lenguaje")
comparar_rendimiento("tipo_voces")
comparar_rendimiento("texto_en_pantalla")

# ============================================================
# 5. Medianas y correlaciones exploratorias
# ============================================================

# Mediana de vistas por dia segun forma del contenido
mediana_forma <- aggregate(
  vistas_dia ~ forma_contenido,
  data = videos_individuales,
  FUN = median
)

mediana_forma


# ------------------------------------------------------------
# Duracion del video y rendimiento
# ------------------------------------------------------------

cor_duracion <- cor(
  videos_individuales$duracion_seg,
  videos_individuales$vistas_dia,
  method = "spearman"
)

cor_duracion


# ------------------------------------------------------------
#6.3 Año de publicacion y rendimiento
# ------------------------------------------------------------

videos_individuales$anio_publicacion <- as.numeric(
  format(videos_individuales$fecha_publicacion, "%Y")
)

cor_anio <- cor(
  videos_individuales$anio_publicacion,
  videos_individuales$vistas_dia,
  method = "spearman"
)

cor_anio


# ------------------------------------------------------------
# Analisis de sensibilidad sin V006
# ------------------------------------------------------------

sin_v006 <- subset(
  videos_individuales,
  id_video != "V006"
)

cor_anio_sin_v006 <- cor(
  sin_v006$anio_publicacion,
  sin_v006$vistas_dia,
  method = "spearman"
)

cor_anio_sin_v006

# ============================================================
# 7. Guardar resultados del analisis
# ============================================================

# Crear carpeta de resultados si no existe
if (!dir.exists("resultados")) {
  dir.create("resultados")
}

# Guardar clasificacion de los 12 videos individuales
write.csv(
  videos_individuales,
  "resultados/videos_individuales_analisis.csv",
  row.names = FALSE,
  fileEncoding = "UTF-8"
)

# Guardar medianas por forma de contenido
write.csv(
  mediana_forma,
  "resultados/mediana_por_forma_contenido.csv",
  row.names = FALSE,
  fileEncoding = "UTF-8"
)

list.files("resultados")