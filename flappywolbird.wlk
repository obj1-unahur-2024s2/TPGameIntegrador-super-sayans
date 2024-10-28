import wollok.game.*


object juego{

	method configurar(){
		game.width(10)
		game.height(10)
		pipe.posicionar()
		game.addVisual(pipe)
		game.addVisual(bird)
		game.boardGround("background.png")

	
		keyboard.space().onPressDo{ self.jugar()}
		game.onCollideDo(bird,{ obstaculo => obstaculo.chocar()})
	} 
	
	method iniciar(){
		bird.iniciar()
		pipe.iniciar()
	}
	
	method jugar(){
		if (bird.estaVivo()) 
			bird.saltar()
		else {
			self.iniciar()
		}
	}
	
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
		//no lo pense
	}
}



object bird {
	var vive = false
	var position = game.at(1,game.height())
	
	method image() = "bird.png"
	method position() = position

	
	method saltar(){
		position = position.up(1)
        position = position.down(1)
	}
	
	method iniciar() {
		vive = true
	}
	method estaVivo() {
		return vive
	}
}