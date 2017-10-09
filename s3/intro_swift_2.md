
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

En Swift representamos un error con cualquier elemento que sea conforme al protocolo `Error`. Los `enums` son especialmente apropiados para representar errores

```swift
enum ErrorImpresora : Error {
    case sinPapel
    case sinTinta(color: String)
    case enLLamas
}
```

NOTA: ya veremos qué son los protocolos, por el momento basta con saber que son como los *interfaces* en Java

Para señalar que se ha producido un error, lo lanzamos con `throw`

```swift
throw ErrorImpresora.sinTinta(color: "Rojo")
```

Ante un error tenemos cuatro opciones:

- Propagarlo "hacia arriba"
- Capturarlo con un `do..catch`
- Manejarlo como un opcional
- Suponer que todo va a ir bien

### Propagar errores

Podemos indicar que una función/método lanza errores marcándola con `throws`. El error llegará a la función/método que haya llamado a esta, que a su vez podría propagarlo hacia arriba.

Nótese que si llamamos a un método marcado con `throws` debemos preceder la llamada de la palabra clave `try`

Veamos un ejemplo, suponiendo el `enum ErrorImpresora` definido antes

```swift
class Impresora {
    var temperatura=0.0
    //Marcado con "throws" porque lanza un error "hacia arriba"
    func verificarEstado() throws -> String {
        if self.temperatura>80 {
           throw ErrorImpresora.enLlamas
        }
        else
           return "OK"
    }
}

//Lanza un error "hacia arriba"
func miFuncion() throws {
  var miImpresora = Impresora()
  miImpresora.temperatura = 100
  //Para llamar a un método marcado con "throws" tenemos que usar "try"
  try miImpresora.verificarEstado()
}

try miFuncion()
```

En el ejemplo anterior, el error acaba subiendo hasta el nivel superior y el programa abortaría.

### Capturar errores

Podemos capturar un error envolviendo la llamada a los métodos que los lanzan en un bloque `do...catch`, que es muy similar al `try...catch` de Java o de otros lenguajes

```swift
do {
    var miImpresora = Impresora()
    miImpresora.temperatura = 100
    try miImpresora.verificarEstado()
}
catch ErrorImpresora.enLlamas {
    print("SOCORROOOOOOOO!!!")
}
```

### Manejar un error como opcional

En lugar de usar `try` en la llamada a un método que puede generar un error podemos emplear la "variante" `try?`. Lo que hace esta forma es capturar el error y transformar el resultado del método en un opcional, que podemos tratar con el patrón habitual `if let ...`. Si ha habido un error el método nos devolverá `nil`

```swift
var miImpresora = Impresora()
miImpresora.temperatura = 100
if let estado = try? miImpresora.verificarEstado() {
    print("Perfecto. El estado es \(estado)")
}
else {
   print("Ha habido un error")
}
```

### Ignorar los errores

Podemos usar la "variante" `try!` cuando no queremos gestionar el error porque es crítico y si se da no tiene sentido continuar con el programa. Si el error se produjera se lanzaría inmediatamente una excepción en tiempo de ejecución y el programa abortaría.

## Genéricos

## Protocolos

patrón delegate