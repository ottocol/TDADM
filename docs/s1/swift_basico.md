# Introducción básica a Swift 

Swift es un lenguaje originalmente desarrollado por Apple para la programación de aplicaciones en las plataformas iOS y OSX. 

Pese a haber sido desarrollado con esta intención, el lenguaje en sí no está limitado a *apps* móviles o de Mac sino que es un lenguaje de propósito general. 

Es un lenguaje bastante completo y con muchas funcionalidades, pero también pensado para que las funcionalidades básicas sean sencillas de usar. Como muchos lenguajes modernos incluye no solo elementos de programación orientada a objetos sino también de programación funcional.

## Preliminares 

En un programa Swift no hay un "main" como en C sino que el código se empieza a ejecutar por la primera instrucción de "nivel superior", es decir las sentencias que no están dentro de funciones.

Los ";" al final de las sentencias son opcionales.

## Variables y constantes 

Swift tiene una serie de tipos **básicos**: `Int`, `Double`, `Float`, `Bool`

Las **variables** se definen con `var` y las **constantes** con `let`. Si inicializamos su valor no es necesario especificar el tipo, ya que el compilador de Swift lo ***induce*** a partir del valor inicial.

```swift
var i = 1    //i es un Int
var d = 1.5  //d es un Double

//También podemos declarar el tipo, si no la inicializamos 
var f : Float
f = 1.5

//O incluso declarar e inicializar
var f2 : Float = 1.5
```

**`type(of:)`** nos devuelve el tipo

```swift
var i = 1
print(type(of:i))       //Int
type(of:i)==Float.self  //true
```

El lenguaje es **fuertemente tipado** y no hay conversión automática, no podemos asignar por ejemplo un valor 1.5 a una variable `Int`, el compilador no va a truncar el valor, pero sí podemos hacer un *cast*

```swift
var i : Int = Int(1.5)   //1
```

Podemos usar `Any` para indicar "cualquier tipo". Algunos APIs en los que no se puede saber por adelantado el tipo de retorno lo usan

Si declaramos una **variable sin inicializar** y la intentamos usar, es un **error** de compilación

## Opcionales 

> Los opcionales son prácticamente el mismo concepto que los *nullables* en Kotlin, compartiendo algunos elementos de sintaxis, aunque también con algunas diferencias prácticas

En Swift, `nil` es como el `null` de Java, pero es aplicable también a `Int`, `Float`, ... No obstante, una variable "normal" no puede valer `nil`. 

```swift
var valor : Int = nil //esto no va a compilar
```

Para indicar que una variable puede valer `nil`, debemos declararla como *opcional*, con un `?` en la declaración, después del tipo, por ejemplo `Int?`

```swift
var valor : Int? = nil //esto sí es OK
```

Muchos métodos de la librería de Swift devuelven un valor opcional, con `nil` si fallan. Por ejemplo los métodos que hacen conversión de tipos. 

```swift
//como es lógico esta conversión falla, y por tanto devuelve nil
let num = Int("hola")
```

### "Desenvolver" opcionales

En una variable opcional el valor no está accesible directamente sino que está "envuelto" (*wrapped*). No se puede operar con él directamente, antes hay que *desenvolverlo*, ahora veremos cómo.

```swift
let valor = Int("1")   //esta conversión es OK, pero devuelve un 1 "envuelto"
print(valor)   //no es 1, sino que pone Optional(1)
print(valor+1) //CRASH! esto no es válido
```

Podemos *desenvolver* el opcional con `!`, pero hay que llevar cuidado, ya que intentar desenvolver `nil` es un error

```swift
let valor = Int("1")
print(valor!+1)
```

El patrón típico para desenvolver opcionales de forma *segura* es usar  `if let`, que es una especie de condicional que solo se cumple si el valor desenvuelto es distinto de `nil`, y "de paso" le asigna el valor desenvuelto a la variable que ponemos en el `let`

```swift
let valor = Int("1")
if let valorDesenvuelto = valor {
  print("¡Es un número!: \(valorDesenvuelto)")
}
```

Aunque en muchos ejemplos de `if..let` se usa una nueva variable para el valor desenvuelto podemos usar la misma del valor original, así evitamos tener que crear una variable nueva solo para desenvolver

