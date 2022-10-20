# Comunicación modelo-controlador

Ya hemos visto cómo se comunican bidireccionalmente el controlador y la vista:

- Cuando la vista genera un evento (como por ejemplo un *tap* en un botón) llama a un método del controlador (un *action*)
- El controlador puede acceder al estado actual de ciertos elementos de la vista y manipularlo a través de los *outlet*.

También hemos visto que el controlador mantiene una referencia a las clases del modelo y que así podemos llamar a la lógica de negocio, pero nos falta la otra dirección: cómo avisa el modelo al controlador de que se ha producido un evento importante. Por ejemplo supongamos una aplicación de mensajería en la que las clases del modelo reciben un nuevo mensaje, y hay que pasárselo al controlador para que éste lo muestre en la vista.

Una opción para comunicar eventos del modelo al controlador sería que el primero mantuviera una referencia al segundo y así pudiera llamar a cierto método o métodos. Pero esto acoplaría el código del modelo al controlador, y no nos permitiría reutilizar el modelo o partes sgnificativas de él en otras aplicaciones, o "protegerlo" de posibles cambios en el controlador.

Vamos a ver aquí métodos "no invasivos" para que el modelo comunique con el controlador, sin necesidad de acoplar el código de ambos. Es inevitable que controlador tenga conocimiento del modelo, pero como vamos a ver no es inevitable que el modelo tenga conocimiento del controlador.

En Foundation hay dos formas básicas de conseguir que dos objetos se comuniquen acoplando el código de ambos lo menos posible:

- **Notificaciones:** un objeto puede recibir notificaciones sobre eventos que le interesen. Asímismo otro objeto puede enviar notificaciones. El encargado de gestionar las notificaciones es un objeto intermediario denominado "centro de notificaciones". Podemos usar las notificaciones de modo que el modelo notifique que ha habido un cambio y el controlador reciba la notificación y actualice la vista. 

- **Key-Value observing** o KVO: un objeto puede "vigilar" el cambio en el valor de las propiedades de otro. Cuando se produzca un cambio, se llamará a una función o clausura que actúa de *callback*. Podemos usar este mecanismo para hacer que el controlador observe las propiedades del modelo que nos interesa actualizar dinámicamente en la vista.

## Notificaciones locales

Son algo similar a lo que en aplicaciones *enterprise* se llaman *colas de mensajes*. Implementan el patrón de diseño publicar/suscribir.

Cuando un objeto quiere avisar al resto del sistema, publica una notificación asignándole un nombre, y opcionalmente un *payload* (datos asociados). Los objetos que quieren recibir la notificación indican el nombre de la que le interesa, y qué método o clausura ejecutar cuando se reciba.

El encargado de gestionar las notificaciones es el `NotificationCenter`. Hay uno por defecto ya inicializado en cada aplicación (`NotificationCenter.default`). Se pueden crear más, pero en la mayoría de aplicaciones nos bastará con uno. A este centro de notificaciones es a quien le decimos que envíe las notificaciones (publicar) o que queremos recibir las de un determinado tipo (suscribir).

```swift
import Foundation

class Emisor {
    func enviar(mensaje:String) {
        //Obtenemos el centro de notificaciones por defecto
        //Las notificaciones tienen un nombre, un objeto que las envía (si lo ponemos a nil no queda constancia de quién) y datos adicionales, un diccionario con los datos que queramos
        let nc = NotificationCenter.default
        nc.post(name: Notification.Name("saludo"), object: nil, userInfo: ["valor":1, "mensaje":mensaje])
    }
}

class Receptor {
    func suscribirse() {
        let nc = NotificationCenter.default
        //primer parámetro: añadimos como observador a nosotros (self)
        //selector: al recibir la notificación se llama al método recibir
        //name: nombre de la notificación que nos interesa
        //object: objeto del que nos interesa recibir notificaciones. nil == cualquiera
        nc.addObserver(self, selector:#selector(self.recibir), name:Notification.Name("saludo"), object: nil)
        
    }
    
    @objc func recibir(notificacion:Notification) {
        print("recibido!!")
        if let userInfo = notificacion.userInfo {
            let mensaje = userInfo["mensaje"] as! String
            print("dice: \(mensaje)")
        }
    }
}

var e = Emisor()
var r = Receptor()
r.suscribirse()
e.enviar(mensaje:"holaaaa")
```

El nombre de la notificación no es exactamente un String, sino un `Notification.Name` construido a partir de un String. Para que el código sea más seguro y menos propenso a errores podemos extender esta clase con constantes y usar estas constantes en lugar de directamente los Strings. Siguiendo con el ejemplo, haríamos algo como:

```swift
//En el archivo que queramos
//Alguna gente usa convenciones del tipo "NotificationName+Extensions.swift"
extension Notification.Name {
    static let saludo = Notification.Name("saludo")
}
```

y ahora cuando queramos referenciar un `Notification.name` lo hacemos como `Notification.name.saludo` o mejor aún, simplemente `.saludo` como en los enumerados:

```swift
let nc = NotificationCenter.default
nc.post(name: .saludo), object: nil, userInfo: ["valor":1, "mensaje":"hola"])
```

## Key-Value Observing

Gracias a Foundation, un objeto cualquiera puede *observar* cambios en las propiedades de otro. Especificamos un bloque de código (función o clausura) a ejecutar cuando se produzca este cambio. Esta funcionalidad se denomina **Key-Value Observing** o KVO.

