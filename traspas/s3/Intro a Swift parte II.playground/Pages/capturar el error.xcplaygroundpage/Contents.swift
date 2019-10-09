//: [Ant](@previous)
//: # Capturar el error
//: Envolver la llamada a los métodos que lanza errores en un bloque `do...catch`, muy similar al `try...catch` de Java
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
do {
    var miImpresora = Impresora()
    miImpresora.temperatura = 100
    try miImpresora.verificarEstado()
}
catch ErrorImpresora.enLlamas {
    print("SOCORROOOOOOOO!!!")
}
//: [Sig](@next)
