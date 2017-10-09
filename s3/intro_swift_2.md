
# Introducción a Swift, parte 2

## Clausuras

Una clausura es un bloque de **código** que puede ser tratado como un **objeto**. Es algo así como una *función anónima* con una sintaxis simplificada.

A muchos métodos de las bibliotecas del sistema se les pasa una función para hacer su tarea. En lugar de eso se puede usar una clausura, lo que simplifica la sintaxis. Veamos un ejemplo.

El método `sorted` ordena un array. Debemos pasarle una función que, dados dos datos, devuelva `true` si están ya "en el orden correcto". Podemos hacerlo así:

```swift
func ascendente(a:String, b:String)->Bool {
    return a<b;
}

let nombres = ["James","Billy","D'Arcy","Jimmy"]
let ord = nombres.sorted(by:ascendente)
``` 

La función `ascendente` se puede definir en forma de clausura como:

```swift
(a:String,b:String)->Bool in return a<b}
```

Con clausuras definimos el código *donde lo necesitamos*, no aparte, quedando más legible

```swift
let nombres = ["James", "Billy", "D'Arcy", "Jimmy" ]
let ord = nombres.sorted(by: {(a:String,b:String)->Bool in return a<b})
ord
```

### Simplificando la definición

Podemos acortar todavía más la sintaxis de definición de las clausuras:

- *Inferencia de tipos*: en ocasiones el compilador puede inferir la signatura (tipos de parámetros y tipo de retorno), como en nuestro ejemplo, ya que a `sorted` se le debe pasar una función con dos parámetros `String` y que debe devolver un `Bool`. También podemos omitir los paréntesis y la flecha

```swift
let nombres = ["Pepe", "Eva", "Luis"]
print(nombres.sorted(by: {a,b in return a<b}))
```

- *`return` implícito*: si la clausura solo contiene una expresión se asume que devuelve su resultado

```swift
let nombres = ["Pepe", "Eva", "Luis"]
print(nombres.sorted(by: {a,b in a<b}))
```

- **Parámetros por defecto** por defecto los parámetros reciben como nombre `$i` donde `i` es el número (empieza en 0)

```swift
let nombres = ["Pepe", "Eva", "Luis"]
let ord = nombres.sorted(by: {$0<$1})
```

**Trailing closures**: si una clausura es el último parámetro de un método, se puede omitir su nombre y poner fuera de los paréntesis. Esto de por sí no acorta la sintaxis, pero facilita la legibilidad si el código de la clausura ocupa varias líneas

```swift
let nombres = ["Pepe", "Eva", "Luis"]
let ord = nombres.sorted() {
    a,b in
    return a<b
}
```

## Estructuras vs objetos

En Swift también existen `struct`s.

En lenguajes como C++, clases y `structs` son completamente diferentes. En swift se parecen mucho:

- Ambas pueden contener **propiedades** y **métodos**
- Definen **inicializadores** (== *constructores*)
- Se instancian de forma muy parecida
- Se definen como **conformes a protocolos** (parecidos a *interfaces* de Java)

Sin embargo, hay funcionalidades que tienen las clases pero no las estructuras:

- Herencia
- **Deinicializadores** (== destructores)
- Varias variables pueden referenciar a la misma instancia

## Gestión de errores

## Genéricos

## Protocolos
patrón delegate