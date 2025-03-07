# function for most popular air route
#' @export
busiest_routes <- function(df, origin_var, dest_var){
  stopifnot(all(df$Passengers>=1))
  stopifnot(all(!is.na(df$Passengers)))
  # Now, we can see what the most popular air route is, by summing up the number of
  # passengers carried.
  pairs = group_by(df, {{origin_var}}, {{dest_var}}) %>%
    summarize(Passengers=sum(Passengers), distance_km=first(Distance) * KM_PER_MILE)
  arrange(pairs, -Passengers)

  # we see that LAX-JFK (Los Angeles to New York Kennedy) is represented separately
  # from JFK-LAX. We'd like to combine these two. Create airport1 and airport2 fields
  # with the first and second airport in alphabetical order.
  pairs = mutate(
    pairs,location1 = if_else({{origin_var}} < {{dest_var}}, {{origin_var}}, {{dest_var}}),
    location2 = if_else({{origin_var}} < {{dest_var}}, {{dest_var}}, {{origin_var}})
  )

  pairs = group_by(pairs, location1, location2) %>%
    summarize(Passengers=sum(Passengers), distance_km=first(distance_km))

  return(arrange(pairs, -Passengers))
}

# Now, we can compute the market shares
#' @export
biggest_market_share <- function(df, carrier_var, location_var){
  mkt_shares = df %>%
    summarize(Passengers=sum(Passengers),
              .by = c({{carrier_var}}, {{location_var}})) %>%
    mutate(market_share=Passengers/sum(Passengers), total_passengers=sum(Passengers),
           .by = {{location_var}})

  return(mkt_shares)

}
