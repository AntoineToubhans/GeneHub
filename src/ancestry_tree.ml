open Eliom_content
open Html5.D
open Utils

type ancestry = {
  lastname:   string option;
  firstnames: string list;
  uid:        Uid_manager.uid;
  birth:      Coordinates.t;
}

let uid_generator = Uid_manager.init ()

let me =
  let myBirthDate = Date.year 1987 in
  let myCoordinates = Coordinates.make myBirthDate "Harfleur" in
  let uid = Uid_manager.generate uid_generator in
  {
    lastname   = Some "Toubhans";
    firstnames = ["Antoine"];
    uid        = uid;
    birth      = myCoordinates;
  }

let helene =
  let birthDate = Date.year 1989 in
  let coordinates = Coordinates.make birthDate "Harfleur" in
  let uid = Uid_manager.generate uid_generator in
  {
    lastname   = Some "Toubhans";
    firstnames = ["Hélène"];
    uid        = uid;
    birth      = coordinates;
  }

let thierry =
  let birthDate = Date.year 1961 in
  let coordinates = Coordinates.make birthDate "Nogent sur Marne" in
  let uid = Uid_manager.generate uid_generator in
  {
    lastname   = Some "Toubhans";
    firstnames = ["Thierry"; "Claude"; "Jean"];
    uid        = uid;
    birth      = coordinates;
  }

let nadine =
  let birthDate = Date.year 1962 in
  let coordinates = Coordinates.make birthDate "Saint Cloud" in
  let uid = Uid_manager.generate uid_generator in
  {
    lastname   = Some "Pupier";
    firstnames = ["Nadine"];
    uid        = uid;
    birth      = coordinates;
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
