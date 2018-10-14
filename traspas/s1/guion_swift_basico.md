# Swift básico:

## Variables y constantes

- Las **variables** se definen con `var` y las **constantes** con `let`. Swift ***induce*** el tipo a partir del valor inicial. 
- **`type(of:)`** nos devuelve el tipo
- El lenguaje es **fuertemente tipado** y no hay conversión automática
- Podemos **especificar nosotros el tipo** en la declaración
- Tipos **básicos**: `Int`, `Double`, `Float`, `Bool`
- `Any` para indicar "cualquier tipo"
- Si declaramos una **variable sin inicializar** y la intentamos usar, es un **error** de compilación

## Tipos de datos básicos (de la librería estándar)

- String
 * Interpolación con `\()`
 * Cadenas multilínea con tres `"`

- Colecciones: arrays, conjuntos y diccionarios

- Arrays
 * Inicialización con valores literales `[   ]` o con `[tipo]()`
 * declaración con `[tipo]` o `Array<tipo>`
 * Podemos hacer arrays "heterogéneos" con `Any`: `var lista: [Any] = ["hola",1]`
 * pueden cambiar de tamaño **dinámicamente**: `append`, `insert(_:, at:)`, `remove(at:)`
 * Podemos concatenar arrays con `+`
 * Iterar sobre un array con `for variable in array {  }`

- Conjuntos
 * Listas de valores que no se pueden repetir
 * Si inicializamos con literal, hay que especificar como tipo `Set`, si no Swift lo tomaría como array `var generos : Set = ["Rock", "Pop"]`
 * Algunas operaciones: `insert(_)`, `remove(_)`, `set1.union(set2)`,... 
 * Iterar con `for ... in` como en los arrays


- Diccionarios 
 * Inicialización con literales `[clave1:valor1, clave2:valor2,...]` o con `[tipoClave:tipoValor]()`
 * declaración con `[tipoClave:tipoValor]` o `Dictionary<tipoClave, tipoValor>`
 * leer, modificar con `diccionario[clave]`
 * Iterar con `for (clave,valor) in diccionario {  }`

- `ClosedRange`: `1...5`, `Range`: `1..<5 útil por ejemplo en bucles. También se puede ver si contiene un valor, por ejemplo `(1...5).contains(4)==true`

## Instrucciones de control de flujo

- Ya hemos visto `for ... in` con colecciones. También se puede aplicar a *rangos*: `for valor in 1...5 { }`, `for valor in 0..<limite`
  * variable anónima para iteración, cuando no nos interesa en qué iteración estamos: `for _ in 1...5`
- `if`, `while`:
  * La condición debe evaluarse a booleano (igual que en Java)
  * No hace falta paréntesis en la expresión (a diferencia de C)
- `repeat ... while` es como el `do..while`
- `switch` es similar a C/Java, pero
  * no hace falta break 
  * A diferencia de C, en los `case` se puede poner tipos de datos que no sean `Int`, varios valores, rangos, o condiciones. Un [Ejemplo](https://repl.it/MREg/0)

## Funciones

- definir función `func nombre(par1:tipo1, par2:tipo2)->TipoRetorno`
- Los nombres de los parámetros se usan como etiquetas al llamar a la función: `nombre(par1:1, par2:"hola")`
- Se pueden definir parámetros con un nombre dentro de la función pero una etiqueta distinta, o sin etiqueta [Ejemplo](https://repl.it/MRF9/0)
- Los parámetros no son modificables dentro del cuerpo de la función, es decir, dentro del cuerpo se tratan como si fueran constantes definidas con `let`. Podemos cambiar esto marcando el parámetro con `inout`, que se pone antes del tipo: `func ejemplo(par : inout Int)`. Para llamar a la función hay que marcar explícitamente el parámetro con un `&`. `ejemplo(par:&valor)`.
- Las funciones son "ciudadanos de primera clase", al igual que cualquier objeto por ejemplo se pueden pasar como parámetro y una función puede devolver otra función. Para definir el tipo de una función solo importa el tipo de los parámetros y el del valor de retorno, así al hacer `obj = funcion` podemos aplicarla con `obj(valor1, valor2,...)` olvidándonos de las etiquetas de los parámetros.

## Opcionales

- `nil` es como el `null` de Java, pero es aplicable también a `Int`, `Float`, ...
- No obstante, una variable "normal" no puede valer `nil`. Para indicar que puede valer `nil`, debemos declararla como *opcional*, con un `?` en la declaración, después del tipo
- Muchos métodos de la librería de Swift devuelven un opcional, con `nil` si fallan. Por ejemplo conversión de tipos `Int("hola")`
- En un opcional el valor está "envuelto", por ejemplo `print(Int("1"))`. No se puede operar con él directamente: `print(Int("1")+1)` (¡crash!)
- Podemos *desenvolver* el opcional con `!`, pero intentar desenvolver `nil` es un error
- Patrón típico para desenvolver opcionales: `if let var = varOpcional { }`
- Como el código de desenvolver es tedioso, se nos da la posibilidad de definir opcionales pero tratarlos como si no lo fueran: Implicitly unwrapped optionals, declarados con `tipo!`, por ejemplo: `var num:Int!`

## Clases

- Sintaxis similar a Java [Ejemplo](https://repl.it/MRLY/1). Algunas diferencias:
    + No se pone `new` para instanciar un nuevo objeto
    + En lugar de `this`, se pone `self`
    + Los constructores, aquí llamados *inicializadores* se definen siempre como `init`
- Propiedades computadas: son *getters*/*setters*, desde "fuera" parecen propiedades pero en realidad son métodos [Ejemplo](https://repl.it/MRS4/0)
- Los objetos se pasan por referencia igual que en Java
- Las `struct` se parecen mucho a las clases, mucho más que en C, las veremos en siguientes sesiones
- Para la herencia se usa la notación `class ClaseHeredada : ClaseBase`, y para sobreescribir un método, `override`
- *casting*: algunas veces ciertos APIs devuelven resultados "sin tipo" (`Any`), pero es posible que nosotros sepamos que una variable es de una determinada clase. Podemos forzar esa conversión con `as`: `dato as Clase`. También podemos hacer esto si tenemos una variable de una clase base pero nosotros sabemos que en realidad es una instancia de una clase derivada.
- acceso por defecto: `internal`, acceso dentro de los archivos del mismo módulo

> CUIDADO: en el REPL los modificadores de acceso no funcionan


## Extensiones

```swift
extension String {
    func reggaetonizar() -> String {
        return self + ", ya tú sabes"
    }
}
```

## Enumerados

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

- Los enum pueden tener métodos y ser conforme a protocolos
