import wollok.game.*
import configuracion.*

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
		game.onTick(400, "caida", {
			if (vive and position.y() > 0) {
				position = position.down(1) 
			} else if (position.y() <= 0) {
				juego.gameOver() 
			}
		})
	}
}