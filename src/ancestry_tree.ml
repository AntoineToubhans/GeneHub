open Eliom_content
open Html5.D
open Utils

type ancestry = {
  lastname:   string option;
  firstnames: string list;
  uid:        int;
  birth:      Coordinates.t;
}

let me =
  let myBirthDate = Date.year 1987 in
  let myCoordinates = Coordinates.make myBirthDate "Harfleur" in
  {
    lastname   = Some "Toubhans";
    firstnames = ["Antoine"];
    uid        = 0;
    birth      = myCoordinates;
  }

let to_html ancestry =
  let html_lastname =
    match ancestry.lastname with
    | None      -> []
    | Some name -> [div [pcdata name]] in
  let html_firstnames =
    match ancestry.firstnames with
    | []         -> []
    | firstnames -> [div [pcdata (list_2str (fun s -> s) firstnames)]] in
  div (html_lastname @ html_firstnames @ [Coordinates.to_html ancestry.birth])
