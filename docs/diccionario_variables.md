Diccionario de variables --- YouTube Kids Analysis
1. Propósito
Este documento describe las variables utilizadas en el proyecto
YouTube Kids Analysis y distingue entre:
- Datos obtenidos de YouTube: información recuperada mediante la
  API o construida directamente a partir de ella.
- Codificación manual: características del contenido asignadas
  mediante observación de los videos.
- Variables derivadas: variables calculadas durante el
  procesamiento o análisis.
- Datos originales de la encuesta: respuestas conservadas desde
  Google Forms.
- Variables codificadas de la encuesta: indicadores creados para
  facilitar el análisis.
Regla de documentación: cuando el significado exacto de una
categoría numérica no está definido explícitamente en los scripts
disponibles, no se asigna una interpretación retrospectiva. La
equivalencia queda pendiente de especificación.

2. Base de videos
Archivo principal:
data/processed/videos_piloto.csv
La base final contiene 15 videos y 23 variables.
2.1 Variables de identificación y datos de YouTube
  Variable              Tipo              Origen            Descripción
  id_video            Texto             Proyecto          Identificador interno del
                                                            video, de V001 a V015.
  titulo              Texto             YouTube API       Título del video.
  canal               Texto             YouTube API       Nombre del canal que publicó
                                                            el video.
  url                 Texto             Derivada/API      URL construida a partir del
                                                            identificador del video de
                                                            YouTube.
  fecha_publicacion   Fecha             YouTube API       Fecha de publicación del
                                                            video.
  fecha_recoleccion   Fecha             Proyecto          Fecha en la que se
                                                            recuperaron los datos del
                                                            video.
  vistas              Numérica          YouTube API       Número acumulado de
                                                            visualizaciones registrado
                                                            al momento de la
                                                            recolección.
  duracion_seg        Numérica          Derivada/API      Duración total del video
                                                            expresada en segundos.
  dias_publicado      Numérica          Derivada          Días transcurridos entre
                                                            fecha_publicacion y
                                                            fecha_recoleccion.
  vistas_dia          Numérica          Derivada          Promedio histórico de vistas
                                                            por día:
                                                            vistas / dias_publicado.
                                                            No representa la velocidad
                                                        actual de visualizaciones.
2.2 Variables de codificación manual del contenido
Estas variables fueron asignadas mediante observación de los videos.
  Variable                    Tipo                    Descripción
  objetivo_video            Categórica numérica     Clasificación del
                                                      objetivo principal del
                                                      contenido.
  forma_contenido           Categórica numérica     Forma o estructura
                                                      mediante la cual se
                                                      presenta el contenido.
  funcion_musica            Categórica numérica     Función que cumple la
                                                      música dentro del video.
  respuesta_al_ritmo        Categórica numérica     Tipo de respuesta
                                                      corporal o vocal que el
                                                      contenido puede promover
                                                      mediante el ritmo.
  repeticion                Categórica numérica     Nivel o modalidad de
                                                      repetición observada en
                                                      el contenido.
  tipo_protagonistas        Categórica numérica     Tipo de protagonistas
                                                      presentes en el video.
  grupo_edad_protagonista   Categórica numérica     Grupo de edad aparente o
                                                      categoría de edad de los
                                                      protagonistas.
  complejidad_lenguaje      Categórica numérica     Nivel de complejidad del
                                                      lenguaje utilizado.
  tipo_voces                Categórica numérica     Tipo o combinación de
                                                      voces utilizadas.
  texto_en_pantalla         Categórica numérica     Presencia o modalidad de
                                                      texto visible en
                                                      pantalla.
  idioma_audio              Categórica numérica     Idioma del componente de
                                                      audio.
  idioma_texto              Categórica numérica     Idioma del texto
                                                      presentado en pantalla.
  tipo_formato              Categórica numérica     Formato general del
                                                      video:
                                                      1 = video individual;
                                                  2 = compilación.
Nota sobre las escalas numéricas
El script histórico de construcción asigna valores numéricos a las
variables anteriores video por video, pero no contiene una tabla
completa que defina textualmente todas las equivalencias. Por ello, las
categorías no verificadas no se reinterpretan ni se inventan en este
diccionario.
3. Variables derivadas del análisis de videos
Estas variables se generan durante 02_analisis_piloto.R y no
necesariamente forman parte de las 23 columnas del archivo procesado
original.
  Variable                Tipo                    Descripción
  rendimiento_piloto    Categórica              Clasifica los videos
                                                  individuales respecto a
                                                  la mediana de
                                                  vistas_dia. Mayor
                                                  si el valor es mayor o
                                                  igual a la mediana y
                                                  Menor si está por
                                                  debajo.
  anio_publicacion      Numérica                Año extraído de
                                                  fecha_publicacion
                                                  para el análisis
                                                  exploratorio de
                                                  antigüedad y
                                              rendimiento.
