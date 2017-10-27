# MiniProyecto de iOS de Tecnologías de Desarrollo
# Juego de las siete y media

Se propone implementar el conocido juego de cartas de "las 7 y media". Podéis implementar la versión "completa" en la que el usuario juega contra la máquina, ambos sacando cartas una a una y decidiendo si plantarse o seguir, o bien una versión simplificada en la que la máquina no pide cartas sino que obtiene una puntuación generada al azar.

## Estructura de clases del modelo (1 punto) {#modelo}

Ampliaremos el modelo que implementamos en la primera sesión. Ya tenemos el enum `Palo` y las clases `Carta` y `Mano`. Vamos a añadir las clases necesarias para el juego: la `Baraja` y el propio `Juego`

## Clase `Baraja`

todas las cartas de la baraja

- Propiedades: `cartas`, un array de `Carta`
- Métodos:
    + El Inicializador debe rellenar el array de cartas con todas las cartas de la baraja
    + `repartirCarta`: obtiene la última carta de la baraja y la elimina de ella. Podéis hacer esto por ejemplo con [`popLast()`](https://developer.apple.com/reference/swift/array/1539777-poplast) 
    + `barajar`: debe cambiar al azar el orden de las cartas en el `Array`. Una forma de implementar esto es extender la clase `Array` añadiendo un método para intercambiar al azar el orden de sus componentes

```swift
extension Array {
    /// Shuffle the elements of `self` in-place.
    mutating func barajar() {
        // empty and single-element collections don't shuffle
        if count < 2 { return }

        for i in indices.dropLast() {
            let diff = distance(from: i, to: endIndex)
            let j = index(i, offsetBy: numericCast(arc4random_uniform(numericCast(diff))))
            swapAt(i, j)
        }
    }
}
```

Esta extensión está tomada de [Stackoverflow](https://stackoverflow.com/questions/37843647/shuffle-array-swift-3). Podéis usarla o bien cualquier otra implementación que encontréis.

La extensión la podéis almacenar en un fichero Swift cuyo nombre podéis elegir libremente, no hay una convención estándar.

### Clase `Juego`

La estructura es libre ya que depende de vuestra implementación. No obstante, tened en cuenta que vais a necesitar métodos para:

- Sumar las cartas que hay en una mano, teniendo en cuenta que el 10,11 y 12 valen medio punto, y el resto su valor
- Que el jugador pida una carta
- Que el jugador se plante
- acabar el juego y calcular el resultado
- ...

##Pruebas unitarias (0,5 puntos) {#pruebas}

Debéis implementar al menos las siguientes pruebas unitarias:

- Que al inicializar una `Carta`  tanto el palo como el valor se han guardado correctamente (por ejemplo que al inicializar una carta como el 3 de copas si después obtenemos la propiedad `valor` nos da 3 y la propiedad `palo` nos da `copas`).
- Que cuando se reparte una carta de la `Baraja` se ha eliminado de ella y el número de cartas de la baraja ha disminuido en 1

##Interfaz gráfico simplificado (0,5 puntos) {#interfaz_simplificado}

> Es normal que el `ViewController` conozca al modelo (o sea, que defináis una variable de tipo `Juego` dentro del código del `ViewController`). Pero no es aconsejable que también pase al revés. En el modelo no se debería guardar ninguna referencia al *controller*, para poder reutilizarlo independientemente de la interfaz gráfica. El *controller* puede enterarse de que ha pasado algo "interesante" (por ejemplo que se acaba el juego) a través de notificaciones. O podría observar con KVO cuándo cambia una propiedad del juego que sea el `estado` (turno usuario, turno máquina, gana usuario, gana máquina, ...).

En esta versión muy simplificada de la interfaz solo aparecen en pantalla tres botones: "pedir carta", "plantarse" y "nueva partida", pero no se ven las cartas gráficamente. Eso sí, el juego debería funcionar correctamente, imprimiendo los mensajes con `print`.

> En esta versión simplificada no es necesario habilitar/deshabilitar los botones según la situación del juego (por ejemplo no hace falta deshabilitar "pedir carta" cuando la partida se ha terminado). No pasa nada si pulsar los botones de forma inconsistente da errores, ya que luego los deshabilitaremos.

Además, para simplificar la mecánica del juego no es necesario que la máquina "saque cartas de verdad". Basta con generar una puntuación al azar e informar al usuario de la puntuación que ha sacado. Para que el juego tenga sentido así primero debería jugar el jugador humano y luego la máquina.

> **La versión anterior es solo una idea, podéis implementar cualquier variante que queráis**, o cualquier mejora, incluyendo que la máquina saque cartas una por una, apostar una cantidad,...


##Completar la interfaz (1 punto) {#interfaz_completo}

En la interfaz completada deberían aparecer las cartas en pantalla conforme se van repartiendo. Además los botones se deberían habilitar/deshabilitar adecuadamente (por ejemplo si la partida se ha terminado no se puede pedir carta).

###Cómo dibujar las cartas

En lugar de dibujar las cartas directamente en su posición, podemos hacerlo fuera de la pantalla (es decir, con el origen del *frame* en coordenadas negativas) y luego hacer una animación hasta su posición definitiva. La siguiente función dibuja una carta con el efecto descrito. La `posicion` es el orden de la carta, para que se vayan colocando una al lado de la otra: 1, 2...

En el código de ejemplo usamos un tamaño de carta fijo de 70x100 puntos, en el apartado siguiente se te propone adaptarlo al tamaño real de la pantalla.

> Nótese que hablamos de puntos y no de pixeles ya que en código no se usa la resolución física sino una resolución "lógica". Hay dispositivos que tienen distinta resolución física pero usan la misma resolución lógica, lo que simplifica el desarrollo. Podéis ver una tabla con resoluciones físicas y lógicas de distintos dispositivos iOS en [http://iosres.com](http://iosres.com) 

```swift
func repartirCarta(carta: Carta, enPosicion : Int) {
    let nombreImagen = String(carta.valor)+String(carta.palo.rawValue)
    //creamos un objeto imagen
    let imagenCarta = UIImage(named: nombreImagen)
    //para que la imagen sea un componente más del UI,
    //la encapsulamos en un UIImageView
    let cartaView = UIImageView(image: imagenCarta)
    //Inicialmente la colocamos fuera de la pantalla y más grande
    //para que parezca más cercana
    //"frame" son los límites de la vista, definen pos y tamaño
    cartaView.frame = CGRect(x: -200, y: -200, width: 200, height: 300)
    //La rotamos, para que al "repartirla" haga un efecto de giro
    cartaView.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi));
    //La añadimos a la vista principal, si no no sería visible
    self.view.addSubview(cartaView)
    //guardamos la pista en el array, para luego poder eliminarla
    self.vistasCartas.append(cartaView)
    //Animación de repartir carta
    UIView.animate(withDuration: 0.5){
        //"efecto caida": la llevamos a la posición final
        cartaView.frame = CGRect(x:50+70*(enPosicion-1), y:100, width:70, height:100);
        //0 como ángulo "destino", para que rote mientras "cae"
        cartaView.transform = CGAffineTransform(rotationAngle:0);
    }
}
```

### Adaptar los dibujos a la resolución de la pantalla (0,5 puntos)

OPCIONALMENTE, en lugar de dibujar las cartas con un tamaño y unas posiciones "fijas", puedes usar un porcentaje o fracción del ancho y alto total de la pantalla. Puedes obtener el ancho y alto de la pantalla del siguiente modo:

```swift
let limitesPantalla = UIScreen.main.bounds
let anchoPantalla = limitesPantalla.width
let altoPantalla = limitesPantalla.height
```

###Cómo manipular los botones

- Podéis habilitar/deshabilitar los botones por código poniendo su propiedad `isEnabled` a `true` o false respectivamente.
- Para que un botón aparezca inicialmente deshabilitado, en el "attributes inspector" de la parte derecha de Xcode desmarcar la casilla `enabled` dentro de `state` (está a mitad de panel)
- Para que se vea gráficamente que un botón está deshabilitado podéis ponerle un color distinto según el estado. Teniendo seleccionado el botón, en el `Attributes inspector` de la parte derecha de la pantalla, seleccionar el estado que nos interese en el desplegable. Al elegir colores (*text*, *shadow*, ...) serán los fijados para ese estado. 

![](estilos_boton.png)

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


##Posibles mejoras (hasta 1 punto) {#mejoras}

El proyecto está abierto a cualquier posible mejora o modificación que queráis hacer, por ejemplo:

- Contabilizar y mostrar las partidas ganadas/perdidas (0,25)
- Que se pueda apostar una cantidad y vaya contabilizando la cantidad  hasta el momento (0,5)
- Que la máquina también vaya sacando cartas (1)
- ...
