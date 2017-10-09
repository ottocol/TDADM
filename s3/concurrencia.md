## Concurrencia en iOS

En muchas aplicaciones iOS necesitaremos efectuar varias operaciones de modo concurrente. El caso más típico es cuando queremos hacer una operación costosa en tiempo pero no queremos que se paralice la interfaz de usuario hasta que termine la operación.

Tanto iOS como OSX tienen varios APIs con distinto nivel de abstracción para trabajar con operaciones concurrentes:

- En el nivel más bajo estaría trabajar directamente con *threads*, representados por la clase del sistema `NSThread`. La mayoría de aplicaciones no necesitan la flexibilidad que nos proporciona trabajar a este nivel, o no merece la pena teniendo en cuenta lo complicado del código con respecto a las otras alternativas.
- En un nivel intermedio tenemos un _framework_ de Apple llamado *grand central dispatch* o GCD. Tiene un nivel de abstracción razonable para la mayoría de aplicaciones, de hecho en Internet podéis encontrar multitud de tutoriales y ejemplos que lo usan (podéis verlo por la llamada a una función llamada `dispatch_async`, que pone en marcha código concurrente).
- En el nivel más alto de abstracción están las *colas de operaciones* (aunque no es mucho mayor que GCD). Es el API que vamos a usar aquí.

En una *cola de operaciones* podemos añadir trabajos concurrentes. Manejarlas a nivel básico es muy sencillo. Son instancias de `OperationQueue` y para añadir un trabajo a una solo hay que llamar a `addOperation()`. Hay diversas formas de pasar el código a ejecutar. La más cómoda es en forma de *clausura*. Por ejemplo:

```swift
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
```

NOTA: podemos ver el resultado del código anterior añadiéndolo por ejemplo a una aplicación iOS. Si usamos una aplicación de línea de comandos tendremos que añadir algo al código ya que si no el programa principal terminaría inmediatamente después del segundo `addOperation` y no se verían los mensajes en pantalla. Por ejemplo podemos llamar a `cola.waitUntilAllOperationsAreFinished()`  que como su propio nombre indica se espera hasta que todas las operaciones añadidas a la cola han terminado.

Si ejecutamos el código anterior veremos que aunque el código de la primera clausura comienza a ejecutarse primero, aun así termina después, es decir, ambas "tareas" se están ejecutando en paralelo y no secuencialmente.

En aplicaciones iOS cuando necesitemos ejecutar una operación especialmente costosa en tiempo no es recomendable bloquear la interfaz de usuario, por lo que se suele crear una cola de operaciones y ejecutar la operación en esta. La cola de operaciones de la interfaz de usuario no puede ejecutar operaciones concurrentes para evitar inconsistencias (si por ejemplo dos tareas estuvieran modificando simultáneamente el mismo elemento de la interfaz). 

Un problema adicional es que normalmente esta operación costosa debe actualizar la interfaz de usuario al finalizar, pero ningún hilo de ejecución que no sea el principal debe actualizar la interfaz de usuario, ya que lo contrario podría producir resultados inconsistentes. Esto lo podemos resolver accediendo a la cola de operaciones principal con `OperationQueue.main`. Por ejemplo:

```swift
let background = OperationQueue();
background.addOperation() {
    print("Comienzo mi duro trabajo...")
    sleep(4)
    print("...terminado!")
    print("pero yo no puedo tocar la interfaz")
    OperationQueue.main.addOperation() {
        print("Soy main. Desde aquí sí se puede actualizar la interfaz")
    }
}
```



