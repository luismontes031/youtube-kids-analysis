YouTube Kids Analysis
Proyecto exploratorio de análisis de datos sobre consumo y
preferencias de videos infantiles en niños de 0 a 6 años.
El proyecto combina dos fuentes de información:
1. Análisis de contenido y rendimiento de videos infantiles en
   YouTube.
2. Encuesta a cuidadores sobre selección, consumo, repetición y
   señales de preferencia observadas en los niños.
El objetivo es identificar patrones descriptivos que ayuden a comprender
qué características aparecen asociadas con el consumo y la preferencia
por contenidos infantiles. Los resultados son exploratorios y no
buscan establecer relaciones causales.
Preguntas del proyecto
- ¿Qué características aparecen con mayor frecuencia en videos
  infantiles con mayor rendimiento dentro del piloto?
- ¿Cómo intervienen los cuidadores en la selección de videos?
- ¿Qué señales utilizan para reconocer que un niño prefiere un
  contenido?
- ¿Qué características de los videos son señaladas con mayor
  frecuencia como atractivas?
- ¿Qué contenidos son mencionados repetidamente por los cuidadores?
- ¿Cómo cambia la forma de selección del contenido según la edad del
  niño?
Fuentes de datos
1. Piloto de videos de YouTube
Se analizaron 15 videos infantiles: 12 videos individuales y 3
compilaciones. Los datos de rendimiento se obtuvieron mediante la API de
YouTube y las características del contenido fueron codificadas
manualmente mediante observación.
Entre las variables se encuentran vistas, duración, vistas promedio por
día, objetivo, forma del contenido, función de la música, respuesta al
ritmo, repetición, protagonistas, complejidad del lenguaje, voces, texto
en pantalla, idioma y formato.
vistas_dia = vistas acumuladas / días publicados
Por tanto, vistas_dia es un promedio histórico y no representa la
velocidad actual de visualizaciones.
2. Encuesta a cuidadores
Se analizaron 114 respuestas de cuidadores de niños de 0 a 6 años.
La encuesta explora relación del cuidador, edad, forma de selección del
video, situaciones de consumo, respuesta ante videos propuestos, señales
de preferencia, reconsumo, contenidos preferidos, motivos y
características de los videos.
La muestra es de conveniencia/no probabilística, por lo que los
resultados describen a las personas participantes y no deben
generalizarse a toda la población.
Metodología
El flujo general fue:
Recolección
    ↓
Datos originales
    ↓
Limpieza y auditoría
    ↓
Codificación de variables
    ↓
Datos procesados
    ↓
Análisis exploratorio
    ↓
Tablas y visualizaciones
    ↓
Interpretación descriptiva
El análisis se desarrolló principalmente en R. Para variables muy
asimétricas, como las vistas por día, se priorizaron medianas y análisis
exploratorios. Las preguntas de selección múltiple de la encuesta se
transformaron en indicadores binarios y las respuestas abiertas fueron
normalizadas y agrupadas en categorías analíticas.
Los datos originales se mantienen separados de las variables derivadas
para conservar trazabilidad.
Principales resultados del piloto de YouTube
Para comparar los 12 videos individuales se utilizó la mediana de
vistas_dia, formando dos grupos exploratorios: Mayor y Menor
rendimiento.
Entre los patrones observados:
- Los videos de forma musical mostraron una mediana de rendimiento
  superior a los de forma mixta dentro del pequeño piloto.
- El texto continuo en pantalla apareció con mayor frecuencia en el
  grupo de mayor rendimiento.
- La repetición fue frecuente tanto en videos de mayor como de menor
  rendimiento.
- La música, por sí sola, no permitió separar claramente los grupos.
- El lenguaje simple fue común en ambos grupos.
- No se observó una separación clara según el tipo de voces.
- La relación entre duración y rendimiento se debilitó
  considerablemente al excluir las compilaciones largas.
- El año de publicación mostró asociación con el rendimiento,
  señalando la antigüedad como factor de confusión importante.
No se utilizaron modelos inferenciales o regresiones debido al reducido
tamaño del piloto y a la fragmentación de varias categorías.
Principales resultados de la encuesta
Mediación del cuidador
La selección muestra una participación importante del adulto,
especialmente en edades tempranas:
- 43.0 %: el adulto elige.
- 27.2 %: el adulto ofrece opciones.
- 15.8 %: el niño selecciona por sí mismo.
- 21.9 %: el niño pide un contenido específico.
La pregunta permitía respuestas múltiples, por lo que los porcentajes no
deben sumar 100 %. Descriptivamente, con el aumento de la edad se
observó una mayor participación del niño.
Señales de preferencia
Las señales observadas con mayor frecuencia fueron entusiasmo (48.2
%), atención (30.7 %), movimiento (29.8 %), preferencia por un
contenido específico (24.6 %) y repetición de elementos del
contenido (23.7 %).
Estas son señales reportadas por los cuidadores, no mediciones
directas de la conducta infantil.
Características preferidas
Las características mencionadas con mayor frecuencia fueron música
(50.9 %), animales (38.6 %), personajes infantiles (25.4 %),
elementos repetitivos (22.8 %), colores y movimiento (21.9 %),
contenido educativo (21.1 %) y baile o imitación (18.4 %).

