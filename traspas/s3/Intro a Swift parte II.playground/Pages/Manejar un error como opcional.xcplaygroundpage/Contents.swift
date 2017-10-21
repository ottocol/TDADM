//: [Previous](@previous)

//: # Manejar el error como un opcional
//: `try?` captura el error y transforma el resultado del método en un opcional, que podemos tratar con el patrón habitual `if let ...`

enum ErrorImpresora : Error {
 case sinTinta(color: String)
 case enLlamas
}

class Impresora {
    var temperatura=0.0
    //Marcado con "throws" porque lanza un error "hacia arriba"
    func verificarEstado() throws -> String {
        if self.temperatura>80 {
            throw ErrorImpresora.enLlamas
        }
        else {
            return "OK"
        }
    }
}

var miImpresora = Impresora()
miImpresora.temperatura = 100
if let estado = try? miImpresora.verificarEstado() {
    print("Perfecto. El estado es \(estado)")
}
else {
    print("Ha habido un error")
}

//: [Next](@next)
