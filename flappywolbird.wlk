import wollok.game.*
import teclado.*

object juego{
	const fondoJuego = new Fondo(img = "background.png")

	method configurar(){
		game.width(10)
		game.height(10)
		game.cellSize(50)
		self.iniciar()
		// pipe.posicionar()
		// game.addVisual(nivel1)
		// game.addVisual(pipe)
		// game.addVisual(bird)


		teclado.configurar()
		game.schedule(5000, {bird.caer()} )

		game.onCollideDo(bird,{ obstaculo => obstaculo.chocar()})
	} 
	
	method iniciar(){
		game.addVisual(fondoJuego)
		pipe.posicionar()
		game.addVisual(pipe)
		//game.addVisual(bird)
		bird.iniciar()
		pipe.iniciar()
	}

	method gameOver(){
		bird.muere()
		game.removeTickEvent("caida")
		game.removeVisual(bird)
		game.removeVisual(fondoJuego)
		game.addVisual(gameOverText)
	}
	
	method jugar(){
		if (bird.estaVivo()) 
			bird.saltar()
		else {
			self.iniciar()
		}
	}
	
}

object gameOverText{
	var property position = game.center()

	method image() = "gameOver.png"
}

class Fondo{
	const img
	var property position = game.origin()

	method image() = img
}


object pipe {

	var position = null

	method image() = "pipe.png"
	method position() = position
	
	method posicionar() {
		position = game.at(game.width()-1,game.height())
	}

	method iniciar(){
		self.posicionar()
	}
	
	method mover(){
		position = position.left(1)
		if (position.x() == -1)
			self.posicionar()
	}
	
	method chocar(){
		//juego.gameOver()
	}
}



object bird {
	var vive = false
	var property position = game.at(5,5)
	
	method image() = "bird3.png"

	
	method saltar(){
		if (position.y() < game.height()-1){ 
			position = position.up(1)
		}
	}
	
	method iniciar() {
		vive = true
		game.addVisual(bird)
	}
	method estaVivo() {
		return vive
	}

	method muere(){
		vive = false
	}

	method caer(){
		game.onTick(1000, "caida",{
			position = position.down(1)
			if (self.position().y() < 0){
				juego.gameOver() //Evalúa la condición de derrota cada 1s
			}
		})

	}
}