Reconsumo
El 80.7 % de los cuidadores indicó que el niño pide, busca o vuelve
a consumir algún contenido repetidamente.
Este resultado no debe confundirse con la repetición interna del
video: volver a ver un contenido y que un video utilice estructuras
repetitivas son fenómenos distintos.
Contenidos mencionados
Las respuestas abiertas fueron normalizadas para identificar contenidos
específicos. Entre los más mencionados se encontraron Plim Plim, Luli
Pampín, Bluey, Blippi, Peppa Pig y Abejita Chiquitita.

Selección según edad
El análisis descriptivo muestra mayor mediación adulta en los grupos de
menor edad y una participación progresivamente mayor del niño en edades
posteriores.

Interpretación conjunta
Los dos componentes responden preguntas diferentes y no deben mezclarse
como si midieran exactamente lo mismo.
El análisis de YouTube describe características y rendimiento
histórico de contenidos publicados, mientras que la encuesta describe
comportamientos y preferencias percibidas por cuidadores.
En conjunto, los resultados sugieren líneas de interés para análisis
posteriores: música y ritmo, personajes y animales, repetición,
participación corporal, mediación del cuidador, edad del niño y la
diferencia entre contenido disponible, contenido ofrecido y contenido
realmente solicitado por el niño.
Que un niño vea un video no implica necesariamente una preferencia
autónoma, porque la selección puede estar mediada por un adulto.
Estructura del repositorio
youtube-kids-analysis/
├── README.md
├── youtube-kids-analysis.Rproj
├── .gitignore
├── 01_importar_datos.R
├── 02_analisis_piloto.R
├── 03_analisis_encuesta.R
├── data/
│   ├── raw/
│   │   ├── videos_piloto.xlsx
│   │   └── encuesta_familia.csv
│   └── processed/
│       ├── videos_piloto.csv
│       └── encuesta_familia_limpia.csv
├── docs/
│   └── diccionario_variables.md
└── resultados/
    ├── encuesta_caracteristicas_preferidas.csv
    ├── encuesta_caracteristicas_preferidas.png
    ├── encuesta_contenidos_mencionados.csv
    ├── encuesta_distribucion_edad.csv
    ├── encuesta_formas_seleccion.csv
    ├── encuesta_motivos_preferencia.csv
    ├── encuesta_reconsumo_contenido.csv
    ├── encuesta_seleccion_por_edad.csv
    ├── encuesta_seleccion_por_edad.png
    ├── encuesta_senales_preferencia.csv
    ├── encuesta_top_contenidos.png
    ├── mediana_por_forma_contenido.csv
    └── videos_individuales_analisis.csv
Scripts principales
01_importar_datos.R: script histórico utilizado para obtener
información mediante la API de YouTube, construir el piloto y realizar
la codificación inicial.
02_analisis_piloto.R: análisis exploratorio final del piloto,
separación entre videos individuales y compilaciones, clasificación
respecto a la mediana y correlaciones exploratorias.
03_analisis_encuesta.R: importación, auditoría, limpieza,
normalización, codificación y análisis descriptivo de las 114
respuestas, además de generación de tablas y gráficos.
docs/diccionario_variables.md: documentación de las variables
originales, codificadas y derivadas.
Herramientas
- R
- RStudio
- YouTube Data API v3
- Google Forms
- Excel / CSV
- Git
- GitHub
- VS Code
Limitaciones
- El piloto de YouTube contiene solamente 15 videos y únicamente 12
  son individuales.
- El rendimiento puede estar influido por canal, antigüedad, duración,
  formato y otros factores.
- vistas_dia es un promedio histórico, no una medida de tendencia
  actual.
- La encuesta utiliza una muestra de conveniencia.
- Las preferencias infantiles son reportadas por cuidadores.
- Algunas preguntas permiten respuestas múltiples.
- La codificación de texto abierto implica decisiones analíticas.
- Los resultados son descriptivos y exploratorios.
- No se establecen relaciones causales.
Estado del proyecto
La fase actual incluye recolección y procesamiento del piloto, análisis
exploratorio de YouTube, encuesta de 114 cuidadores, limpieza y
codificación reproducible, análisis descriptivo, tablas,
visualizaciones, diccionario de variables y control de versiones con
Git.
El proyecto queda preparado para futuras ampliaciones de la muestra de
videos, incorporación de nuevas métricas y análisis comparativos con
mayor capacidad estadística.