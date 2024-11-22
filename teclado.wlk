import wollok.game.*
import configuracion.*

object teclado {
    method configurar() {
        keyboard.s().onPressDo({juego.modoNormal()})
        keyboard.v().onPressDo({juego.modoTurbo()})
        keyboard.x().onPressDo({juego.controles()})
        keyboard.z().onPressDo({juego.iniciar()})
        keyboard.space().onPressDo({juego.saltar()})
        keyboard.space().onPressDo({sonidoFlappy.play()})
    }
}