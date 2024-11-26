import wollok.game.*
import configuracion.*

class Obstaculo {
	method image()
	method colision() {juego.gameOver()}
	method iniciar() {self.desplazarse()}
	method desplazarse()
}

class Pajaro inherits Obstaculo {
	var property position = game.at(10,3.randomUpTo(9))
	override method image() = "attack.gif"
	method posicionar() {position = game.at(9,7)}
	override method desplazarse(){
		game.onTick(300, "deplazamiento", {
			position = position.left(1)
			if (position.x() <= 0){
				game.removeVisual(self)
				game.removeTickEvent("desplazamiento")
			}
		})
	}
}

class PajaroRojo inherits Obstaculo {
	var property position = game.at(10,3.randomUpTo(9))
	override method image() = "owl-preview.gif"
	method posicionar() {position = game.at(9,8)}
	override method desplazarse(){
		game.onTick(300, "deplazamiento", {
			position = position.left(1)
			if (position.x() <= 0){
				game.removeVisual(self)
				game.removeTickEvent("desplazamiento")
			}
		})
	}
}

//Igual tenemos que agrandar los assets de los obstaculos pq son muy chicos (en otra copia por si acaso si es que los intentan agrandar)
class Cangrejo inherits Obstaculo {
    var property position = game.at(10,1)
	override method image() = "crab-walk.gif"
	method posicionar() {position = game.at(9,8)}
	override method desplazarse(){
		game.onTick(300, "deplazamiento", {
			position = position.left(1)
			if (position.x() <= 0){
				game.removeVisual(self)
				game.removeTickEvent("desplazamiento")
			}
		})
	}
}

class Fantasma inherits Obstaculo {
    var property position = game.at(10,2.randomUpTo(9))
	override method image() = "fantasma.gif"
	method posicionar() {position = game.at(9,8)}
	override method desplazarse(){
		game.onTick(300, "deplazamiento", {
			position = position.left(1)
			if (position.x() <= 0){
				game.removeVisual(self)
				game.removeTickEvent("desplazamiento")
			}
		})
	}
}

//nuevos obstaculos

class PajaroVioleta inherits Obstaculo {
	var property position = game.at(10,2.randomUpTo(10))
	override method image() = "obstaculo.gif"
	method posicionar() {position = game.at(9,5)}
	override method desplazarse(){
		game.onTick(250, "deplazamiento", {
			position = position.left(1)
			if (position.x() <= 0){
				game.removeVisual(self)
				game.removeTickEvent("desplazamiento")
			}
		})
	}
}

class OtroObstaculo inherits Obstaculo {
	var property position = game.at(10,1.randomUpTo(10))
	override method image() = "obstaculo1.gif"
	method posicionar() {position = game.at(9,6)}
	override method desplazarse(){
		game.onTick(250, "deplazamiento", {
			position = position.left(1)
			if (position.x() <= 0){
				game.removeVisual(self)
				game.removeTickEvent("desplazamiento")
			}
		})
	}
}
