#' @export
load_data <- function(air_data_path, carrier_data_path, airport_data_path){
  # first, we need to load the data
  data = readr::read_csv(air_data_path)

  market_ids = readr::read_csv(airport_data_path)
  data = dplyr::left_join(data, dplyr::rename(market_ids, OriginCity="Description"), by=c(OriginCityMarketID="Code"))
  data = dplyr::left_join(data, dplyr::rename(market_ids, DestCity="Description"), by=c(DestCityMarketID="Code"))

  carriers = readr::read_csv(carrier_data_path)
  data = dplyr::left_join(data, dplyr::rename(carriers, OperatingCarrierName="Description"), by=c(OpCarrier="Code"))
  data = dplyr::left_join(data, dplyr::rename(carriers, TicketingCarrierName="Description"), by=c(TkCarrier="Code"))

  return(data)
}