```swift
let valor = Int("1")
if let valor = valor {
  print("¡Es un número!: \(valor)")
}
```

Otra forma de desenvolver valores es con el operador de *coalescencia* (*nil-coalescing*). Este operador, `??`, nos permite desenvolver automáticamente un valor o devolver un valor por defecto si el opcional era `nil`.

```swift
var opcional : Int?
...
var v = opcional ?? 0 
```

En el ejemplo anterior, si "opcional" contiene un valor se desenvolverá automáticamente y asignará a `v` y si no, a `v` se le asignará 0.

### Opcionales "desenvueltos implícitamente"

También tenemos la posibilidad de definir opcionales pero tratarlos como si no lo fueran, ya que no hace falta desenvolverlos: son los denominados *Implicitly unwrapped optionals*, declarados con `tipo!`, por ejemplo: 

```swift
let valor : Int!
valor = Int("1")
print(valor)
```

Esto es útil para variables que la mayor parte del tiempo sabemos que van a tener un valor no `nil` pero puede haber cierto momento en el flujo de ejecución del programa en que sean `nil`. Por ejemplo, en iOS cuando se ejecuta nuestro código en respuesta a eventos de usuario (pe.j *tap*), los componentes de UI ya están inicializados, pero hay ciertos puntos de la aplicación donde todavía no se han creado. 

## Tipos de datos básicos (de la librería estándar)  

### String

Se aplican la mayoría de convenciones habituales: delimitadas por dobles comillas, concatenadas con `+`,...

Se puede hacer interpolación de cadenas (expresiones dentro de cadenas) usando `\()`

```swift
var nombre = Pepe
var edad = 33
print("\(nombre) tiene \(edad) años")
```

Se pueden definir cadenas multilínea delimitadas con tres `"`

```swift
var mensaje = """
   Esto es una cadena multilínea.
   Se ignora el sangrado, se coloca todo
     al nivel del que tenga la primera línea.
     Los delimitadores del final deben venir en su propia línea   
"""     
```

### Colecciones: arrays, conjuntos y diccionarios 

#### Arrays

Se pueden declarar con `[tipo]` o `Array<tipo>`

```swift
var lista_enteros : [Int]
var lista_cadenas : Array<String>
```

Se pueden inicializar con una lista de valores literales `[   ]`. La notación para acceder a un elemento es la misma que en C

```swift
var bizcocho = ["huevos", "leche", "harina"]
bizcocho[2] = "harina con levadura"
```
 
Si lo inicializamos con `[tipo]()` tendremos un array vacío. Pero los arrays pueden cambiar de tamaño **dinámicamente** a diferencia de lenguajes más tradicionales como C++/Java

```swift
var nums = [Int]()
nums.append(3)       //nums == [3]
nums.insert(1, at:0) //nums == [1,3]
nums.remove(at:0)    //nums == [3]
```

Podemos concatenar arrays con `+`

Podemos iterar sobre un array (en general sobre una colección) con `for ... in`

```swift
var bizcocho = ["huevos", "leche", "harina"]
for ingrediente in bizcocho {
  print(ingrediente)
}
```

#### Conjuntos

Son listas de valores que no se pueden repetir.

Si lo inicializamos con un valor literal, hay que especificar como tipo `Set`, si no Swift lo tomaría como un array

```swift
var generos : Set = ["Rock", "Pop"]
```

Algunas operaciones: `insert(_)`, `remove(_)`, operaciones de conjuntos: `set1.union(set2)`,... 

Se puede iterar con `for ... in` como en los arrays


### Diccionarios 

Son listas de pares clave/valor. Lo que en Java serían HashMaps o Maps en Javascript

Inicialización con valores literales:

```swift
 
var horasTrabajadas = ["Lunes":7, "Martes":8, "Miércoles":7]
horasTrabajadas["Lunes"]==7   //true
horasTrabajadas["Jueves"]=5 
```

Se pueden declarar sin inicializar especificando el tipo de la clave y el tipo del valor

```swift
var horas = [String:Int]
var masHoras = Dictionary<String:Int>
```
 
Se puede iterar por ellos con `for (clave,valor) in `

