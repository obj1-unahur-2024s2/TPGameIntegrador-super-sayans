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
		contadorRecord.reiniciarRecord() // Reinicia el cronómetro
		contadorRecord.comenzarCronometro()
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
		game.removeTickEvent("caida")
		game.removeVisual(flappybird) 
		flappybird.position(game.at(5, 5))
		fondoJuego = new Fondo(img = "gameOver.gif") 
		game.addVisual(fondoJuego)
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

object pipe {
	var position = game.at(game.width() - 1, 3) 
	const abertura = 2  // Tamaño del espacio entre los tubos 

	method image() = "pipe.png"  
	method position() = position

	// Generar nueva posición y recalcular altura de los tubos
	method posicionar() {
		const alturaRandom = 2.randomUpTo(game.height() - abertura - 1)
		position = game.at(game.width() - 1, alturaRandom)
	}

	method iniciar() {
		self.posicionar()  
		self.mover()       
	}

	method mover() {
		game.onTick(500, "moverTubo", {
			position = position.left(1)  
			if (position.x() < 0) {  
				self.posicionar()   
			}
		})
	}

	method chocar() {
		juego.gameOver()
	}

	// Devuelve las áreas ocupadas por los tubos
	method areasOcupadas() {
		const tuboSuperior = (0..position.y() - 1).map({y => game.at(position.x(), y)})
		const tuboInferior = (position.y() + abertura + 1..game.height() - 1).map({y => game.at(position.x(), y)})
		return tuboSuperior.concat(tuboInferior)
	}
}

object contadorRecord {
	var recordActual = 0 // El tiempo récord en segundos
	const imagen = "record.png" // Imagen que acompaña al contador
	var property position = game.at(0, 9) // Posición fija en la esquina superior izquierda
	var contando = false // Para evitar múltiples eventos de incremento

	method image() = imagen
	method text() {
		// Convierte el tiempo a formato mm:ss
		const minutos = recordActual / 60 // División entera
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
		contando = false
		game.removeTickEvent("incrementarRecord")
	}
}