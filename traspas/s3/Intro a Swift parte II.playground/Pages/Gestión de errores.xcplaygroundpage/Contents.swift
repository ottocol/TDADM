//: [Ant.](@previous)

//:  error: cualquier elemento que sea conforme al protocolo `Error`. Los `enums` son especialmente apropiados para representar errores

enum ErrorImpresora : Error {
    case sinPapel
    case sinTinta(color: String)
    case enLLamas
}

//: Para señalar que se ha producido un error, lo lanzamos con `throw`

throw ErrorImpresora.sinTinta(color: "Rojo")


//: [Sig.](@next)
