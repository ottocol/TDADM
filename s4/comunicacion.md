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

