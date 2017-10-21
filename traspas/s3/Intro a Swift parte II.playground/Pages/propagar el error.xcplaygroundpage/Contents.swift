//: [Previous](@previous)

//: # Propagarlo "hacia arriba"
//: - Indicar que una función lanza un error poniendo `throws` en la cabecera
//: - Si llamamos a una func marcada con `throws` debemos preceder la llamada de `try`
//http://swift.sandbox.bluemix.net/#/repl/59ebaff311aa9f26931a7fbd
enum ErrorImpresora : Error {
    case sinPapel
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

//Lanza un error "hacia arriba"
func miFuncion() throws {
    let miImpresora = Impresora()
    miImpresora.temperatura = 100
    //Para llamar a un método marcado con "throws" tenemos que usar "try"
    try miImpresora.verificarEstado()
}

try miFuncion()

//: [Next](@next)
