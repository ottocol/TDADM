# Comunicación modelo-controlador

Ya hemos visto cómo se comunican bidireccionalmente el controlador y la vista:

- Cuando la vista genera un evento (como por ejemplo un *tap* en un botón) llama a un método del controlador (un *action*)
- El controlador puede acceder al estado actual de ciertos elementos de la vista y manipularlo a través de los *outlet*.

También hemos visto que el controlador mantiene una referencia a las clases del modelo y que así podemos llamar a la lógica de negocio, pero nos falta la otra dirección: cómo avisa el modelo al controlador de que se ha producido un evento importante. Por ejemplo supongamos una aplicación de mensajería en la que las clases del modelo reciben un nuevo mensaje, y hay que pasárselo al controlador para que éste lo muestre en la vista.

Una opción para comunicar eventos del modelo al controlador sería que el primero mantuviera una referencia al segundo y así pudiera llamar a cierto método o métodos. Pero esto acoplaría el código del modelo al controlador, y no nos permitiría reutilizar el modelo o partes sgnificativas de él en otras aplicaciones, o "protegerlo" de posibles cambios en el controlador.

Vamos a ver aquí métodos "no invasivos" para que el modelo comunique con el controlador, sin necesidad de acoplar el código de ambos. Es inevitable que controlador tenga conocimiento del modelo, pero como veremos no es inevitable que el modelo tenga conocimiento del controlador.

## Notificaciones locales

Son lo que en aplicaciones *enterprise* se llaman colas de mensajes. Implementan el patrón de diseño publicar/suscribir.

Cuando alquien quiere avisar al resto del sistema, "publica" una notificación asignándole un nombre, y opcionalmente un *payload* (datos asociados). El que quiere recibir la notificación indica el nombre de la que le interesa, y qué método o clausura ejecutar cuando se reciba.

El encargado de gestionar las notificaciones es el `NotificationCenter`. Hay uno por defecto. Se pueden crear más, pero en la mayoría de aplicaciones nos bastará con uno. A este centro de notificaciones es a quien le decimos que envíe las notificaciones (publicar) o que queremos recibir las de un determinado tipo (suscribir).

```swift
import Foundation

class Emisor {
    func enviar(mensaje:String) {
        //Obtenemos el centro de notificaciones por defecto
        //Las notificaciones tienen un nombre, un objeto que las envía (si lo ponemos a nil no queda constancia de quién) y datos adicionales, un diccionario con los datos que queramos
        let nc = NotificationCenter.default
        nc.post(name: NSNotification.Name(rawValue: "saludo"), object: nil, userInfo: ["valor":1, "mensaje":mensaje])
    }
}

class Receptor {
    func suscribirse() {
        let nc = NotificationCenter.default
        //primer parámetro: añadimos como observador a nosotros (self)
        //selector: al recibir la notificación se llama al método recibir
        //name: nombre de la notificación que nos interesa
        //object: objeto del que nos interesa recibir notificaciones. nil == cualquiera
        nc.addObserver(self, selector:#selector(self.recibir), name:NSNotification.Name(rawValue:"saludo"), object: nil)
        
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
```.

