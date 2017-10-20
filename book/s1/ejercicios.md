# Ejercicios de Swift Básico
# Miniproyecto: Juego de las Siete y Media, parte I


En esta sesión vamos a implementar el modelo para un juego cartas de las siete y media, que terminaremos en las últimas sesiones de la asignatura. Por el momento no vamos a tener interfaz, solo la lógica más básica y las estructuras de datos.

A continuación se da la lista de clases y *enums* a crear. **Debéis respetar lo máximo posible los nombres de propiedades y métodos**

> NOTA: el ejercicio está pensado para las cartas de la *baraja española*. Para los que no la conozcáis: hay 4 "palos" (bastos, copas, espadas y oros) y de cada palo hay 10 cartas, que son del 1 al 7 y del 10 al 12, ya que el 8 y 9 no se usan. El 1 se llama "as" igual que en la baraja francesa, el 10 es la sota (en la baraja francesa/inglesa es la J), el es 11 el caballo (Q o dama en la inglesa) y el 12 el rey.

## Enumerado `Palo`

Un `enum` para representar los cuatro palos de la baraja. Haz que sea internamente un `String` (`: String`), así su propiedad `.rawValue` será una cadena y podrás mostrar el nombre del palo

## clase `Carta`

- Propiedades: `valor` entero y  `palo`, de tipo `Palo`
- Métodos
    + Inicializador: se le pasa un valor y un palo. Podría fallar si el `valor` que se le pasa no es correcto. Esto es lo que se llama en Swift un [*failable initializer*](https://developer.apple.com/swift/blog/?id=17), que devuelve un opcional, ya que podría ser `nil`. Para definirlo, poner `init?` en lugar de `init` y en caso de error devolver `nil` (si no hay error no es necesario devolver nada). Recordad que **el 8 y el 9 no se usan** y que evidentemente no valen cartas menores que 1 ni mayores que 12.
    + `descripcion`: devuelve un `String` con el nombre de la carta: `el 1 de oros`, `el 10 de bastos`,...
  
## Clase `Mano`

un conjunto de cartas

- Propiedades almacenadas: `cartas`, un array de `Carta`
- Propiedades computadas: `tamaño`, la longitud del array (su propiedad `count`)
- Métodos:
    + El inicializador de la clase debe inicializar `cartas` como un array vacío (también lo podéis hacer al definir la propiedad)
    + `addCarta`: se le pasa una carta y la añade a la mano
    + `getCarta`: se le pasa una posición (empezando por 0) y devuelve la carta como un opcional. Si es menor que 0 o mayor o igual que el tamaño, debería devolver `nil`


## Programa principal

Como "programa principal" para probar las clases anteriores puedes ejecutar este código

```swift
var mano = Mano()
mano.addCarta(Carta(1, .oros))
mano.addCarta(Carta(10, .espadas))
mano.addCarta(Carta(7, .copas))
print("Hay \(mano.tamaño) cartas")
for num in 0..<mano.tamaño {
    if let carta = mano.getCarta(pos:num) {
        print(carta.descripcion)
    }
}
```

Si todo es correcto deberían aparecer en pantalla las tres cartas añadidas a la mano.

## Anexo: opciones para escribir y probar el código de este ejercicio

- **Opción 1**: con el compilador de Swift en línea de comandos:
    + Usando el editor de texto que prefieras, escribe el código del enumerado `Palo` las clases `Carta`, `Baraja` y `Mano` y la extensión de `Array`. Puedes guardar por ejemplo cada clase en un archivo `.swift` distinto, aunque en Swift no hay reglas sobre qué clases debe contener cada archivo
    + Guarda el programa principal en un archivo `main.swift`
    + Para compilar, abre una terminal, ve al directorio donde estén los archivos y escribe `swiftc *.swift`. Esto compilará todos los archivos Swift y generará un ejecutable `main`
    + Puedes ejecutar el programa escribiendo en la terminal `./main`
- **Opción 2**: en un *playground* de Xcode:
    + Abre el programa Xcode, y crea un nuevo *playground* con `File > New >Playground`. Escribe aquí el código de todas las clases juntas, y también del programa principal. 
    + Como irás viendo, el *playground* se está compilando y ejecutando constantemente a medida que vas escribiendo código, pero si quieres forzar la ejecución puedes ir a `Editor > Execute playground`. Lo puedes usar una vez terminado todo, para ejecutar varias veces el programa principal.
- **Opción 3**: en algún entorno *online* de programación en Swift, como por ejemplo el ["Swift Sandbox"](https://swift.sandbox.bluemix.net/#/repl) de IBM. Esto te puede ser útil si no tienes un Mac disponible o no puedes instalar el compilador en línea de comandos en tu sistema. Eso sí, tendrás que escribir todo el código junto al igual que lo haces en un *playground*

>NOTA: estas alternativas las podemos usar porque de momento todavía no estamos haciendo aplicaciones con interfaz de usuario. A partir de la siguiente sesión sí haremos aplicaciones iOS con lo que nuestra única posibilidad va a ser trabajar en un Mac con un entorno tipo Xcode.