Nótese que para que esto pueda funcionar el *runtime* tiene que "interceptar" de algún modo los cambios en las propiedades. Estas funcionalidades están integradas en el *runtime* de Objective-C, el "antiguo" lenguaje de desarrollo de Apple, y Swift todavía no las incorpora de forma totalmente nativa. Así, para que KVO funcione con nuestras clases Swift vamos a tener que usar algunas anotaciones y palabras clave especiales que referencian a Objective-C

Por ejemplo supongamos el siguiente código, que define una clase `Persona`

```swift
class Persona  {
    var nombre : String
    var edad : Int = 0
    func cumplirAños() {
        self.edad += 1
    }
    init(nombre:String) {
        self.nombre = nombre
    }
}
let pepito = Persona(nombre:"Pepe")
pepito.cumplirAños()
print("\(pepito.nombre) tiene \(pepito.edad) año/s")
```

Supongamos que nos interesa enterarnos de cuándo cambia la edad de una persona, y ejecutar cierto código en respuesta a esto. Podemos hacerlo con KVO. Lo primero es cambiar ciertos elementos de la clase para que use el *runtime* de ObjectiveC:

- Hacer que la clase herede de la clase base `NSObject`, que es la raíz de la jerarquía de clases de ObjectiveC
- "Marcar" las propiedades que nos interesa observar con la anotación `@objc` y la palabra clave `dynamic` (en lugar de usar `@objc` podríamos marcar la clase entera con `@objcMembers`).

```swift
class Persona : NSObject {
    var nombre : String
    @objc dynamic var edad : Int = 0
    func cumplirAños() {
        self.edad += 1
    }
    init(nombre:String) {
        self.nombre = nombre
    }
}
```

Lo siguiente que necesitamos es poder especificar qué propiedad queremos observar. Esto se hace con una expresión denominada *keypath*. Un *keypath* es simplemente la trayectoria a seguir desde un objeto "inicial" hasta la propiedad que nos interesa. Por ejemplo algo como "persona1.nombre". O si una persona tuviera una propiedad `conyuge : Persona` podríamos ir encadenando propiedades: `persona1.conyuge.nombre`.

Hasta Swift 3 los *keypath* se especificaban como cadenas, pero desde Swift 4 se han añadido de forma "nativa", con una sintaxis propia que permite el chequeo de tipos por parte del compilador. Con la nueva sintaxis Los *keypath* comienzan por una barra invertida y se ponen sin comillas, ya que no son cadenas. Se especifican de forma genérica, es decir, comienzan no por un nombre de objeto concreto sino por un nombre de clase, por ejemplo `\Persona.nombre`. Si el contexto permite resolver la ambigüedad se puede omitir el nombre de la clase (pero no el `.`, por consistencia): por ejemplo `\.nombre`, `\.conyuge.nombre`.

Ahora ya tenemos todos los elementos para indicar que en el ejemplo anterior queremos observar los cambios en la propiedad "edad" del objeto "pepito" y en respuesta a ellos ejecutar cierto código. Para ello usamos el método `observe` sobre la instancia a observar. El primer parámetro es el *keypath* que nos interesa observar y el último una clausura con el código a ejecutar cuando cambia:

```swift
import Foundation 

let observador = pepito.observe(\.edad) { obj, cambio in
    print("\(obj.nombre) ahora tiene \(obj.edad")
} 
```

- Nótese que en el *keypath* se puede omitir `Persona` al comienzo ya que claramente "edad" debe ser una propiedad de esta clase. 
- La clausura con el código a ejecutar recibe dos parámetros: `obj`, que es el objeto que estamos observando, y `cambio`, que nos da más información sobre el cambio producido (luego veremos el uso de este último)

Cuando ya no nos interese seguir observando podemos parar el KVO llamando a `invalidate` sobre el valor devuelto por `observe`:

```swift
observador.invalidate()
```

> Importante: las observaciones se seguirán realizando mientras el objeto  devuelto por `observe` siga definido. Cuando se "pierde" (por ejemplo era una variable local a una función y esta ya ha terminado) el KVO se para automáticamente. En versiones antiguas de iOS había que pararlo manualmente y se producía un error si se recibían nuevas observaciones cuando el observador ya no existía.

En el ejemplo anterior solo nos interesaba el estado actual del objeto una vez producido el cambio. En algunos casos nos puede interesar más información, como saber además cuál era el valor anterior de la propiedad. Para ello se usa un parámetro de `observe` que antes hemos omitido, llamado `options`, de tipo `OptionSet`. Desde el punto de vista de su uso, un `OptionSet` es un array de constantes donde especificamos un conjunto de opciones que no son mutuamente excluyentes. En nuestro caso las opciones son constantes de la clase [`NSKeyValueObservingOptions`](https://developer.apple.com/documentation/foundation/nskeyvalueobservingoptions). Vamos a indicar por ejemplo que nos interesa que se nos informe explícitamente del valor actual y del antiguo:

```swift
let obs = pepito.observe(\.edad, options:[.new, .old]) { obj, cambio in
    print("Antes: \(cambio.oldValue!)")
    print("Ahora: \(cambio.newValue!)")
}
```

En `options` hemos indicado qué información queremos y esta la tenemos disponible a través de propiedades del segundo parámetro de la clausura (nuestro parámetro `cambio`). Hay más opciones de KVO, por ejemplo con `.prior` indicaríamos que queremos recibir dos avisos, uno inmediatamente antes del cambio y otro inmediatamente después. Se recomienda consultar la documentación para ver más opciones.