
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

## Estructuras

En Swift también existen `struct`s.

En lenguajes como C++, clases y `structs` son completamente diferentes. En swift se parecen mucho:

- Ambas pueden contener **propiedades** y **métodos**
- Definen **inicializadores** (== *constructores*)
- Se instancian de forma muy parecida
- Se pueden definir como **conformes a protocolos** (parecidos a *interfaces* de Java)

```swift
struct Punto2D {
    var x,y : Double
    var descripcion : String {
        return "(\(x),\(y))"
    }
}

var p1 = Punto2D(x: 1.0, y: 0.0)
print(p1.descripcion)
```

Como vemos, en el código anterior no hemos definido ningún inicializador y sin embargo lo hemos llamado para construir un `Libro`. En *structs* el compilador define automáticamente un inicializador (llamado *memberwise initializer*) que acepta las variables miembro como parámetros. 

Sin embargo, hay funcionalidades que tienen las clases pero no las estructuras:

- Herencia
- **Deinicializadores** (== destructores)
- Varias variables pueden referenciar a la misma instancia. Es decir, como ahora veremos, los objetos se pasan por referencia y las estructuras por valor.

### Valor vs. referencia

Las estructuras se pasan por valor y los objetos por referencia. Eso quiere decir que si asignamos una estructura a otra variable o la pasamos como parámetro de una función estamos *haciendo una copia*, pero si asignamos objetos, son punteros que apuntan en realidad *al mismo objeto*.

Por ejemplo con estructuras

```swift
struct Punto2D {
    var x,y : Double
    var descripcion : String {
        return "(\(x),\(y))"
    }
}

var p1 = Punto2D(x: 1.0, y: 0.0)
var p2 = p1
print(p1==p2)
p1.x = -1.0;
print(p2.descripcion)  //cambiar p1 no cambia el valor de p2
```

Si  `Punto2D` pasara de ser una estructura a una clase, pasarían dos cosas:

- Ya no tendríamos automáticamente definido el *memberwise initializer*
- Al asignar o pasar como parámetro estaríamos referenciando *la misma instancia*.

```swift
class Punto2D {
    var x,y : Double
    var descripcion : String {
        return "(\(x),\(y))"
    }
}

var p1 = Punto2D()
p1.x = 1
p1.y = 0
var p2 = p1            //ahora p1 y p2 apuntan A LA MISMA INSTANCIA
p1.x = -1.0;
print(p2.descripcion)  //(-1.0, 0.0) 
```

### Escoger estructuras vs. clases

Se recomienda usar estructuras cuando se cumplan estas condiciones:

- La finalidad principal es simplemente encapsular unos cuantos datos
- La copia por valor no va a causar problemas 
- Las propiedades de la estructura son también valores y no referencias (o sea, la estructura no contiene objetos)
- No necesitamos herencia

En Swift, **muchos tipos de la librería estándar como los `String`, los *arrays* y los *diccionarios* se implementan como estructuras**, de modo que se pasan por valor y no por referencia. 

## Gestión de errores


## Genéricos

## Protocolos
patrón delegate