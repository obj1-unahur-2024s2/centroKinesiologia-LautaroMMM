class Paciente {
  var edad
  var fortalezaMuscular
  var dolor
  const rutina = []
  
  method edad() = edad
  
  method cargarRutina(unaLista) {
    rutina.clear()
    rutina.addAll(unaLista)
  }
  
  method cumplirAnios() {
    edad += 1
  }
  
  method puedeHacerRutina() = rutina.all({ a => self.puedeUsar(a) })
  
  method realizarRutina() {
    rutina.forEach({ a => self.usar(a) })
  }
  
  method fortalezaMuscular() = fortalezaMuscular
  
  method dolor() = dolor
  
  method disminuirDolor(unValor) {
    dolor = 0.max(dolor - unValor)
  }
  
  method aumentarFortaleza(unValor) {
    fortalezaMuscular += unValor
  }
  
  method puedeUsar(unAparato) = unAparato.puedeSerUsadorPor(self)
  
  method usar(unAparato) {
    if (self.puedeUsar(unAparato)) unAparato.consecuenciaDeUso(self)
  }
}

class Resistente inherits Paciente {
  override method realizarRutina() {
    const cantidad = rutina.count({ a => self.puedeUsar(a) })
    super()
    self.aumentarFortaleza(cantidad)
  }
}

class Caprichoso inherits Paciente {
  override method puedeHacerRutina() = self.hayAlgunAparatoRojo() and super()
  
  method hayAlgunAparatoRojo() = rutina.any({ a => a.color() == "rojo" })
  
  override method realizarRutina() {
    super()
    super()
  }
}

class RecuperacionRapida inherits Paciente {
  override method realizarRutina() {
    super()
    self.disminuirDolor(disminucionDeDolor.valor())
  }
}

object disminucionDeDolor {
  var property valor = 3
}

class Aparato {
  var property color = "blanco"
  
  method recibirMantenimiento() {
    
  }
  
  method consecuenciaDeUso(unPaciente)
  
  method necesitaMantenimiento() = false
  
  method puedeSerUsadorPor(unPaciente)
}

class Magneto inherits Aparato {
  var magneto = 800
  
  override method consecuenciaDeUso(unPaciente) {
    unPaciente.disminuirDolor(unPaciente.dolor() * 0.1)
    magneto -= 1
  }
  
  override method necesitaMantenimiento() = magneto < 100
  
  override method recibirMantenimiento() {
    magneto = 800.min(magneto + 500)
  }
  
  override method puedeSerUsadorPor(unPaciente) = true
}

class Bici inherits Aparato {
  var tornillos = 0
  var aceite = 0
  
  override method consecuenciaDeUso(unPaciente) {
    self.uso(unPaciente)
    unPaciente.disminuirDolor(4)
    unPaciente.aumentarFortaleza(3)
  }
  
  method uso(unPaciente) {
    if (unPaciente.dolor() > 30) {
      tornillos += 1
    }
    if (unPaciente.edad().between(30, 50)) {
      aceite += 1
    }
  }
  
  override method necesitaMantenimiento() = (tornillos >= 10) or (aceite >= 5)
  
  override method puedeSerUsadorPor(unPaciente) = unPaciente.edad() > 8
}

class MiniTramp inherits Aparato {
  override method consecuenciaDeUso(unPaciente) {
    unPaciente.aumentarFortaleza(unPaciente.edad() * 0.1)
  }
  
  override method recibirMantenimiento() {
    
  }
  
  override method puedeSerUsadorPor(unPaciente) = unPaciente.dolor() < 20
}