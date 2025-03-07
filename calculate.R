devtools::load_all() # load everything in current R package

DATA_PATH <- Sys.getenv("DATA_PATH")

data <- load_data(file.path(DATA_PATH, "air_sample.csv"),
                  file.path(DATA_PATH, "L_CARRIERS.csv"),
                  file.path(DATA_PATH, "L_CITY_MARKET_ID.csv"))

# airport
busiest_routes(data, Origin, Dest)

# city
busiest_routes(data, OriginCity, DestCity)


# marketshare
biggest_market_share(data, OperatingCarrierName, OriginCity)
biggest_market_share(data, TicketingCarrierName, Origin)
