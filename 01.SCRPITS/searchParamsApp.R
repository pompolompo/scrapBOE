# Metadata ----------------------------------------------------------------
# w.b: Ferran Garcia, @pompolompo
# w.o: 2024-07-24
# purpose: 
# description: 


# Libraries ---------------------------------------------------------------
library(shiny)


# RadioButtons: Names and Values ------------------------------------------
tipoSubasta <- list(
  names = c("Todos", "Judicial", "Notarial", "AEAT", "Otras Admin Tributarias", "Otras Admin Generales"),
  selectors = paste0("#idOrigen", c("Todos", "J", "N", "A", "G"))
)

estadoSubasta <- list(
  names = c("Cualquiera", "Prox. apertura", "Celebrándose", "Suspendida",
            "Concluida en el Portal de Subastas", "Finalizada por Autoridad Gestora"),
  selectors = paste0("#idEstado", c("Todos", "PU", "EJ", "SU", "CA", "PC", "FS"))
)

tipoBien <- list(
  names = c("Todos", "Inmuebles", "Vehículos", "Otros bienes muebles"),
  
)

subtipoBien <- list(
  inmuebles = list(
    names = c("Todos", "Vivienda", "Local comercial", "Garaje", "Trastero", 
              "Nave industrial", "Solar", "Finca rústica", "Otros"),
    selectors = paste0("#idSubtipoBien", c("ITodos", "501", "502", "503", "504", 
                                           "505", "506", "507", "599"))
  ),
  vehiculos = list(
    names = c("Todos", "Turismos", "Industriales", "Otros"),
    selectors = c("Todos", "9101", "9102", "9103")
  ),
  otros = list(
    names = c("Todos", "Aeronaves", "Buques", "Concesiones administrativas", 
              "Derechos de propiedad industrial", "Derechos de propiedad intelectual", 
              "Derechos de traspaso", "Instalaciones", "Joyas, obras de arte y antigüedades", 
              "Maquinaria", "Mercaderídas y materias primas", "Mobiliario", "Tarjetas de transporte", 
              "Tranvía", "Utensilios y herramientas", "Vagón", "Otros bienes y derechos"),
    selectors = c("OTodos", "13", "14", "18", "4", "3", "1", "2", "17", "5", "8", "7", "11", "16", "6", "15", "99")
  )
)

provincia <- list(
  names = c("Todas", "Araba/Álava", "Albacete", "Alicante/Alacant", "Almería", 
            "Ávila", "Badajoz", "Illes Balears", "Barcelona", "Burgos", "Cáceres", 
            "Cádiz", "Castellón/Castelló", "Ciudad Real", "Córdoba", "A Coruña", 
            "Cuenca", "Girona", "Granada", "Guadalajara", "Gipuzkoa", "Huelva", 
            "Huesca", "Jaén", "León", "Lleida", "La Rioja", "Lugo", "Madrid", 
            "Málaga", "Murcia", "Navarra", "Ourense", "Asturias", "Palencia", 
            "Las Palmas", "Pontevedra", "Salamanca", "Santa Cruz de Tenerife", 
            "Cantabria", "Segovia", "Sevilla", "Soria", "Tarragona", "Teruel", 
            "Toledo", "Valencia/València", "Valladolid", "Bizkaia", "Zamora", 
            "Zaragoza", "Ceuta", "Melilla", "No consta"),
  selectors = c("01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", 
                "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", 
                "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", 
                "34", "35", "36", "37", "38", "39", "40", "41", "42", "43", "44", 
                "45", "46", "47", "48", "49", "50", "51", "52", "00")
)

# UI ----------------------------------------------------------------------
ui <- fluidPage(
  column(
    width = 3,
    title = "Tipo de subasta",
    radioButtons(
      inputId = "tipoSubasta",
      choiceNames = tipoSubasta$names,
      choiceValues = tipoSubasta$selectors
    ),
    uiOutput("autoridadGestora")
  ),
  column(
    witdth = 3,
    title = "Estado de subasta",
    radioButtons(
      inputId = "estadoSubasta",
      choiceNames = estadoSubasta$names,
      choiceValues = estadoSubasta$selectors
    )
  ),
  column(
    width = 3,
    title = "Tipo de bien",
    radioButtons(
      inputId = "tipoBien",
      choiceNames = ,
      choiceValues = 
    )
  )
)