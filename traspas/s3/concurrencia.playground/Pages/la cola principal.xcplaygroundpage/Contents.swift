//: [Ant](@previous)

//: ## El Interfaz de Usuario y las colas
//: - El **código que actualice el UI** debería ejecutarse en el *thread* principal, ya que es donde se procesan los eventos y donde trabajan los *frameworks* UI del sistema
//: - La cola de operaciones "principal" (`OperationQueue.main()`) siempre se ejecuta en el *thread* principal
import Foundation
import PlaygroundSupport

//solo para que el ejemplo funcione en playground
PlaygroundPage.current.needsIndefiniteExecution = true


let background = OperationQueue();
background.addOperation() {
    print("Comienzo mi duro trabajo...")
    sleep(4)
    print("...terminado!")
    print("pero yo no puedo tocar la interfaz")
    OperationQueue.main.addOperation() {
        print("Soy main. Desde aquí se puede actualizar la interfaz")
    }
}



