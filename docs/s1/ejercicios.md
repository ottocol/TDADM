# Ejercicios adicionales de Swift Básico (1.5 puntos)


En esta sesión vamos a implementar las clases básicas necesarias para un juego de cartas, que terminaremos en las últimas sesiones de la asignatura. Por el momento no vamos a tener interfaz, solo la lógica más básica y las estructuras de datos.

A continuación se da la lista de clases y *enums* a crear. **Debéis respetar lo máximo posible los nombres de propiedades y métodos**

> NOTA: el ejercicio está pensado para las cartas de la *baraja española*. Para los que no la conozcáis: hay 4 "palos": bastos, copas, espadas y oros, en lugar de los diamantes,corazones,tréboles y picas de la baraja francesa. De cada palo hay 12 cartas, que son del 1 al 12, aunque el 8 y 9 no se suelen usar en la mayoría de juegos. El 1 también se llama "as" igual que en la baraja francesa, el 10 es la *sota* (en la baraja francesa es la J), el es 11 el *caballo* (Q o dama en la francesa) y el 12 el *rey*. Si queréis más información podéis ver las cartas [aquí](http://www.salonhogar.net/Enciclopedia/Baraja_espanola/Indice.htm).

## Enumerado `Palo` (0,25 puntos)

Un `enum` para representar los cuatro palos de la baraja. Recuerda que son bastos, copas, espadas y oros. Haz que sea internamente un `String` (`: String`), así su propiedad `.rawValue` será una cadena y podrás mostrar el nombre del palo

## clase `Carta` (0,5 puntos)

- Propiedades: `valor` entero y  `palo`, de tipo `Palo`
- Métodos
    + Inicializador: se le pasa un valor y un palo. Podría fallar si el `valor` que se le pasa no es correcto (recordad que **el 8 y el 9 no se usan** y que evidentemente no valen cartas menores que 1 ni mayores que 12). Por tanto necesitamos un *failable initializer*.
    + `descripcion`: debe devolver un `String` con el nombre de la carta: `el 1 de oros`, `el 10 de bastos`,...
  
## Clase `Mano` (0,75 puntos)

un conjunto de cartas

- Propiedades almacenadas: `cartas`, un array de `Carta`
- Propiedades computadas: `tamaño`, la longitud del array (su propiedad `count`)
- Métodos:
    + El inicializador de la clase debe inicializar `cartas` como un array vacío (también lo podéis hacer al definir la propiedad)
    + `addCarta`: se le pasa una carta y la añade a la mano
    + `getCarta`: se le pasa una posición (empezando por 0) y devuelve la carta como un opcional. Si la posición es menor que 0 o mayor o igual que el tamaño, debería devolver `nil`


## Programa principal

Como "programa principal" para probar las clases anteriores puedes ejecutar este código

```swift
var mano = Mano()
mano.addCarta(Carta(1, .oros)!)
mano.addCarta(Carta(10, .espadas)!)
mano.addCarta(Carta(7, .copas)!)
print("Hay \(mano.tamaño) cartas")
for num in 0..<mano.tamaño {
    if let carta = mano.getCarta(pos:num) {
        print(carta.descripcion())
    }
}
```

Si todo es correcto deberían aparecer en pantalla las tres cartas añadidas a la mano.

## Anexo: opciones para escribir y probar el código de este ejercicio

- **Opción 1**: en un *playground* de Xcode:
    + Abre el programa Xcode, y crea un nuevo *playground* con `File > New >Playground`. Escribe aquí el código de todas las clases juntas, y también del programa principal. 
    + Como irás viendo, el *playground* se está compilando y ejecutando constantemente a medida que vas escribiendo código, pero si quieres forzar la ejecución puedes ir a `Editor > Execute playground`. Lo puedes usar una vez terminado todo, para ejecutar varias veces el programa principal.
- **Opción 2**: en algún entorno *online* de programación en Swift, como por ejemplo en [Repl.it](https://repl.it/languages/swift
). Esto te puede ser útil si no tienes un Mac disponible o no puedes instalar el compilador en línea de comandos en tu sistema. Eso sí, tendrás que escribir todo el código junto al igual que lo haces en un *playground*.
- **Opción 3**: con el compilador de Swift en línea de comandos:
    + Usando el editor de texto que prefieras, escribe el código del enumerado `Palo` las clases `Carta`, `Baraja` y `Mano` y la extensión de `Array`. Puedes guardar por ejemplo cada clase en un archivo `.swift` distinto, aunque en Swift no hay reglas sobre qué clases debe contener cada archivo.
    + Guarda el programa principal en un archivo `main.swift`
    + Para compilar, abre una terminal, ve al directorio donde estén los archivos y escribe `swiftc *.swift`. Esto compilará todos los archivos Swift y generará un ejecutable `main`
    + Puedes ejecutar el programa escribiendo en la terminal `./main`

>NOTA: estas alternativas las podemos usar porque de momento todavía no estamos haciendo aplicaciones con interfaz de usuario. A partir de la siguiente sesión sí haremos aplicaciones iOS con lo que nuestra única posibilidad va a ser trabajar en un Mac con un entorno tipo Xcode.