Para el análisis principal, tipo_formato == 1 identifica los videos
individuales y tipo_formato == 2 las compilaciones. La clasificación
rendimiento_piloto se calcula únicamente para los videos individuales.
4. Encuesta a cuidadores
Archivos:
- Original: data/raw/encuesta_familia.csv
- Procesado: data/processed/encuesta_familia_limpia.csv
La encuesta contiene 114 respuestas. El archivo original importado
contiene 11 variables. El archivo procesado conserva esas variables
y agrega indicadores derivados para el análisis.
La muestra es de conveniencia/no probabilística. Los resultados son
descriptivos y exploratorios y no deben interpretarse como
representativos de todos los cuidadores o niños de 0 a 6 años.
4.1 Variables originales
  Variable                      Tipo                    Descripción
  timestamp                   Fecha-hora              Fecha y hora de envío
                                                        del formulario.
                                                        Posteriormente
                                                        convertida a POSIXct,
                                                        zona horaria
                                                        America/Bogota.
  relacion_cuidador           Texto/categórica        Relación de la persona
                                                        encuestada con el niño.
  edad_nino                   Texto/categórica        Edad reportada del
                                                        niño.
  seleccion_video             Texto multirrespuesta   Forma en que se
                                                        selecciona el video que
                                                        ve el niño.
  situacion_consumo           Texto multirrespuesta   Situaciones en las que
                                                        se utilizan o consumen
                                                        videos.
  respuesta_video_propuesto   Categórica              Respuesta observada
                                                        cuando un adulto
                                                        propone un video.
  senal_preferencia           Texto multirrespuesta   Señales mediante las
                                                        cuales el cuidador
                                                        identifica que al niño
                                                        le gusta un contenido.
  contenido_repetido          Categórica              Indica si el niño suele
                                                        volver a consumir el
                                                        mismo contenido.
  contenido_preferido         Texto abierto           Contenido, personaje,
                                                        canal o descripción
                                                        indicada por el
                                                        cuidador como
                                                        preferida.
  motivo_preferencia          Texto abierto           Motivo expresado por el
                                                        cuidador para explicar
                                                        la preferencia del
                                                        niño.
  caracteristicas_video       Texto multirrespuesta   Características de los
                                                        videos que el cuidador
                                                        considera atractivas
                                                    para el niño.
Los campos en blanco se conservan como comportamiento real de respuesta
y no se consideran automáticamente errores de calidad.
5. Variables derivadas de edad y cuidador
  Variable                    Tipo                    Codificación /
                                                      descripción
  edad_numerica             Numérica                Edad transformada para
                                                      análisis. La categoría
                                                      menor de 1 año se
                                                      representa con 0;
                                                      este cero identifica
                                                      una categoría y no
                                                      significa edad exacta
                                                      de cero años.
  edad_grupo                Categórica ordenada     Agrupación de edad
                                                      utilizada en los
                                                      análisis por edad.
  relacion_cuidador_grupo   Categórica              Agrupa las respuestas
                                                      de relación del
                                                      cuidador en categorías
                                                      analíticas como madre,
                                                      padre, padre y madre,
                                                      otro familiar y otro
                                                  cuidador.
6. Selección del video
Variables binarias derivadas de seleccion_video.
Codificación general: 1 = opción identificada en la respuesta;
0 = opción no identificada.
  Variable                            Descripción
  sel_adulto_elige                  El adulto elige directamente el
                                      contenido.
  sel_adulto_ofrece                 El adulto ofrece opciones para que
                                      el niño elija.
  sel_nino_selecciona               El niño selecciona el contenido por
                                      sí mismo.
  sel_nino_pide                     El niño solicita un contenido
                                      específico.
  sel_otra_forma                    Se reportó otra forma de selección.
