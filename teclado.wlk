import wollok.game.*
import flappywolbird.*

object teclado{
    method configurar(){
        keyboard.space().onPressDo({juego.jugar()})
    }
}