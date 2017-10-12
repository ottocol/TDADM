## Ejercicios de Swift Básico
## Miniproyecto: Juego de las Siete y Media, parte I


En esta sesión vamos a implementar el modelo para un juego cartas de las siete y media, que terminaremos en las últimas sesiones de la asignatura. Por el momento no vamos a tener interfaz, solo la lógica más básica y las estructuras de datos.

A continuación se da la lista de clases y *enums* a crear. **Debéis respetar lo máximo posible los nombres de propiedades y métodos**

> NOTA: el ejercicio está pensado para las cartas de la *baraja española*. Para los que no la conozcáis: hay 4 "palos" (bastos, copas, espadas y oros) y de cada palo hay 10 cartas, que son del 1 al 7 y del 10 al 12, ya que el 8 y 9 no se usan. El 1 se llama "as" igual que en la baraja francesa, el 10 es la sota (en la baraja francesa/inglesa es la J), el es 11 el caballo (Q o dama en la inglesa) y el 12 el rey.

### enum `Palo`

Un `enum` para representar los cuatro palos de la baraja. Haz que sea internamente un `String` (`: String`), así su propiedad `.rawValue` será una cadena y podrás mostrar el nombre del palo

### clase `Carta`

- Propiedades: `valor` entero y  `palo`, de tipo `Palo`
- Métodos
    + Inicializador: se le pasa un valor y un palo. Podría fallar si el `valor` que se le pasa no es correcto. Esto es lo que se llama en Swift un [*failable initializer*](https://developer.apple.com/swift/blog/?id=17), que devuelve un opcional, ya que podría ser `nil`. Para definirlo, poner `init?` en lugar de `init` y en caso de error devolver `nil` (si no hay error no es necesario devolver nada). Recordad que **el 8 y el 9 no se usan** y que evidentemente no valen cartas menores que 1 ni mayores que 12.
    + `descripcion`: devuelve un `String` con el nombre de la carta: `el 1 de oros`, `el 10 de bastos`,...
  
### Clase `Mano`

un conjunto de cartas

- Propiedades: `cartas`, un array de `Carta`
- Métodos:
    + El inicializador de la clase debe inicializar `cartas` como un array vacío (también lo podéis hacer al definir la propiedad)
    + `addCarta`: se le pasa una carta y la añade a la mano

### Clase `Baraja`

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


