import wollok.game.*
import teclado.*

object juego {
	var fondoJuego = new Fondo(img = "gif1.gif")

	method configurar() {
		game.width(10)
		game.height(10)
		game.cellSize(50)
		teclado.configurar()
		self.iniciar() 
	}

	method iniciar() {
		game.addVisual(fondoJuego) 
	}

	method jugar() {
		fondoJuego = new Fondo(img = "fondoflappy.png")
		game.addVisual(fondoJuego)
		game.addVisual(flappybird)
		flappybird.iniciar()
		game.addVisual(contadorRecord) // Añade el contador al juego
		game.addVisual(tiempoRecord)
		contadorRecord.reiniciarRecord() // Reinicia el cronómetro
		contadorRecord.comenzarCronometro()
		
		//Pipe:
		pipe.posicionar()
		game.addVisual(pipe)
	}

	method saltar() {
		if (flappybird.estaVivo()) {
			flappybird.saltar()
		} else {
			self.iniciar()
		}
	}

	method gameOver() {
		flappybird.muere()
		contadorRecord.detenerCronometro()
		game.removeTickEvent("caida")
		game.removeVisual(flappybird) 
		game.removeVisual(contadorRecord)//añadi esto para que vuelva a aparecer el contador cuando reinicia el juego, porque sino no aparecía.
		game.removeVisual(tiempoRecord)
		flappybird.position(game.at(5, 5))
		fondoJuego = new Fondo(img = "gameOver.gif") 
		game.addVisual(fondoJuego)
		sonidoGameOver.play()
	}
}

class Fondo {
	const img
	var property position = game.origin()
	method image() = img
}

object flappybird {
	var vive = false
	var property position = game.at(5, 5) 
	method image() = "bird5.png"

	method iniciar() {
		vive = true
		self.caer()
	}

	method saltar() {
		if (position.y() < game.height() - 1) {
			position = position.up(1) 
		}
	}

	method estaVivo() = vive
	method muere() { vive = false }

	method caer() {
		game.onTick(600, "caida", {
			if (vive and position.y() > 0) {
				position = position.down(1) 
			} else if (position.y() <= 0) {
				juego.gameOver() 
			}
		})
	}
}

object contadorRecord {
	var property recordActual = 0 // El tiempo récord en segundos
	//	const imagen = "record.png" // Imagen que acompaña al contador
	var property position = game.at(0, 9) // Posición fija en la esquina superior izquierda
	var contando = false // Para evitar múltiples eventos de incremento
	//	method image() = imagen
	method text() {
		// Convierte el tiempo a formato mm:ss
		const minutos = (recordActual / 60).truncate(0) // División entera, le puse el comnando truncate que muestra la cantidad de decimales que le indiques y lo puse en 0.
		const segundos = recordActual % 60
		return self.format(minutos) + ":" + self.format(segundos)
	}

	method format(numero) {
    	// Devuelve un número en formato de dos dígitos
		if (numero < 10) {
			return "0" + numero
		}
		return "" + numero
	}

	method reiniciarRecord() {
		recordActual = 0
		contando = false
	}

	method comenzarCronometro() {
		if (!contando) {
			contando = true
			game.onTick(1000, "incrementarRecord", {
			recordActual = recordActual + 1
		})
		}
	}

	method detenerCronometro() {
		if (recordActual > tiempoRecord.tiempo()){
			tiempoRecord.actualizar()
		}
		contando = false
		game.removeTickEvent("incrementarRecord")
	} 
}

object tiempoRecord { //es casi lo mismo que contador record pero no cuenta, solo guarda el mejor tiempo.
	var property tiempo = 0 
	const imagen = "record.png" 
	var property position = game.at(9, 9) 

	method image() = imagen
	method actualizar() {
		tiempo = contadorRecord.recordActual()
	}
	method text() {
		// Convierte el tiempo a formato mm:ss
		const minutos = (tiempo / 60).truncate(0) // División entera, le puse el comnando truncate que muestra la cantidad de decimales que le indiques y lo puse en 0.
		const segundos = tiempo % 60
		return self.format(minutos) + ":" + self.format(segundos)
	}

	method format(numero) {
    	// Devuelve un número en formato de dos dígitos
		if (numero < 10) {
			return "0" + numero
		}
		return "" + numero
	}
} 

object sonidoFlappy {
	method play() {
		game.sound("saltar.mp3").play()
	}
}

object sonidoGameOver {
	method play() {
		game.sound("gameOver.mp3").play()
	}
}

const velocidad = 250
object pipe {
	var position = null
	method image() = "pipe.png"
	method position() = position

	method posicionar() {
		position = game.at(game.width() - 1, suelo.position().y())
	}

	method iniciar() {
		self.posicionar()
		game.onTick(velocidad, "moverPipe", {self.mover()})
	}

	method mover() {
		position = position.left()
		if (position.x() == -1) {
			self.posicionar()
		}
	}

	method chocar() {juego.gameOver()}
	method detener() {game.removeTickEvent("moverPipe")}
}

object suelo {
	method position() = game.origin().up(1)
}