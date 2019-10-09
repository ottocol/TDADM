//: [Ant.](@previous)

//: # Copia vs. referencia

//: con structs, en asignaciones o paso de parámetros siempre se hace una copia

struct Punto2D {
    var x,y : Double
    var descripcion : String {
        return "(\(x),\(y))"
    }
}

var p1 = Punto2D(x: 1.0, y: 0.0)
var p2 = p1
p1.x = -1.0;
print(p2.descripcion)

//: Ejercicio: ¿qué pasa si cambiamos lo anterior por un class?


//: [Sig.](@next)
