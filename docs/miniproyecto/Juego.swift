//Esto de momento no se usa, pero luego sí, ya que necesitaremos notificaciones
import Foundation


enum EstadoJuego {
    case turnoJugador, ganaJugador, pierdeJugador, empate, noIniciado
}

//Versión simplificada de las 7 y media en la que la máquina no saca cartas una a una
//sino que simula la jugada generando un valor al azar entre 1 y 7.5 (no se pasa nunca!)
class Juego {
    var baraja : Baraja!
    var manoJugador : Mano!
    var estado : EstadoJuego
    var jugadaMaquina : Double = 0.0
    
    init() {
        self.estado = EstadoJuego.noIniciado
    }
    
    //LLamar a este método cuando se pulse el botón de "comenzar partida"
    func comenzarPartida() {
        self.baraja = Baraja()
        self.baraja.barajar()
        
        self.manoJugador = Mano()
        //generamos un valor al azar entre 1 y 7.5. La máquina nunca se pasa
        //primero generamos un valor entre 1 y 7
        jugadaMaquina = Double(Int.random(in: 1...7))
        //y luego el 50% de las veces le sumamos 0.5
        if (Bool.random()) {
            jugadaMaquina += 0.5
        }
    }
    
    //LLamar a este método cuando se pulse el botón de "Pedir carta"
    func jugadorPideCarta() {
        if let pedida = self.baraja.repartirCarta() {
            print("Sacas \(pedida.descripcion())")
            self.manoJugador.addCarta(pedida)
            let valorMano = self.sumarManoJugador()
            print("Llevas \(valorMano) puntos")
            if (valorMano>7.5) {
                acabarPartida()
            }
        }
    }
    
    //LLamar a este método cuando se pulse el botón de "Plantarse"
    func jugadorSePlanta() {
        acabarPartida()
    }
    
    
    //Métodos para uso interno de la clase, no es necesario llamarlos desde fuera
    private func acabarPartida() {
        let valorMano = sumarManoJugador()
        var mensaje = ""
        if (valorMano>7.5) {
            mensaje = "Te has pasado!!!, la máquina tenía \(self.jugadaMaquina)"
            self.estado = .pierdeJugador
        }
        else {
            if (valorMano>jugadaMaquina) {
                mensaje = "Ganas!!!, la máquina tiene \(self.jugadaMaquina)"
                self.estado = .ganaJugador
            }
            else if (valorMano<jugadaMaquina) {
                mensaje = "Pierdes!!!, la máquina tiene \(self.jugadaMaquina)"
                self.estado = .pierdeJugador
            }
            else {
                mensaje = "Empate!!!"
                self.estado = .empate
            }
        }
        print(mensaje)
        
        //TO-DO: FALTA enviar notificación indicando que la partida ha terminado,
        //para que el ViewController se entere y muestre el resultado gráficamente (con UIAlertController)
    }
    
    private func sumarManoJugador() -> Double {
        var total = 0.0
        for carta in self.manoJugador.cartas {
            total += valor(de:carta)
        }
        return total
    }
    
    private func valor(de carta:Carta) -> Double {
        if (carta.valor>=10) {
           return 0.5
        }
        else {
           return Double(carta.valor)
        }
    }
}
