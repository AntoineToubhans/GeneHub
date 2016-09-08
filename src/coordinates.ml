open Eliom_content
open Html5.D
open Utils

type location = string
type t = {
  date:  Date.t;
  place: location option;
}

let empty = {
  date  = Date.empty;
  place = None
}

let make date ?(place = None) = {
  date;
  place;
}

let to_html x =
  div [
    div [
      pcdata "Date: " ;
      pcdata (Date.to_string_short x.date) ;
    ] ;
    div [
      pcdata (Printf.sprintf "Place: %s" (option_eval (fun s -> s) ~default:"" x.place)) ;
    ] ;
  ]
