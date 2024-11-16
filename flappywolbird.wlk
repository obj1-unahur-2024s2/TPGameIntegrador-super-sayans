import wollok.game.*
import teclado.*

object juego {
	const fondoJuego = new Fondo(img = "fondoflappy.png")

	method configurar() {
		game.width(10)
		game.height(10)
		game.cellSize(50)
		self.iniciar()
		teclado.configurar()

		game.onCollideDo(bird, { pipe => pipe.chocar() })
	} 
	
	method iniciar() {
		game.addVisual(fondoJuego)
		game.addVisual(pipe)
		pipe.iniciar()
		bird.iniciar()

	}

	method gameOver() {
		bird.muere()
		game.removeTickEvent("caida")
		game.removeVisual(bird)
		game.removeVisual(pipe)
		game.removeVisual(fondoJuego)
		game.addVisual(gameOverText)
	}
	
	method jugar() {
		if (bird.estaVivo()) 
			bird.saltar()
		else {
			self.iniciar()
		}
	}
}

object gameOverText {
	var property position = game.center()

	method image() = "gameOver.png"
}

class Fondo {
	const img
	var property position = game.origin()

	method image() = img
}


//object pipe {
//	var position = game.at(5, 2)
//
//	method image() = "pipe.png"
//	method position() = position
//	
//	method posicionar() {
//		position = game.at(5, 1.randomUpTo(10))
//	}
//
//	method iniciar() {
//		self.posicionar()
//		self.mover()
//	}
//	
//	method mover() {
//		game.onTick(200, "mover", {position.left(1)})
//	}
//	
//	method chocar() {
//		 juego.gameOver()
//	}
//}
object pipe {
    var position = game.at(game.width() - 1, 3) 
    const abertura = 2  // Tamaño del espacio entre los tubos 

    method image() = "pipe.png"  
    method position() = position

    // Generar nueva posición y recalcular altura de los tubos
    method posicionar() {
        var alturaRandom = 2.randomUpTo(game.height() - abertura - 1)
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
        var tuboSuperior = (0..position.y() - 1).map(y => game.at(position.x(), y))
        var tuboInferior = (position.y() + abertura + 1..game.height() - 1).map(y => game.at(position.x(), y))
        return tuboSuperior.concat(tuboInferior)
    }
}

object bird {
	var vive = false
	var property position = game.at(5, 5)
	
	method image() = "bird5.png"

	method saltar() {
		if (position.y() < game.height() - 1) { 
			position = position.up(1)
		}
	}
	
	method iniciar() {
		vive = true
		game.addVisual(self)
		self.caer()  // Iniciar la gravedad de inmediato
	}

	method estaVivo() {
		return vive
	}

	method muere() {
		vive = false
	}

	method caer() {
		game.onTick(500, "caida", {  // Gravedad constante con intervalo ajustado
			if (vive and position.y() > 0) {
				position = position.down(1)
			} else if (position.y() <= 0) {
				juego.gameOver()
			}
		})
	}
}