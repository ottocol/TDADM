//: [Previous](@previous)

//: # El patrón de diseño "delegación"

//: permite a una clase o estructura pasar (o *delegar*) alguna de sus responsabilidades a una instancia de otro tipo. Relacionado con la idea de *composición*: cuando queremos que un objeto haga una tarea incluimos en él otro capaz de realizarla.

//: - omnipresente en iOS/OSX, ya que permite que las clases del sistema hagan su trabajo apoyándose en otras del desarrollador.
//: - La clase del sistema contendrá una referencia a un objeto proporcionado por el desarrollador y que implementa una serie de funcionalidades.
//: - Para que el compilador pueda chequear que efectivamente las implementa, este objeto debe adoptar un determinado protocolo.

//: ![](delegation-with-text-fields.png)
//: [Next](@next)
