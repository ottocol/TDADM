//: ## Key-Value Observing

//: un objeto cualquiera puede observar cambios en las propiedades de otro. Especificamos un bloque de código (función o clausura) a ejecutar cuando se produzca este cambio

import Foundation

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

//: Para que un objeto sea observable tenemos que:
//: - Añadir a la clase la anotación @objcMembers, que hará compatible con KVO no solo a esta clase, sino también a las que hereden de ella
//: - Hacer que la clase herede de la clase base NSObject, que es la raíz de la jerarquía de clases de ObjectiveC
//: - "Marcar" las propiedades que nos interesa observar con la palabra clave dynamic

/*
let obs = pepito.observe(\.edad) { obj, cambio in
    print("\(obj.nombre) ahora tiene \(obj.edad)")
}
*/

//: [Next](@next)