Son variables de respuesta múltiple; por ello sus porcentajes no
tienen que sumar 100 %.
7. Situaciones de consumo
Variables derivadas de situacion_consumo.
  Variable                            Descripción
  sit_entretener                    Uso del video para entretener.
  sit_calmar                        Uso para calmar al niño.
  sit_rutina                        Uso asociado con una rutina.
  sit_espera                        Uso durante situaciones de espera.
  sit_aprender                      Uso con propósito de aprendizaje.
  sit_adulto_ocupado                Uso mientras el adulto está
                                      ocupado.
  sit_nino_pide                     Consumo porque el niño solicita el
                                      video.
  sit_compartir                     Consumo como actividad compartida.
  sit_otro_texto                    Texto original asociado con una
                                      respuesta de tipo "otro".
  sit_otro                          Indicador binario de otra
                                      situación.
  sit_sin_respuesta                 Indicador de ausencia de respuesta
                                  en esta pregunta.
Salvo sit_otro_texto, los indicadores se interpretan como variables
binarias 0/1.
8. Señales observadas de preferencia
Variables binarias derivadas de senal_preferencia.
  Variable                            Descripción
  pref_atencion                     Mantiene o incrementa la atención.
  pref_entusiasmo                   Muestra entusiasmo.
  pref_se_calma                     Se calma al consumir el contenido.
  pref_movimiento                   Se mueve o responde corporalmente.
  pref_repite                       Repite elementos del contenido.
  pref_pide_repetir                 Solicita volver a reproducirlo.
  pref_especifico                   Manifiesta preferencia por un
                                      contenido específico.
  pref_busca_solo                   Busca o selecciona el contenido por
                                      sí mismo.
  pref_repite_sin_perder_interes    Repite el contenido sin perder
                                  interés aparente.
Estas variables representan señales observadas por el cuidador y no
medidas objetivas directas de preferencia infantil.
9. Características preferidas del video
Variables binarias derivadas de caracteristicas_video.
  Variable                            Descripción
  car_musica                        Música.
  car_repeticion                    Palabras, sonidos o elementos
                                      repetitivos.
  car_animales                      Presencia de animales.
  car_infantiles                    Personajes infantiles.
  car_personajes_conocidos          Personajes conocidos por el niño.
  car_colores_movimiento            Colores llamativos y/o movimiento
                                      visual.
  car_historias                     Historias simples.
  car_educativo                     Contenido educativo.
  car_baile_imitacion               Baile, acciones o elementos que
                                  favorecen la imitación.
Codificación: 1 = característica seleccionada; 0 = no seleccionada.
10. Reconsumo del contenido
  Variable                Tipo                    Codificación / descripción
  repite_contenido      Numérica/binaria con    1 = Sí; 0 = No;
                          desconocido             NA = el cuidador no pudo identificarlo.
El reconsumo indica que el niño vuelve a ver un contenido. No debe
confundirse con repeticion de la base de videos, que describe
repetición interna dentro de la estructura de un video.
11. Normalización del contenido preferido
  Variable                     Tipo                    Descripción
  contenido_preferido_norm   Texto                   Versión normalizada del texto
                                                       abierto de
                                                       contenido_preferido, utilizada
                                                       para búsqueda y clasificación.
  contenido_identificado     Binaria                 Indica si se identificó al menos
                                                       un contenido específico
                                                       estandarizado.
  tipo_respuesta_contenido   Categórica              Clasifica la respuesta como
                                                       especifico_identificado,
                                                       descripcion_no_estandarizada o
                                                   sin_respuesta.
11.1 Indicadores de contenidos específicos
Cada variable cont_* es un indicador binario:
1 = contenido identificado en la respuesta; 0 = no identificado.
  Variable                    Contenido
  cont_plim_plim            Plim Plim
  cont_bluey                Bluey
  cont_bebefinn             Bebefinn
  cont_blippi               Blippi
  cont_luli_pampin          Luli Pampín
  cont_peppa_pig            Peppa Pig
  cont_paw_patrol           Paw Patrol
  cont_mickey_mouse         Mickey Mouse
  cont_vaca_lola            La Vaca Lola
  cont_abejita_chiquitita   Abejita Chiquitita
  cont_diana_roma           Diana y Roma
  cont_masha_oso            Masha y el Oso
  cont_baby_shark           Baby Shark
  cont_spiderman            Spider-Man
  cont_roblox               Roblox
  cont_dora                 Dora
  cont_rayo_mcqueen         Rayo McQueen
  cont_mono_silabo          Mono Sílabo
  cont_mundo_luna           Mundo de Luna
  cont_sheriff_labrador     Sheriff Labrador
  cont_aprende_isa          Aprende con Isa
  cont_bajo_terra           Bajo Terra
  cont_bob_esponja          Bob Esponja
  cont_hello_kitty          Hello Kitty
  cont_disney               Disney
  cont_baile_gorila         Baile del Gorila
  cont_loro_pepe            Loro Pepe
  cont_godzilla             Godzilla
  cont_granja_zenon         Granja de Zenón
  cont_lechuza              La Lechuza
  cont_super_libro          Súper Libro
  cont_tom_jerry            Tom y Jerry
  cont_chavo_8              Chavo del 8
  cont_zoboomafoo           Zoboomafoo
