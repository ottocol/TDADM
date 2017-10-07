# Swift básico: Guión para clase


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
- `if`, `while`:
  * La condición debe evaluarse a booleano (igual que en Java)
  * No hace falta paréntesis en la expresión (a diferencia de C)
- `repeat ... while` es como el `do..while`

## Funciones y clausuras


