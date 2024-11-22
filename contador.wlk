import wollok.game.*

object contadorRecord {
	var property recordActual = 0 
	var property position = game.at(0, 11) 
	var contando = false

	method text() {
		const minutos = (recordActual / 60).truncate(0)
		const segundos = recordActual % 60
		return self.format(minutos) + ":" + self.format(segundos)
	}

	method format(numero) {
		if (numero < 10) {
			return "0" + numero
		}
		return "" + numero
	}

	method reiniciarRecord() {
		recordActual = 0
		contando = false
	}

	method comenzarCronometro() {
		if (!contando) {
			contando = true
			game.onTick(1000, "incrementarRecord", {
			recordActual = recordActual + 1
		})
		}
	}

	method detenerCronometro() {
		if (recordActual > tiempoRecord.tiempo()){
			tiempoRecord.actualizar()
		}
		contando = false
		game.removeTickEvent("incrementarRecord")
	} 
}

object tiempoRecord {
	var property tiempo = 0 
	const imagen = "record.png" 
	var property position = game.at(11, 11) 

	method image() = imagen
	method actualizar() {
		tiempo = contadorRecord.recordActual()
	}
	method text() {
		const minutos = (tiempo / 60).truncate(0) 
		const segundos = tiempo % 60
		return self.format(minutos) + ":" + self.format(segundos)
	}

	method format(numero) {
		if (numero < 10) {
			return "0" + numero
		}
		return "" + numero
	}
} 