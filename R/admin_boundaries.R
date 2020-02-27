#' Administrative boundaries
#'
#' Function returning local administrative area boundaries in {sf} package format.
#'
#' Recognized administrative areas are:
#'  \describe{
#'   \item{state}{States of Nigeria.}
#'   \item{lga}{Local Government Areas of Nigeria.}
#'   \item{ward}{Wards of Nigeria.}
#' }
#'
#' @param type one of "ward", "lga" and "state"
#' @return data frame in \code{sf} package format
#' @source \url{https://www.ehealthafrica.org/}
#'
#' @export
#'
#' @examples
#'
#' states <- areas("state")
#' plot(sf::st_geometry(states))
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
