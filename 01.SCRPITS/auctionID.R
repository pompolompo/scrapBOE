# Metadata ----------------------------------------------------------------
# w.b: Ferran Garcia, @pompolompo
# w.o: 25-07-2024
# purpose: retrieve auctionID from a result list

# Global Options ----------------------------------------------------------
idSearch <- "_NDNlWkY3VXdMK2JLVnF3czVGNnNqTUhkUzF1TGNuanErb3ZERVQ1NTg5M3luRk85Mk9JQXNuRW5CbXd3RjV5aTNodEJqZEowa0tNdmkrMDlKSXJ6WW1IZWNiZHFOK3pnd0dIRG5Zd1RnbzlSeWFjZVdXcDZLWGJiOEV0TnYwUUhFQVh3R3lUd3l2VWhueEg2ZnVqZmhOVHR5bm5xUnp0TkRvSVowZTNhdWZUcGdwa1J0T3Z5cHk5Z2FHc1puc2ZBR0VWVTlQSitsRXBrZklIMG9XTUViZk03eHg3RzJQZTk2RUtJZXpBakNsRXdtTGx5cUNDZUhKb05VUmFxaFAzVEJFUVkxK1d6ZW44VFZMQW0yQmZwZHJ2V09NNDRDR09XNDY0SlpVRlZyazFURzhLQ29pS0U4WXJCRVk5THVCU2o"

# Libraries ---------------------------------------------------------------
library(rvest)
library(stringr)

# Get AuctionID -----------------------------------------------------------
htmlSearch <- paste0(
  "https://subastas.boe.es",
  "/subastas_ava.php?accion=Mas",
  "&id_busqueda=", idSearch, "-0-500-"
) |> read_html("windows-1252")

auctionNum <- htmlSearch |> 
  html_elements("div.paginar:nth-child(3) > p") |> 
  html_text2() |> 
  str_extract("\\d{1,3}(\\.\\d{3})*$") |> 
  str_remove("\\.") |> 
  as.integer()

auctionID <- htmlSearch |> 
  html_elements("li.resultado-busqueda h3") |> 
  html_text2() |> 
  str_remove("SUBASTA ") |> 
  str_remove(" .*")

while(length(auctionID) < auctionNum){
  auctionID <- paste0(
    "https://subastas.boe.es",
    "/subastas_ava.php?accion=Mas",
    "&id_busqueda=", idSearch, 
    "-", length(auctionID),"-", 500,"-"
  ) |> read_html("windows-1252") |> 
    html_elements("li.resultado-busqueda h3") |> 
    html_text2() |> 
    str_remove("SUBASTA ") |> 
    str_remove(" .*") |> 
    c(auctionID)
}
