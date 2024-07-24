# Metadata ----------------------------------------------------------------
# w.b: Ferran Garcia, @pompolompo
# w.o: 2024-07-24
# purpose: submit search parameters and return searchID
# description: 2 types of parameters...
#   ...clickeable --> css_selector
#   ...not_clickeable --> querySelector(css_selector).value = X
# to do: solve 'too much results problem' --> divide interval and iterate


# Global Options ----------------------------------------------------------
urlBase <- "https://subastas.boe.es/subastas_ava.php"

# Libraries ---------------------------------------------------------------
library(selenider)
library(stringr)

# Parameter Specification -------------------------------------------------

## Click ------------------------------------------------------------------
paramClick <- list(
  tipoSubasta = "#idOrigenJ",
#  estadoSubasta = "#idEstadoPU",
  tipoBien = "#idTipoBienI",
  subtipoBien = "#idSubtipoBien501"
)

## querySelector ----------------------------------------------------------
paramQSelect <- list(
  '#hastaFP' = "2024-01-01",
  '#desdeFP' = "2023-01-01",
  '#hastaIP' = "yyyy-mm-dd",
  '#desdeIP' = "yyyy-mm-dd",
  
  '#BIEN\\\\.COD_PROVINCIA' = "11"
)


# Selenider Session -------------------------------------------------------
sesh <- selenider_session(
  session = "chromote",
  timeout = 10
)
open_url(urlBase)


# Form Modification -------------------------------------------------------

## Click ------------------------------------------------------------------
lapply(paramClick, function(x) s(x) |> elem_click())


## querySelector ----------------------------------------------------------
for(i in 1:length(paramQSelect)){
  x <- paramQSelect[i]
  js <- paste0(
    "document.querySelector('", names(x), 
    "').value = '", x, "';"
  )
  sesh$driver$Runtime$evaluate(js)
}

# Send Form ---------------------------------------------------------------
s("input.boton") |> 
  elem_click()

idSearch <- s(".current") |> 
  elem_attr(name = "href") |> 
  str_extract("&id_busqueda=.*") |> 
  str_remove("&id_busqueda=") |> 
  str_remove("(,?,?)?-\\d.*")

close_session(sesh)

# Browse searchID ---------------------------------------------------------
paste0(urlBase, "?accion=Mas&id_busqueda=", idSearch, "-0-500") |> 
  browseURL()
