# Swift básico:

## Variables y constantes

- Tipos **básicos**: `Int`, `Double`, `Float`, `Bool`
- Las **variables** se definen con `var` y las **constantes** con `let`. Swift ***induce*** el tipo a partir del valor inicial. 
- **`type(of:)`** nos devuelve el tipo
- El lenguaje es **fuertemente tipado** y no hay conversión automática
- Podemos **especificar nosotros el tipo** en la declaración
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


## Instrucciones de control de flujo

- Ya hemos visto `for ... in` con colecciones. También se puede aplicar a *rangos*: `for valor in 1...5 { }`, `for valor in 0...<limite`
  * variable anónima para iteración, cuando no nos interesa en qué iteración estamos: `for _ in 1...5`
- `if`, `while`:
  * La condición debe evaluarse a booleano (igual que en Java)
  * No hace falta paréntesis en la expresión (a diferencia de C)
- `repeat ... while` es como el `do..while`
- `switch` es similar a C/Java, pero
  * no hace falta break 
  * en los case se puede poner cualquier tipo de datos, varios valores, rangos, o condiciones. Un [Ejemplo](https://repl.it/MREg/0)

## Funciones

- definir función `func nombre(par1:tipo1, par2:tipo2)->TipoRetorno`
- Los nombres de los parámetros se usan como etiquetas al llamar a la función: `nombre(par1:1, par2:"hola")`
- Se pueden definir parámetros con un nombre dentro de la función pero una etiqueta distinta, o sin etiqueta [Ejemplo](https://repl.it/MRF9/0)
- Las funciones son "ciudadanos de primera clase", al igual que cualquier objeto se pueden pasar como parámetro y una función puede devolver otra función

## Opcionales

- `nil` es como el `null` de Java, pero es aplicable también a `Int`, `Float`, ...
- No obstante, una variable "normal" no puede valer `nil`. Para indicar que puede valer `nil`, debemos declararla como *opcional*, con un `?` en la declaración, después del tipo
- Muchos métodos de la librería de Swift devuelven un opcional, con `nil` si fallan. Por ejemplo conversión de tipos `Int("hola")`
- En un opcional el valor está "envuelto", por ejemplo `print(Int("1"))`. No se puede operar con él directamente: `print(Int("1")+1)` (¡crash!)
- Podemos *desenvolver* el opcional con `!`, pero intentar desenvolver `nil` es un error
- Patrón típico para desenvolver opcionales: `if let var = varOpcional { }`
- Como el código de desenvolver es tedioso, se nos da la posibilidad de definir opcionales pero tratarlos como si no lo fueran: Implicitly unwrapped optionals, declarados con `tipo!`, por ejemplo: `var num:Int!`


