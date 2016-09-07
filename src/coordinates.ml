open Eliom_content
open Html5.D

type location = string
type t = {
  date:  Date.t;
  place: location;
}

let make date place = {
  date;
  place;
}

let to_html x =
  div [
    div [
      pcdata "Date:" ;
      pcdata (Date.to_string_short x.date) ;
    ] ;
    div [
      pcdata (Printf.sprintf "Place: %s" x.place) ;
    ] ;
  ]
