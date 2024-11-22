import wollok.game.*
import teclado.*
import bird.*
import contador.*
import obstaculos.*

object juego {
    var fondoJuego = new Fondo(img = "inicio1.gif")

    method configurar() {
        game.width(12)
        game.height(12)
        game.cellSize(50)
        teclado.configurar()
        self.iniciar()
    }

    method iniciar() {
        fondoJuego = new Fondo(img = "inicio1.gif")
        game.addVisual(fondoJuego)
    }

    method controles() {
        fondoJuego = new Fondo(img = "controles1.gif")
        game.addVisual(fondoJuego)
    }

    method saltar() {
        if (flappybird.estaVivo()) {
            flappybird.saltar()
        } else {
            self.iniciar()
        }
    }

    method modoNormal() {
        fondoJuego = new Fondo(img = "fondo2d.jpg")
        game.addVisual(fondoJuego)
        game.addVisual(flappybird)
        flappybird.iniciar()

        game.addVisual(contadorRecord)
        game.addVisual(tiempoRecord)
        contadorRecord.reiniciarRecord()
        contadorRecord.comenzarCronometro()

        self.generarNuevoPajaro()
        self.generarNuevoPajaroRojo()

        game.onCollideDo(flappybird, {obstaculo => self.gameOver()})
    }

    method modoTurbo() {
        //...
    }

    method gameOver() {
        flappybird.muere()
        contadorRecord.detenerCronometro()
    
        game.removeTickEvent("caida")
        game.removeVisual(flappybird)
        game.removeVisual(contadorRecord)
        game.removeVisual(tiempoRecord)

        flappybird.position(game.at(5,5))
        fondoJuego = new Fondo(img = "gameOverr.gif")
        game.addVisual(fondoJuego)
        sonidoGameOver.play()

        game.removeTickEvent("desplazamiento")
        game.removeTickEvent("nuevoTubo")
        game.removeTickEvent("nuevoPajaro")
        game.removeTickEvent("nuevoPajaroRojo")
    }

    method generarNuevoTubo() {
        game.onTick(4000, "nuevoTubo", {
            const nuevoTubo = new Pipe()
            game.addVisual(nuevoTubo)
            nuevoTubo.iniciar()
        game.whenCollideDo(flappybird, {self.gameOver()})
        })
    }

    method generarNuevoPajaro() {
        game.onTick(4000, "nuevoPajaro", {
            const nuevoPajaro = new Pajaro()
            game.addVisual(nuevoPajaro)
            nuevoPajaro.iniciar()
            game.whenCollideDo(flappybird, {self.gameOver()})
        })
    }

    method generarNuevoPajaroRojo() {
        game.onTick(4000, "nuevoPajaroRojo", {
            const nuevoPajaroRojo = new PajaroRojo()
            game.addVisual(nuevoPajaroRojo)
            nuevoPajaroRojo.iniciar()
            game.whenCollideDo(flappybird, {self.gameOver()})
        })
    }
}

class Fondo {
    const img
    var property position = game.origin()
    method image() = img
}

object sonidoFlappy {
	method play() {
		game.sound("saltar.mp3").play()
	}
}

object sonidoGameOver {
	method play() {
		game.sound("sonidoGameOver.mp3").play()
	}
}

object musica1 {
    var property activada = true
    method play() {
        if (activada) {
            game.sound("musica1.mp3").play()
        }
    }

    method detener() {
        activada = false
    }
}

object suelo {
	method position() = game.origin().up(1)
}