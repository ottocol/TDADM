//: [Previous](@previous)
//: # Protocolos
//: - como los interfaces de Java
//: - definen *tipos*, pero no implementaciones

protocol ProtocoloEjemplo {
    func saludar()->String
    //Propiedad calculada: debemos decir si es gettable y/o settable
    var descripcion: String {get set}
    //si la función muta algún dato, debemos especificarlo
    mutating func reggaetonizar()
}

class MiClase : ProtocoloEjemplo {
    var descripcion = "Mi Clase"
    func saludar()->String {
        return "Hola soy " + self.descripcion
    }
    func reggaetonizar() {
        self.descripcion += " ya tú sabes"
    }
}

let mc = MiClase()
mc.reggaetonizar()
print(mc.saludar())
//: [Next](@next)
