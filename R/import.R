#' Importer des fichiers Subwork via l'API de Nakala
#'
#' Cette fonction **import()** permet d'importer les fichiers Subwork en utilisant l'API de Nakala : l'utilisateur doit seulement connaître le code et le type du fichier souhaité. Les différents fichiers Subwork sont présentés et décrits dans la documentation (https://nakala.fr/10.34847/nkl.c8caljc9). Aussi, en exécutant **data("fichiers")**, l'utilisateur pourra retrouver, dans un dataframe, la liste des codes de fichiers et leur(s) type(s) associé(s).
#'
#' @param code le code du fichier souhaité (exemple : "FD11", "SH81"...)
#' @param type la nature du fichier souhaité
#'  \itemize{
#'   \item **data** : fichiers de données dont l'extension d'origine est .csv
#'   \item **libvar** : fichiers listant les intitulés des variables (le nom de ces fichiers comprend toujours '_libvar_' et leur extension d'origine est .txt)
#'   \item **geo** : fichiers géographiques dont l'extension d'origine est .geojson
#' }
#'
#' @return le fichier Subwork souhaité, correspondant au code et au type précisés dans la commande : si le type est "geo", l'objet est de type *sf* ; dans les autres cas (type "data" ou "libvar"), l'objet est un *dataframe*.
#'
#' @importFrom httr content GET
#' @importFrom geojsonsf geojson_sf
#' @importFrom sf st_as_sf
#' @importFrom utils read.csv read.table data
#'
#' @export
#'
#' @examples
#' FD11.data <- import(code="FD11",type="data")
#' FD11.libvar <- import(code="FD11",type="libvar")
#' SH51 <- import(code="SH51",type="geo")

import <- function(code,type) {

  # STOP si l'un des arguments est manquant
  if(missing(code)){stop("L'argument 'code' est manquant")}
  if(missing(type)){stop("L'argument 'type' (data, libvar ou geo) est manquant")}

  # Lien URL correspondant au fichier demandé
  data("fichiers")
  lien_url <- fichiers[fichiers$code==code & fichiers$type==type,][["lien_url"]]

  # STOP si le fichier demandé n'existe pas
  if(length(lien_url)==0){stop("Le fichier n'existe pas")}

  if(type=="data") {
    return(read.csv(
      text=content(GET(lien_url),as="text",type="csv",encoding="UTF-8"),
      sep=";"))
  }
  if(type=="libvar") {
    return(read.table(
      text=content(GET(lien_url),as="text",type="txt",encoding="UTF-8"),
      sep=";", header=T))
  }
  if(type=="geo") {
    d <- geojson_sf(content(GET(lien_url)))
    d <- st_as_sf(d)
    return(d)
  }
}
