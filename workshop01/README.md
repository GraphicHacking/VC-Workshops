# Análisis de imagen por software - GraphicHacking

## Propósito

Descargar el repositorio desde Github, rama MASTER.
Distribuciones recientes de Linux que emplean gstreamer >=1, requieren alguna de las siguientes librerías de video:
1. Beta oficial.
2. Gohai port.
Descompriman el archivo *.zip en la caperta de libraries de su sketchbook (e.g., $HOME/sketchbook/libraries) y probar cuál de las dos va mejor.

Buscar en la carpeta workshop01, donde encontrará:
* Workshop1_img:
En la parte superior izquierda se podrá encontrar la imágen original. Al hacer click sobre la imagen superior central, 
se podrá alternar entre todos los filtros disponibles. Al hacer click sobre la imagen
superior izquierda, se podrá alternar entre las diferentes escalas de grises. En la parte inferior se podrá seleccionar
el rango de pixeles de interés, los cuales se dibujarán sobre la imagen en
 escala de grises, dejando lo que esté por fuera del rango en negro.
Con un click se selecciona un límite del rango, con un segundo click se selecciona el otro límite y con un tercer click se
elimina la selección de rango. 
* Workshop1_vid
En la parte izquierda se encuentra un video en tiempo real tomado por la cámada del dispositivo; en la derecha, el mismo video filtrado
con los diferentes filtros disponibles, los cuales se pueden alternar haciendo click en cualquier parte del canvas. 
En la parte inferior se podrá er el frame rate del canvas. 
Correr los ejemplos allí ubicados.
## Fuentes

## Integrantes

Participantes de GraphicHacking

| Integrante | github nick |
|------------|-------------|
|Juan Sebastian Chaves     |      jschavesr       |
|Laura Santos Guerrero | lsfinite |
|Juan Camilo Rodriguez | Juankmilo97 |

## Discusión

Para la realización del taller se aplicaron los siguientes filtros tanto a una misma imagen estática como a un video:
* Escala de grises: promedio RGB y luma. 
* Edge
* Emboss
* Sharpen
Se llegan a las siguientes conclusiones:
* Mediante sencillas operaciones aritméticas, aplicadas a la matríz de pixeles de una imágen,
 se puede llegar a obtener información útil de esta.
* En la escala de grises, el promedio RGB da valores más homogéneos entre sí, mientras que aplicando luma, los valores 
tienden a tener más diferencia entre sí, generando mayores picos y bajadas.
Suponemos esto es con la intensión de resaltar más las iluminaciones y generar más contraste con los tonos oscuros. 
* El histograma revela que la mayoría de pixeles se encuentran en la zona media, es decir, que la mayoría de pixeles, 
en escala de grises, se encuentran entre 128 y 191.
* El mayor frame rate se dio al aplicar los filtros en escalas de grises (57-60 aprox), mientras que los más bajos se dieron utilizando los 
filtros de emboss y edge (35-40 aprox); Suponemos esto sucede ya que, en los filtros de emboss, sharpen y edge, al requerir más 
operaciones computacionales, los frames se generan a una menor velocidad ( ambos requieren operaciones matriciales), mientras
que las escalas de grises pueden generar más frames al tener menor cantidad de operaciones computacionales. 



















