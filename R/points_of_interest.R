#' Points of Interest
#'
#' Function returning POIs in {sf} package format.
#'
#' Recognized points of interest are:
#' \itemize{
#'   \item{"police"} {police stations}
#'   \item{"fuel"} {fuel stations}
#' }
#'
#' @param type one of "police" and "fuel"
#' @return data frame in \code{sf} package format
#' @source \url{https://www.ehealthafrica.org/}
#'
#' @export
#'
#' @examples
#' plot(st_geometry(areas("state")))
#' plot(st_geometry(poi("police")), add = T, pch = 4, col = "red")
#'



poi <- function(type) {

  # translation from argument type to file names on Geoserver
  translator <- c("police" = "sv_police_stations",
                  "fuel" = "sv_fuel_stations")


  if(length(type) != 1) stop("A single type of POI is required !")

  if(!type %in% names(translator)) stop("Unknown POI!")

  data <- downloader(translator[type]) # beware! type is hardcoded to states

  data

}
