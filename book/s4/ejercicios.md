# Ejercicios de comunicación entre objetos

En las plantillas de la sesión hay un proyecto de Xcode llamado `Conversor`. Se trata de un conversor de moneda entre euros y dólares que actualiza el tipo de cambio en tiempo real (lo debería actualizar de la red, pero lo que hace es calcular un valor aleatorio cada 5 segundos).

Si escribimos por ejemplo una cantidad en euros y pulsamos el botón “obtener” que hay al lado del campo para los dólares, veremos la cantidad en dólares (y viceversa).

El problema es que aunque el cálculo se hace con la cotización actual, **la etiqueta con la cotización (“1€=…$”) no se actualiza automáticamente cada vez que cambie esta. Tenemos que solucionarlo**. Es decir, debemos hacer que la vista se actualice automáticamente cuando cambie una propiedad del modelo.

- El *outlet* que nos da acceso a la etiqueta se llama `tipoCambioLabel`, definido en `ViewController`
- El conversor está definido como una propiedad `conversor`  en `ViewController`
- Cada 5 segundos se dispara un “timer” que llama al método `actualizarTipoDeCambio` del conversor. Este método a su vez cambia el valor de la propiedad `unEURenUSD`.

**Implementar una primera versión usando KVO** (0,75 puntos), de modo que el View Controller se registre como observador de la propiedad `unEURenUSD`. Cada vez que cambie se debería actualizar la etiqueta para reflejar el tipo de cambio actual.

- Cuando hagas que la clase `ConversorEUR_USD` herede de `NSObject` se generará un error de compilación porque el inicializador debe llamar al de la nueva clase base. Tendrá que quedar como:

```swift
override init() {
        super.init()
        ... //a partir de aquí, como estaba
}
```

- Puedes llamar a `conversor.observe` en el `viewDidLoad` del controller. Este método devuelve una variable de la clase  `NSKeyValueObservation`. Define una propiedad de este tipo en el view controller, porque si la variable se sale del ámbito el KVO dejará de funcionar (desde iOS 11)

```swift
//propiedad del view controller
var observador : NSKeyValueObservation!
```

```swift
//en el view controller
override func viewDidLoad() {
        super.viewDidLoad()
        observador = conversor.observe(....
```

**Implementar otra versión con notificaciones:** (0,75 puntos) 

- Primero comentad la línea del ejercicio anterior que actualiza la etiqueta en pantalla, ya que ahora la vamos a actualizarla con notificaciones
- Desde el método `actualizarTipoDeCambio` se debe enviar una notificación (dadle el nombre que queráis) y el View Controller debería suscribirse a ellas para poder actualizar la etiqueta en pantalla. 

**Internacionalización** (0,5 puntos): haz que la interfaz de la *app* se vea correctamente en español e inglés 