```swift
var grupo = ["Billy":"guitar", "James":"guitar", "Darcy":"bass", "Jimmy":"drums"]
for (nombre, instrumento) in grupo {
  print ("\(nombre) on the \(instrumento)")
}
```


## Instrucciones de control de flujo 

Hay algunas instrucciones que son iguales a C/Java, como el `if` o el `while` con ciertas diferencias:

- Las condiciones no es necesario ponerlas entre paréntesis
- Aunque un bloque de sentencias tenga una única instrucción **siempre** hay que poner llaves, por ejemplo:

```swift
if edad<18 {
  print("Lo siento, no puedes entrar a este sitio")
} else {
  print("Bienvenido")
}
```

Ya hemos visto `for ... in` con colecciones. También se puede aplicar a *rangos*:

```swift
for i in 1...5 {
  print(i)
}

for i in 1..<3 { //rango semiabierto, llega solo hasta el 2
  print(i)
}
```

Si solo nos interesa realizar un determinado número de iteraciones y no en cuál estamos,  podemos usar la *variable anónima*, `_`

```swift
for _ in 1...3 {
  print ("RA ")
}
```

Existe una instrucción equivalente al `do...while` que es el `repeat ... while` (`do` es una palabra clave del lenguaje pero se usa en el manejo de errores)

`switch` es similar a C/Java, pero
  * No hace falta `break` después de cada `case`. Por defecto cuando salimos de un `case` se sale del `switch` 
  * En los `case` se puede poner cualquier tipo de datos (Int, Float, String,...), varios valores, rangos, o condiciones.
  * Los `case` deben ser *exhaustivos*. Es decir deben cubrir todos los posibles valores de la variable (o si son infinitos, como en variables numéricas, al menos debe haber un `default`)

```swift
let valorCarta = -1
switch valorCarta {
  case 1...7: print("Es un \(valorCarta)")
  case 8,9: print("Normalmente no se usan 8 y 9")
  case 10: print("Sota")
  case 11: print("Caballo")
  case 12: print("Rey")
  case let x where x<0: print("WTF! ¿Una carta negativa?")
  default: print("Carta no válida")
}
```

## Funciones 

Para definir una función se usa la sintaxis `func nombre(par1:tipo1, par2:tipo2)->TipoRetorno`. Si una función no devuelve nada se omite el `->TipoRetorno`

```swift
func generarSaludo(nombre:String)->String {
  return "Hola \(nombre)"
}

func imprimirSaludo(nombre:String) {
  print("Hola \(nombre)")
}
```

Los nombres de los parámetros no solo se usan dentro del código de la función, sino también como etiquetas al llamarla. Continuando con los ejemplos anteriores

```swift
generarSaludo(nombre:"Pepe")
```

Hay casos en los que quedaría más "natural" darle un nombre a la etiqueta diferente al que se usa dentro de la función. En ese caso ponemos primero la etiqueta y luego el nombre "interno". Si no queremos usar etiqueta ponemos la variable anónima: `_`

```swift
func saludarA(_ nombre: String, el dia: String) -> String {
    return "Hola \(nombre), hoy es \(dia)."
}
saludarA("Pepe", el: "Martes")
```

Los parámetros no son modificables dentro del cuerpo de la función, es decir, dentro del cuerpo se tratan como si fueran constantes definidas con `let`. Podemos cambiar esto marcando el parámetro con `inout`, que se pone antes del tipo: `func ejemplo(par : inout Int)`. Para llamar a la función hay que marcar explícitamente el parámetro con un `&`. `ejemplo(par:&valor)`.

Las funciones son "ciudadanos de primera clase", al igual que cualquier objeto se pueden pasar como parámetro y una función puede devolver otra función


## Clases 

La sintaxis es similar a Java con algunas diferencias:

  + No se pone `new` para instanciar un nuevo objeto, sino solo el nombre del constructor
  + En lugar de `this`, se pone `self`
  + Los constructores, aquí llamados *inicializadores* se definen en el código de la clase con el nombre `init`
  
por ejemplo:

