object centro {
  const pacientes = []
  const aparatos = []
  
  method agregarPacientes(unaLista) {
    pacientes.addAll(unaLista)
  }
  
  method agregarAparats(unaLista) {
    aparatos.addAll(unaLista)
  }
  
  method colorAparatos() = aparatos.map({ a => a.color() }).asSet()
  
  method pacientesMenoresA(unValor) = pacientes.filter(
    { p => p.edad() < unValor }
  )
  
  method cantNoPuedeCumplirRutina() = pacientes.count(
    { p => not p.puedeHacerRutina() }
  )
  
  method optimasCondiciones() = aparatos.all(
    { a => !a.necesitaMantenimiento() }
  )
  
  method cantidadNecesitaMantenimiento() = aparatos.count(
    { a => a.necesitaMantenimiento() }
  )
  
  method estaComplicado() = self.cantidadNecesitaMantenimiento() >= aparatos.size().div(
    2
  )
  
  method aparatosQueNecesitanMantenimiento() {
    self.aparatosQueNecesitanMantenimiento()
  }
  
  method realizarMantenimiento() {
    aparatos.filter({ a => a.necesitaMantenimiento() }).forEach(
      { a => a.realizarMantenimiento() }
    )
  }
}