# Introducción a las aplicaciones en la plataforma iOS

Una vez vistos los conceptos básicos del lenguaje de programación que vamos a usar, que es Swift, vamos a ver qué estructura tienen las aplicaciones en iOS. Como ahora mismo veremos, Apple utiliza mucho los patrones de diseño software en iOS. De hecho todas las *apps* de esta plataforma siguen el conocido patrón Modelo/Vista/Controlador. Por ello veremos primero en qué consiste, cómo se implementa en iOS y qué clases básicas forman la estructura de toda aplicación. Implementaremos nuestra primera aplicación iOS para poder entender mejor todos estos conceptos.

## Patrón general para una aplicación iOS: MVC

Como acabamos de comentar, las aplicaciones iOS siguen el archiconocido patrón de diseño "Modelo/Vista/Controlador", abreviado comúnmente como MVC. Aunque hay muchas variantes de este patrón y los detalles varían mucho entre ellas, en general en todas:

- El **modelo** es el "corazón" de la aplicación y la parte *que no se ve*, es decir, la estructura de clases que modelan la llamada *lógica de negocio*. Una de las ideas básicas de MVC es que el modelo debería ser independiente de la interfaz (la vista) y por tanto **reutilizable** aunque cambie la interfaz de la aplicación. En general, los *frameworks* de desarrollo de aplicaciones MVC  es en lo que menos suelen intervenir, e iOS no es una excepción. Es decir, el modelo estará constituido generalmente por clases propias, y no necesariamente de ninguna biblioteca del sistema.
- La **vista** es la interfaz de la aplicación. Generalmente todas las plataformas de desarrollo para móviles tienen una biblioteca de componentes de interfaz de usuario: botones, campos de texto, *sliders*, ... que podemos usar para componer la vista. Como veremos, en iOS podemos crear la interfaz "arrastrando" componentes en un editor gráfico integrado en Xcode. O también podemos crear la interfaz por código.
- El **controlador** es el elemento que presenta más diferencias de una variante a otra de MVC. responde a eventos (generalmente acciones del usuario - por ejemplo un *tap* sobre un botón) y realiza peticiones al modelo. Al contrario, también puede detectar un cambio en el modelo y solicitarle a la vista que lo muestre. Como veremos, en iOS el controlador es una clase que hereda de una propia del sistema.

Aunque en MVC el papel de estos elementos está más o menos claro en términos generales, no suele estar tan clara la relación entre ellos (quién comunica con quién y cómo). En la variante concreta de MVC que se usa en iOS, la relación entre estos tres elementos se muestra en la siguiente figura:

![imag/mvc.png]()

Como vemos, el controlador está "enmedio" de la vista y el modelo, aislando ambos entre sí, de modo que vista y modelo no tienen comunicación directa. Esto nos permite modificar uno sin afectar al otro.

En cuanto a la comunicación entre vista y controlador:

- Cuando la vista genera un evento, el controlador lo recibe a través de lo que en iOS se llama un *action*. Básicamente es un método del controlador que hace de *callback* del evento.
- El controlador guarda referencias a los elementos de la vista que nos interesa en lo que se denominan *outlets*. Así puede cambiar la vista (por ejemplo cambiar el texto de un campo o desactivar un botón)

Y entre modelo y controlador:

- El controlador guarda una referencia al modelo y a través de ella puede llamar a sus métodos.
- Cuando se produce un cambio en el modelo, este "avisa" al controlador mediante métodos estándar en iOS para comunicación entre objetos, como son el KVO y las notificaciones locales.

## Comenzando nuestra primera aplicación iOS

Vamos a implementar una aplicación muy sencilla a la que llamaremos "UAdivino". Es una versión del clásico juguete "[la bola 8 mágica](https://es.wikipedia.org/wiki/Magic_8-Ball)", a la que se le formula una pregunta y que supuestamente responde, dando en realidad respuestas genéricas: "sí", "¡claro que no!", "es muy posible",...

Para crear la aplicación arrancamos Xcode:

 1. en las opciones de la izquierda seleccionamos "Create a new Xcode project". 
 2. En el siguiente paso elegimos la plantilla "Single View App", ya que nuestra aplicación tiene una única "pantalla". 
 3. Tras darle a `Next`, escribimos el nombre del proyecto, `UAdivino` 
 4. En la última pantalla del asistente podemos seleccionar la carpeta donde guardar el proyecto. Elegimos la que queramos.

## Estructura del código de una aplicación

La siguiente figura, tomada de la "[App programming guide for iOS](https://developer.apple.com/library/content/documentation/iPhone/Conceptual/iPhoneOSProgrammingGuide)" de Apple, muestra los elementos básicos de cualquier aplicación iOS. Podemos distinguir la parte del modelo, la del controlador y la de la vista. Nótese que no hay un único controlador ni una única vista. En general, podríamos decir que por cada "pantalla" de nuestra aplicación tendremos un controlador "principal" que controla una vista. Esa vista a su vez está formada por una jerarquía de *subvistas* (paneles, botones, *sliders*,...). Esto no hay que tomarlo literalmente, ya que en una "pantalla" puede haber más de un controlador, pero es útil para hacerse una idea aproximada.

## La plantilla creada por Xcode

Para no tener que partir de 0, Xcode nos ha creado una plantilla con varias clases

## Creación de la interfaz (la vista)

La interfaz de la aplicación va a tener el siguiente aspecto, con un "cartel" explicando qué hace la *app*, un botón para solicitar la respuesta, y un campo en el que aparecerá dicha respuesta.

## Implementación del modelo


## Implementación del controlador


