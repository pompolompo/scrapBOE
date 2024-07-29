# Metadata ----------------------------------------------------------------
# w.b: Ferran Garcia, @pompolompo
# w.o: 2024-07-29
# purpose: function to get searchID parameters return searcID(s)
# description: recursive, guesses time intervals if too much results,
#              uses finalization date as filter, not start date 

# Libraries ---------------------------------------------------------------
library(stringr)
library(selenider)
library(rvest)


# Auxiliar Functions ------------------------------------------------------
source("99.FUNCTIONS_AUX/newDates.R")


# Definition --------------------------------------------------------------
getSearchID <- function(
    paramsCK = c("#idOrigenJ", "#idTipoBienI", "#idSubtipoBien501"), 
    paramsJS = c('#desdeFP' = "2024-01-01", '#hastaFP' = "2025-12-31"), 
    sesh = selenider_session("chromote"),
    recursive = FALSE
    ){
  searchID <- character(0)
  if(!recursive){
    on.exit(close_session(sesh))
    open_url("https://subastas.boe.es/subastas_ava.php", session = sesh)
    lapply(paramsCK, function(x) s(x) |> elem_click())
  }else{
    selenider::back(session = sesh)
  }

  for(i in 1:length(paramsJS)){
    x <- paramsJS[i]
    js <- paste0(
      "document.querySelector('", names(x), 
      "').value = '", x, "';"
    )
    sesh$driver$Runtime$evaluate(js)
  }
  
  s("input.boton") |> 
    elem_click()
  status <- s("#contenido") |> 
    read_html(encoding = "windows-1252") |> 
    html_elements("#contenido > div.caja.gris") |> 
    html_text()
  
  if(length(status) == 0){
    searchID <- s(".current") |> 
      elem_attr(name = "href") |> 
      str_extract("&id_busqueda=.*") |> 
      str_remove("&id_busqueda=") |> 
      str_remove("(,?,?)?-\\d.*")
  }else{
    if(str_detect(status, "ERROR:")){
      intDates <- newDates(
        startDate = paramsJS[str_detect(names(paramsJS), "#desdeFP")],
        endDate = paramsJS[str_detect(names(paramsJS), "#hastaFP")]
      ) |> lapply(setNames, c("#desdeFP", "#hastaFP"))
      for(d in intDates){
        cat("Interval", d, "\n")
        searchID <- c(searchID, getSearchID(
          paramsJS = unlist(d), sesh = sesh, recursive = TRUE
          )
        )
      }
    } 
  }
  return(searchID)
}
