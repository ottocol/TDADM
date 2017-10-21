//: [Ant.](@previous)

//: # Estructuras

//: Muy similares a las clases.
//: - Ambas pueden contener **propiedades** y **métodos**
//: - Definen **inicializadores** (== *constructores*)
//: - Se instancian de forma muy parecida
//: - Se pueden definir como **conformes a protocolos** (parecidos a *interfaces* de Java)

struct Punto2D {
    var x,y : Double
    var descripcion : String {
        return "(\(x),\(y))"
    }
}


var p1 = Punto2D(x: 1.0, y: 0.0)
print(p1.descripcion)

//: También hay **diferencias**
//: - structs no tienen herencia
//: - tampoco tienen **Deinicializadores** (== destructores)
//: - Los objetos se pasan por referencia y las estructuras por valor.


//: [Sig.](@next)
