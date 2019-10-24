# Ejercicios de comunicación entre objetos (1.5 puntos)

En las plantillas de la sesión hay un proyecto de Xcode llamado `Conversor`. Se trata de un conversor de moneda entre euros y dólares que actualiza el tipo de cambio en tiempo real (lo debería actualizar de algún servidor, pero lo que hace es calcular un valor aleatorio cada 5 segundos).

Si escribimos por ejemplo una cantidad en euros y pulsamos el botón “obtener” que hay al lado del campo para los dólares, veremos la cantidad en dólares (y viceversa).

A. **Uso de notificaciones** (1 punto)

El problema es que aunque el cálculo se hace con la cotización actual, *la etiqueta con la cotización (“1€=…$”) no se actualiza automáticamente cada vez que cambie esta. Tenemos que solucionarlo. Es decir, **debemos hacer que la vista se actualice automáticamente cuando varíe el tipo de cambio. Se os pide hacerlo usando notificaciones**

Estructura del código:

- El *outlet* que nos da acceso a la etiqueta se llama `tipoCambioLabel`, definido en `ViewController`
- El conversor está definido como una propiedad `conversor`  en `ViewController`
- Cada 5 segundos se dispara un “timer” que llama al método `actualizarTipoDeCambio` del conversor. Este método a su vez cambia el valor de la propiedad `unEURenUSD`.

**Desde el método `actualizarTipoDeCambio` se debe enviar una notificación (dadle el nombre que queráis) y el View Controller debería suscribirse a ellas** para poder actualizar la etiqueta en pantalla.


B. **Internacionalización** (0,5 puntos): haz que la interfaz de la *app* se vea correctamente en español e inglés. Como el idioma base de desarrollo debería ser el inglés primero tendrás que cambiar los textos de los componentes a este idioma.
