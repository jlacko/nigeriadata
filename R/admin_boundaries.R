#' Administrative boundaries
#'
#' This is a function returning admin area boundaries
#'
#' @param type one of
#'
#' @return data frame
#' @export
#'
#' @examples
#'
#' states <- areas("state")
#' plot(sf::st_geometry(states))
#'
#'

areas <- function(type) {

  # translation from argument type to file names on Geoserver
  translator <- c("ward" = "sv_wards",
                  "lga" = "sv_local_government_areas",
                  "state" = "sv_states")


  if(length(type) != 1) stop("A single type of admin area is required !")

  if(!type %in% names(translator)) stop("Unknown administrative area!")

  data <- downloader(translator[type]) # beware! type is hardcoded to states

  data

}