Una respuesta abierta puede activar más de un indicador cuando
corresponda.
12. Codificación temática del motivo de preferencia
  Variable                    Tipo                    Descripción
  motivo_preferencia_norm   Texto                   Versión normalizada de la
                                                      respuesta abierta sobre el
                                                      motivo de preferencia.
  motivo_identificado       Binaria                 Indica si se identificó al menos
                                                      uno de los temas definidos.
  tipo_motivo               Categórica              Clasifica la respuesta como
                                                      motivo_tematico_identificado u
                                                  otro_o_no_clasificable.
Indicadores temáticos:
  Variable                  Tema
  mot_musica              Música
  mot_movimiento          Movimiento
  mot_visual              Elementos visuales
  mot_animales            Animales
  mot_aprendizaje         Aprendizaje
  mot_entretenimiento     Entretenimiento
  mot_repeticion          Repetición
  mot_interaccion         Interacción
  mot_historia_aventura   Historia o aventura
  mot_identificacion      Identificación con personajes/situaciones
  mot_vehiculos           Vehículos
  mot_sonidos             Sonidos
Los indicadores temáticos son binarios (0/1) y una misma respuesta
puede pertenecer a más de un tema.
13. Convenciones generales de interpretación
Variables binarias
Cuando no se indique otra cosa:
- 1 = característica, opción o categoría identificada.
- 0 = característica, opción o categoría no identificada.
Valores faltantes
NA no debe interpretarse automáticamente como error. Dependiendo de la
variable puede representar:
- información no disponible;
- respuesta no aplicable;
- imposibilidad del cuidador para identificar una respuesta;
- o un valor faltante conservado intencionalmente.
Preguntas de selección múltiple
En las variables derivadas de preguntas multirrespuesta, una persona
puede activar varios indicadores simultáneamente. Por tanto, las
frecuencias o porcentajes de las categorías pueden sumar más de 100 %.
14. Consideraciones metodológicas
1. El análisis de YouTube corresponde a un piloto exploratorio de 15
   videos; 12 son videos individuales y 3 compilaciones.
2. vistas_dia es un promedio histórico acumulado y no una medida de
   velocidad reciente.
3. Las comparaciones de rendimiento de videos son descriptivas y pueden
   estar confundidas por antigüedad, canal, formato, duración y otras
   características.
4. Debido al tamaño reducido del piloto y a categorías poco frecuentes,
   no se utilizan los resultados para establecer causalidad.
5. La encuesta contiene 114 respuestas obtenidas mediante muestreo de
   conveniencia/no probabilístico.
6. Las respuestas de cuidadores describen comportamientos y
   preferencias observados o percibidos por ellos.
7. Que un niño vea determinado contenido no implica necesariamente que
   ese contenido represente una preferencia autónoma, ya que existe
   mediación del cuidador en la selección.
8. Las categorías provenientes de preguntas cerradas y las categorías
   construidas a partir de texto abierto no deben considerarse
   mediciones idénticas.
9. Se conserva la separación entre información original y variables
   derivadas para mantener trazabilidad y reproducibilidad.
10. Los resultados del proyecto deben interpretarse como descriptivos
    y exploratorios, no como evidencia causal ni como estimaciones
    representativas de toda la población infantil.
15. Archivos relacionados
Scripts principales:
- 01_importar_datos.R / script histórico de importación y
  construcción de la base de videos.
- 02_analisis_piloto.R --- análisis exploratorio de los videos.
- 03_analisis_encuesta.R --- limpieza, codificación y análisis de la
  encuesta.
Bases:
- data/raw/videos_piloto.xlsx
- data/processed/videos_piloto.csv
- data/raw/encuesta_familia.csv
- data/processed/encuesta_familia_limpia.csv
Resultados:
- resultados/videos_individuales_analisis.csv
- resultados/mediana_por_forma_contenido.csv
- tablas y gráficos derivados de la encuesta almacenados en
  resultados/.
Estado del documento: diccionario correspondiente a la versión
actual del proyecto. Las equivalencias numéricas de las variables de
codificación manual de videos que no están definidas explícitamente en
los scripts disponibles quedan pendientes de documentación y no se
infieren retrospectivamente.