```swift
class Figura {
    var numeroDeLados = 0
    init(lados:Int) {
        self.numeroDeLados = lados
    }
    func descripcion() -> String {
        return "Una figura con \(numeroDeLados) lados."
    }
}
let hexagono = Figura(lados:6);
print (hexagono.descripcion())
```

Propiedades computadas: son *getters*/*setters*, desde "fuera" parecen propiedades pero en realidad son métodos

```swift
class Figura {
    private var numeroDeLados = 0
    init(lados:Int) {
        self.numeroDeLados = lados
    }
    var descripcion : String {
      get {
        return "Una figura con \(numeroDeLados) lados."
      }
    }
    var lados : Int {
      get {
        return numeroDeLados
      }
      set(lados) {
        self.numeroDeLados = lados
      }
    }
}
let hexagono = Figura(lados:6);
print (hexagono.descripcion)
```

Los objetos se pasan por referencia igual que en Java

```swift
let h1 = Figura(lados:6)
//no es copia, sino referencia. h2 y h2 "apuntan" al mismo objeto
let h2 = h1
h2.lados = 5
print(h1.descripcion)  //Una figura con 5 lados  (!!)
```

Las `struct` se parecen mucho a las clases, mucho más que en C, las veremos en siguientes sesiones

Para la herencia se usa la notación `class ClaseHeredada : ClaseBase`, y para sobreescribir un método, `override`

### Failable initializers

Cualquier método,  incluyendo un inicializador, puede devolver un valor opcional. En este último caso, estamos indicando que si algo no es correcto no vamos a devolver una nueva instancia, sino `nil`. Estos inicializadores se denominan *failable initializers* y se denotan con `init?`. Por ejemplo supongamos que nos damos cuenta que no tienen sentido las figuras con número de lados <=2:

```swift
class Figura {
    private var numeroDeLados : Int
    init?(lados:Int) {
      if lados>2 {
        self.numeroDeLados = lados
      }
      else {
        return nil
      }
    }
    ...
}
```

Como vemos, el *failable initializer* devuelve *nil* cuando no queremos devolver una instancia de la clase.

### Casting de clases

Algunas veces ciertos APIs devuelven resultados "sin tipo" (en Swift se pone como`Any`), pero es posible que nosotros sepamos que una variable es de una determinada clase. Podemos forzar esa conversión con `as`: `dato as Clase`. También podemos hacer esto si tenemos una variable de una clase base pero nosotros sabemos que en realidad es una instancia de una clase derivada.

```swift
var t = miFigura as Triangulo
```

## Extensiones 

Nos permiten añadir nueva funcionalidad a clases ya existentes, incluso aun sin acceso al código fuente o en clases del sistema. Se pueden añadir por ejemplo nuevos métodos, inicializadores y propiedades computadas. Lo que no se puede hacer es sobreescribir los métodos o propiedades ya existentes.

```swift
extension String {
    func reggaetonizar() -> String {
        return self + " ya tú sabes"
    }
}
```

Podemos usar los métodos y propiedades de la extensión como usábamos los originales:

```swift
print("mami".reggaetonizar())  //mami ya tú sabes
```


## Enumerados 

Se definen de forma similar a C pero no tienen nada que ver, son tipos "por derecho propio", no enteros

```swift
enum Direccion {
    case norte, sur, este, oeste
}
```

Pueden tener un valor "interno" (*raw*), cuyo tipo se indica como si el enumerado heredara de él. Cuando se pone `Int`, Swift asigna valores comenzando por 0. Accedemos a este valor con `rawValue`.

```swift
enum Direccion: Int {
    case norte, sur, este, oeste
}
print (Direccion.norte.rawValue)  //0
```

Si indicamos `String` como tipo del `rawValue` Swift hace una "conversión automática" de los nombres a Strings

```swift
enum Direccion: String {
    case norte, sur, este, oeste
}
print (Direccion.norte.rawValue)  //"norte"
```

Los *enum* pueden tener métodos y ser conforme a protocolos (estos últimos son similares a los *interfaces* de Java).

```swift
enum Direccion: String {
    case norte, sur, este, oeste
    
    func inicial()->String {
        let cadena = self.rawValue
        let inicial = cadena[cadena.startIndex]
        return String(inicial).uppercased()
    }
}

print(Direccion.norte.inicial())   //"N"
```
