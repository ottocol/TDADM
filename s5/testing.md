# *Testing* en Xcode

XCode incluye desde la versión 5 un *framework* de *testing* llamado `XCTest`. En el asistente de creación de un proyecto, cuando elegimos el nombre del proyecto podemos marcar los correspondientes *checkbox* para crear los *tests* asociados al proyecto. Como veremos luego con más detalle tenemos dos tipos genéricos de tests: las pruebas unitarias (*unit tests*) y las pruebas de interfaz de usuario (*ui tests*).

![](images/asistente.png)

Si tenemos un proyecto ya creado sin *test*, podemos crearlos a posteriori con `File > New > Target > iOS unit test bundle` (o `iOS UI test bundle`).

## El navegador de Tests

Para moverse por los tests, lo más sencillo es usar el *Test Navigator*, que aparece en el área de Navegadores, a la izquierda de la pantalla. Su icono es el quinto por la izquierda, un rombo ![](images/rombo_navigator.png). En este navegador podemos ver todos los tests, ir al fuente clicando sobre el nombre del test y ejecutarlos pulsando sobre el pequeño botón de “play” que aparece a la derecha cuando pasamos el ratón por encima.

![](images/test_navigator.png)

## Pruebas unitarias

En `XCTest` hay varios tipos distintos de pruebas unitarias:

- **Tests de “lógica”**: lo que todo el mundo entiende habitualmente por pruebas unitarias, es decir pruebas en las que comprobamos si determinado método funciona o no correctamente.
- **Tests de tiempo de respuesta**: en los que podemos ver estadísticas del tiempo que tarda en ejecutarse determinado bloque de código. Podemos fijar un *baseline* de tiempo de modo que el test se considerará que no pasa si está por encima del *baseline*

### Escribir y ejecutar pruebas unitarias

`XCTest` es muy similar a otros *frameworks* de pruebas unitarias como `JUnit`, así que es sencillo de usar para alguien que ya haya usado este último

Por ejemplo, supongamos que tenemos un juego de tres en raya y aquí tenemos parte del modelo:

    typedef enum {
      Casilla_Vacia,Casilla_X,Casilla_O
    } Casilla;
    
    @interface TresEnRayaModelo : NSObject
    - (id) init;
    - (Casilla) getCasillaFila:(int)fila Columna:(int)columna;
    - (void) setCasilla:(Casilla)valor Fila:(int)fila Columna:(int)columna;
    @end
    

 Vamos a comprobar varias cosas
- Que cuando se inicializa el tablero todas las casillas están vacías
    - Que las casillas se pueden obtener/fijar correctamente a un valor dado
    - Que cuando se intenta obtener/fijar una casilla que no existe se produce una excepción

#### Estructura de una *suite* de pruebas

- Iríamos a la plantilla de clase de pruebas que ha creado Xcode e introduciríamos el siguiente código

    @interface TresEnRayaTests : XCTestCase
    
    @end
    
    @implementation TresEnRayaTests {
        TresEnRayaModelo *ter;
    }
    
    - (void)setUp {
        [super setUp];
        ter = [[TresEnRayaModelo alloc] init];
    }
    
    - (void)tearDown {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        [super tearDown];
    }
    
    - (void)testInitDevuelveTableroVacio {
        for (int fila=0;fila<3;fila++)
            for(int col=0;col<3;col++) {
                XCTAssertEqual(Casilla_Vacia, [ter getCasillaFila:fila Columna:col]);
            }
    }
    
    -(void)testCasillaIncorrectaGeneraExcepcion {
        XCTAssertThrows([ter getCasillaFila:10 Columna:10], @"Debería lanzar excepción");
        XCTAssertThrows([ter setCasilla:Casilla_X Fila:10 Columna:10], @"Debería lanzar excepción");
    }
    
    @end
- Hay varios puntos a destacar:
    - Por defecto **la plantilla coloca el `@interface` y la `@implementation`** de la clase de la *suite* de tests **en el mismo archivo `.m`**. Esto es adecuado en la mayoría de los casos, ya que no vamos a referenciar la *suite* desde otras clases y no necesitamos por tanto un `@interface` separado
    - Al igual que en `JUnit` hay dos métodos: `setup` y `teardown` que se ejecutan al inicio y al final de cada test, respectivamente.
    - Las pruebas unitarias se implementan en métodos que deben devolver `void` y cuyo nombre debe comenzar por `test`. 
    - Comprobamos el correcto funcionamiento de la lógica con los métodos `XCTAssert`

#### Aserciones
En todas las aserciones podemos poner como parámetro final un mensaje (Un `NSString`) que aparecerá si falla el test

    XCTAssertTrue(NO, @"Esta prueba va a fallar seguro");

Tenemos varios tipos de aserciones, por ejemplo: 
- `XCTAssertTrue` y  `XCTAssertFalse` comprueban que algo es cierto o falso, respectivamente
- `XCTAssertEqual` sirve para comprobar la igualdad de valores escalares. En el ejemplo lo hemos usado para comprobar el contenido de las casillas al ser este un `enum`. Tenemos también el contrario, `XCTAssertNotEqual`
- `XCTAssertEqualObjects` es como el anterior, pero para comparar igualdad entre objetos. Internamente llama al `isEqual`.
- `XCTAssertThrows`comprueba que una llamada a un método genera una excepción. Opcionalmente, podemos comprobar que además la excepción es de una clase específica.
Se recomienda consultar la documentación de Apple para [más detalles sobre los distintos tipos de aserciones](https://developer.apple.com/library/mac/documentation/DeveloperTools/Conceptual/testing_with_xcode/testing_3_writing_test_classes/testing_3_writing_test_classes.html#//apple_ref/doc/uid/TP40014132-CH4-SW34).

#### Ejecutar las pruebas y ver el resultado

- En el *Test navigator* podemos pulsar el pequeño botón de “play” que aparece al pasar el ratón por encima de cada test, para ejecutarlo individualmente o bien el que aparece en la *suite* completa para ejecutar todas sus pruebas.
- Se pondrá en marcha el simulador de iOS con la aplicación, ejecutará las pruebas y terminará. En el *test navigator* y en el código fuente de la *suite* aparecerá un icono al lado de cada test indicando si ha pasado o no. Si no ha pasado aparecerá además un mensaje en el fuente indicándolo. También podemos ver los mensajes de error en el *Log Navigator*.

#### Pruebas de tiempo de respuesta

Con Xcode 6 se introduce un nuevo tipo de tests: los de tiempo de respuesta. Podemos ver estadísticas sobre el tiempo que tarda en ejecutarse un determinado bloque de código. Esto lo hacemos con el método `measureBlock`, que acepta el bloque a ejecutar como parámetro

    - (void) testInitTableroPerformance {
        [self measureBlock:^{
            for(int i=1;i<=100000;i++) {
                TresEnRayaModelo *modelo = [[TresEnRayaModelo alloc] init];
            }
        }];
    }

Cuando ejecutamos el test el bloque se ejecutará automáticamente 10 veces y nos aparecerán estadísticas sobre el tiempo medio y la desviación típica. Podemos usar estas estadísticas para fijar un *baseline*, un tiempo de referencia para la ejecución (se puede fijar un *baseline* por separado para cada hardware:iPhone 6/5, iPad Air, …)
![](performance_test.png)



## Referencias

- [Guía de apple](https://developer.apple.com/library/mac/documentation/DeveloperTools/Conceptual/testing_with_xcode/Introduction/Introduction.html#//apple_ref/doc/uid/TP40014132) sobre pruebas unitarias en Xcode 5 y posterior