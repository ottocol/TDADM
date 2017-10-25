//: ## Colas de operaciones
//: Abstracción para *multithreading* sin tener que asignar explícitamente los *threads*
import Foundation
import PlaygroundSupport

//solo para que el ejemplo funcione en playground
PlaygroundPage.current.needsIndefiniteExecution = true

let cola = OperationQueue();
cola.addOperation() {
    print("comienza operación 1...");
    sleep(5)
    print("...hecho 1");
}
cola.addOperation() {
    print("comienza operacion 2...")
    sleep(3)
    print("...hecho 2");
};


//: [Sig.](@next)
