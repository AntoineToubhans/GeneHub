open Utils

type t = {
  year:  int option;
  month: int option;
  day:   int option;
}

let empty = {
  year  = None;
  month = None;
  day   = None;
}

let year year = {
  year  = Some year;
  month = None;
  day   = None;
}

let to_string_short date =
  let eval = option_eval string_of_int ~default:"?" in
  Printf.sprintf "%s/%s/%s" (eval date.day) (eval date.month) (eval date.year)
