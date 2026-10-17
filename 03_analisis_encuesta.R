# ============================================================
# ANALISIS DE ENCUESTA A CUIDADORES
# Proyecto: YouTube Kids Analysis
# ============================================================

# 1. Verificar archivo original

file.exists("data/raw/encuesta_familia.csv")

# ============================================================
# 2. Importar encuesta original
# ============================================================

encuesta_familia <- read.csv(
  "data/raw/encuesta_familia.csv",
  stringsAsFactors = FALSE,
  fileEncoding = "UTF-8",
  check.names = FALSE
)

# Verificar dimensiones
dim(encuesta_familia)

readLines(
  "data/raw/encuesta_familia.csv",
  n = 3,
  encoding = "UTF-8"
)

names(encuesta_familia)

# ============================================================
# 3. Crear nombres cortos para las variables
# ============================================================

names(encuesta_familia) <- c(
  "timestamp",
  "relacion_cuidador",
  "edad_nino",
  "seleccion_video",
  "situacion_consumo",
  "respuesta_video_propuesto",
  "senal_preferencia",
  "contenido_repetido",
  "contenido_preferido",
  "motivo_preferencia",
  "caracteristicas_video"
)

names(encuesta_familia)

# ============================================================
# 4. Auditoria inicial de la encuesta
# ============================================================

# Dimensiones
dim(encuesta_familia)

# Valores faltantes NA por variable
colSums(is.na(encuesta_familia))

# Celdas vacias "" por variable
colSums(encuesta_familia == "")

# Primeras respuestas
head(encuesta_familia, 3)

# ============================================================
# 5. Revisar variables principales
# ============================================================

table(encuesta_familia$relacion_cuidador, useNA = "ifany")

table(encuesta_familia$edad_nino, useNA = "ifany")

table(encuesta_familia$contenido_repetido, useNA = "ifany")


table(
  encuesta_familia$contenido_repetido[
    encuesta_familia$contenido_preferido == ""
  ],
  useNA = "ifany"
)

encuesta_familia[
  encuesta_familia$contenido_repetido != "Sí" &
    encuesta_familia$contenido_preferido != "",
  c("contenido_repetido", "contenido_preferido")
]

table(encuesta_familia$respuesta_video_propuesto)

table(encuesta_familia$seleccion_video)

# ============================================================