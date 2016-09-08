open Eliom_content
open Html5.D
open Utils
open Uid_manager

type ancestry = {
  lastname:   string option;
  firstnames: string list;
  uid:        uid;
  birth:      Coordinates.t;
  father:     uid option;
  mother:     uid option;
}

let make_ancestry ?(birth = Coordinates.empty) ?(father = None) ?(mother = None) lastname firstnames uid_manager =
  let uid, uid_manager = uid_generate uid_manager in
  let ancestry = { lastname   = Some lastname;
                   firstnames = firstnames;
                   uid        = uid;
                   birth      = birth;
                   father     = father;
                   mother     = mother; } in
  ancestry, uid_manager

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
