import wollok.game.*
import flappywolbird.*

object teclado{
    method configurar(){
        keyboard.enter().onPressDo({juego.jugar()})
        keyboard.space().onPressDo({juego.saltar()})
        keyboard.space().onPressDo({sonidoFlappy.play()})
    }
}