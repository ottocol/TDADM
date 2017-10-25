//: ## Clausuras


func ascendente(a:String, b:String)->Bool {
    return a<b;
}

let nombres = ["James","Billy","D'Arcy","Jimmy"]
let ord = nombres.sorted(by:ascendente)



//: ### Bloques de código con entidad propia

let ordClausura = nombres.sorted(by: {
     (a:String,b:String)->Bool in
     return a<b
})

//: Podemos acortar todavía más la definición
//: - Inferencia de tipos
//: - return implícito
//: - Parámetros por defecto
//: - *trailing closures*

//: [Next](@next)

