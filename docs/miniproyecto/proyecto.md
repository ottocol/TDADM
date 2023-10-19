# MiniProyecto de iOS (3 puntos en total)
# Juego de las siete y media 

Se propone implementar el conocido juego de cartas de "[las 7 y media](https://es.wikipedia.org/wiki/Siete_y_media)". 

Para crear el proyecto, como siempre hacemos, elige la plantilla de `App`. En la segunda pantalla del asistente dale como nombre `SieteyMedia` y asegúrate que en el interface pone `Storyboard` (como todas las apps que hemos hecho hasta ahora lo usan ya debería salir por defecto).

## Estructura de clases del modelo

Necesitáis tener implementadas todas las clases/enums que os hemos propuesto en las sesiones de Swift:

- enum `Palo`
- clase `Carta`
- clase `Mano`
- clase `Baraja`

Además se os proporciona la implementación de una versión simplificada del juego en la clase [`Juego`](Juego.swift) (el archivo contiene también el enumerado `EstadoJuego)`. En esta versión simplificada el usuario juega contra la máquina. La máquina no saca cartas de la baraja, sino que genera un número al azar entre 0 y 7.5, con lo que sabemos que nunca se va a pasar. En esta modalidad de juego, primero juega la máquina, aunque no aparecerá el resultado en pantalla, y luego el jugador irá pidiendo cartas hasta que decida plantarse o se pase de 7.5. Terminado el turno del jugador:

- Si el jugador se ha pasado, pierde
- Si el jugador no se ha pasado de 7.5
    + Si tiene más puntos que la máquina, gana el jugador
    + Si tiene menos, gana la máquina
    + Si tienen los mismos, empatan

Para copiar el código de todas las clases al proyecto:

1. **Crea un "grupo"**, que es como una subcarpeta del proyecto en la que puedes organizar los archivos. En Xcode, clic derecho sobre la carpeta del proyecto `SieteYMedia`, en el menú contextual, selecciona `New Group` y llámalo `modelo` (si seleccionas `New Group without folder` la carpeta aparecerá igualmente en Xcode pero no será una carpeta "física" del sistema de archivos).
2. **Añadir las clases/enums al proyecto**: Hay dos posibilidades:
    - Si tienes las clases en uno o varios archivos, puedes arrastrarlo(s) al grupo `modelo`. En el cuadro de diálogo que aparecerá asegúrate de que está marcada la casilla `Copy items if needed`, si no se incluiría una referencia al archivo original, de modo que si borras o mueves el original, se perdería la referencia.
    - Si quieres puedes ir creando los archivos dentro del grupo `modelo` con clic derecho y `New File`


## Interfaz simplificada (1 punto)

El `ViewController` debería contener una instancia de la clase `Juego`.

```swift
class ViewController : UIViewController {
    var juego : Juego!
    ...

} 
```

En esta versión muy simplificada de la interfaz solo aparecen en pantalla tres botones: "pedir carta", "plantarse" y "nueva partida", pero no se ven las cartas gráficamente. Eso sí, el juego debería funcionar correctamente, imprimiendo los mensajes con `print` en la consola

Tendrás que conectar con *action* (gráficamente) los botones del juego con funciones del *view controller* que a su vez llamen a los métodos del objeto `juego`.

- "nueva partida" debe inicializar la variable `juego` y llamar al método `turnoMaquina`
- "pedir carta" al método `jugadorPideCarta`
- "plantarse" al método `jugadorSePlanta`

> Aunque al principio solo debería poder pulsarse el botón "nueva partida" y una vez comenzada solo los otros dos, etc... de momento no nos preocuparemos de esto y dejaremos que se pueda pulsar cualquier botón, asumiendo que el usuario nunca pulsará un botón que no debería 🙄, ya que si no el resultado podria ser catastrófico.

Se sabe que el juego ha terminado cuando el estado devuelto por `jugadorPideCarta` o `jugadorSePlanta` es distinto de `.turnoJugador`. Cuando suceda esto debes imprimir el resultado del juego en la consola, dependiendo del estado puedes saber quién ha ganado.

## Interfaz completa (2 puntos)

En la interfaz completa deberían aparecer pintadas las cartas en pantalla conforme se van repartiendo. Además los botones se deberían habilitar/deshabilitar adecuadamente (por ejemplo si la partida se ha terminado no se puede pedir carta).

### Añadir las imágenes de las cartas al proyecto

Descomprime el .zip de Moodle con las imágenes de las cartas en png, selecciona todos los archivos y "déjalos caer" dentro de la carpeta de recursos (`Assets.xcassets`). 

Por cada imagen en png creará un *image set* con el nombre del archivo ( al estilo `1oros`, `3copas`, ...). Por desgracia solo disponemos de las imágenes de las cartas en baja resolución (@1x).

### Cómo dibujar las cartas

Cada vez que dibujemos en pantalla una carta estamos añadiendo a la pantalla actual un `UIImageView`. Tenemos que guardar referencias a todas las imágenes añadidas para poder borrarlas cuando acabe la partida. Definiremos esta propiedad en el *view controller* para guardarlas

```swift
//propiedad de ViewController.swift
var viewsCartas : [UIImageView] = [] 
```

**Para dibujar las cartas puedes adaptar el código de ejemplo que hemos visto esta tarde en clase**, recuerda cómo funciona: en lugar de dibujar las cartas directamente en su posición final, se hace fuera de la pantalla (es decir, con el origen del *frame* en coordenadas negativas) y luego se realiza una animación hasta su posición definitiva. 

Recuerda que las coordenadas usadas en las "views" de iOS no son pixeles físicos sino lógicos. Tienes una tabla con las resoluciones físicas y lógicas de todos los dispositivos móviles de Apple en [https://www.ios-resolution.com](https://www.ios-resolution.com). El origen de coordenadas está en la esquina superior izquierda, la coordenada `x` va hacia la derecha y la coordenada `y` hacia abajo.

Ten en cuenta que cada carta deberías dibujarla un poco más a la derecha que la anterior, para que queden en la "mesa" una al lado de la otra y no justo "encima".


### Eliminar las cartas de la pantalla

Una vez ha terminado la partida, o justo cuando comienza la siguiente, también tendrás que borrar todas las cartas de la pantalla. Vamos recorriendo el array `self.viewsCartas` del *view controller* y vamos eliminando las cartas de la pantalla:

```swift
//Quitamos las cartas de la pantalla
for v in self.viewsCartas {
    v.removeFromSuperview()
}
//ya no tenemos imágenes de cartas en pantalla, ponemos el array a vacío
self.viewsCartas=[]
```

### Adaptar los dibujos a la resolución de la pantalla (0.25 puntos ADICIONALES)

OPCIONALMENTE, en lugar de dibujar las cartas con un tamaño y unas posiciones "fijas", puedes usar un porcentaje o fracción del ancho y alto total de la pantalla. Puedes obtener el ancho y alto de la pantalla del siguiente modo:

```swift
let limitesPantalla = UIScreen.main.bounds
let anchoPantalla = limitesPantalla.width
let altoPantalla = limitesPantalla.height
```

### Cómo habilitar/deshabilitar los botones

**Cuando arranca la app, los botones de pedir carta y plantarse deberían aparecer deshabilitados, y solo habilitado el de comenzar partida.**

Para que un botón aparezca inicialmente deshabilitado, en Xcode, en el "attributes inspector" de la parte derecha de la pantalla, desmarcar la casilla `enabled` dentro de `state` (está a mitad de panel).

**Una vez comenzada la partida se deberían habilitar los botones de pedir carta y plantarse. Cuando termine se deben deshabilitar otra vez.**

Podéis habilitar/deshabilitar los botones por código poniendo su propiedad `isEnabled` a `true` o `false` respectivamente.


### Cómo mostrar mensajes al usuario

Podéis mostrar el resultado del juego ("has ganado", "te has pasado",...) con un `UIAlertController`, que hará aparecer el típico cuadro de diálogo modal. El siguiente código muestra un cuadro que pone "¡¡Has perdido!!", con el título "Fin del juego", y con un único botón de "OK" que no hace nada especial, más que quitar el cuadro de diálogo. 

```swift
let alert = UIAlertController(
    title: "Fin del juego",
    message: "¡¡Has perdido!!",
    preferredStyle: UIAlertControllerStyle.alert)
let action = UIAlertAction(
    title: "OK",
    style: UIAlertActionStyle.default)
alert.addAction(action)
self.present(alert, animated: true, completion: nil)
```