import wollok.game.*
import configuracion.*

class Obstaculo {
	method image()
	method colision() {juego.gameOver()}
	method iniciar() {self.desplazarse()}
	method desplazarse()
}

class Pipe inherits Obstaculo {
	var property position = game.at(9, 0)
	override method image() =  "pipe4.png"
	method posicionar() {position = game.at(9,0)}
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

class Pajaro inherits Obstaculo {
	var property position = game.at(9,7)
	override method image() = "attack.gif"
	method posicionar() {position = game.at(9,3.randomUpTo(9))}
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
	var property position = game.at(9,3.randomUpTo(9))
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
    //Estaria bueno que solo aparezca en el suelo (creo que a el suelo hay que cambiarle la configuracion)
}

class Fantasma inherits Obstaculo {
    //Este esta bueno
}
