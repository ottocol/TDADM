# Ejercicios de Swift parte II (2 puntos)


## Gestión de errores en Swift (1 punto)

Implementa una función `chequearPassword` que chequee si una cadena tiene las condiciones necesarias para ser una contraseña, en nuestro caso:

- Tiene una longitud mínima de 8 caracteres
- Contiene al menos un carácter en máyúscula y uno en minúscula

Condiciones de implementación:

- Crea un tipo `ErrorPassword` para representar el error con sus dos casos, lo más sencillo es que sea un enumerado, recuerda que debe ser declarado conforme al protocolo Error (`: Error`)
- Implementa la función `chequearPassword(_ password:String)` que en caso de no cumplir alguna condición lance el error apropiado, en caso de cumplirlas todas devuelva `true` (evidentemente no puede lanzar los dos errores, que lance el primero que encuentre).

**Pistas:** puedes iterar por los caracteres de una cadena con un bucle `for caracter in cadena`. Si un carácter es mayúscula, su propiedad `isUppercase` será `true`, y si es minúscula, lo mismo con su propiedad  `isLowercase`.

Prueba a llamar a la función `chequearPassword` con uno que no cumpla alguna o las dos condiciones. Asegúrate de capturar la excepción con un `do...catch` y imprimir un mensaje de error apropiado en cada caso.

## Continuación del juego de cartas (1 punto)

> Aclaración: las "Siete y media" es la versión española del conocido juego del "21" o Blackjack. Los jugadores por turno van pidiendo cartas y el objetivo es que sumen lo más cerca posible de 7.5 sin pasarse. Las cartas del 1 al 7 suman su valor mientras que las figuras (sota, caballo y rey) suman medio punto. En su turno un jugador irá pidiendo cartas hasta que se plante o se pase de 7.5.

Para poder implementar el juego de las siete y media en la siguiente sesión presencial necesitamos, además de las clases que pedíamos en la primera sesión de Swift, la clase adicional `Baraja`

### Clase `Baraja`

Representa a todas las cartas de la baraja. Del 1 al 12 de los cuatro palos, menos 8 y 9.

#### Propiedades

`cartas`, un array de objetos `Carta`

#### Métodos

+ El `init()` debe rellenar el array de cartas con todas las cartas de la baraja. Podéis ir generando todos los números de todos los palos con un bucle doble de este estilo:

```swift
for palo in [Palo.bastos, Palo.espadas, Palo.copas, Palo.oros] {
    for valor in 1...12 {
        if valor != 8 && valor != 9 {  //El 8 y el 9 no se suelen usar
            //Aquí crearíais la nueva carta y la añadiríais al array "cartas"
        }
    }
}
```

+ `repartirCarta()`: devuelve la última carta de la baraja y la elimina de ella. Es lo que hace exactamente el método de la clase Array [`popLast()`](https://developer.apple.com/reference/swift/array/1539777-poplast), devolver el último valor de un array y eliminarlo de él. 
+ `barajar()`: debe cambiar al azar el orden de las cartas en el `Array`. Esto lo hace directamente el método `shuffle()` del `Array`.




