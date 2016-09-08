open Uid_manager

type ancestry

val make_ancestry: ?birth:Coordinates.t
  -> ?father:uid option
  -> ?mother:uid option
  -> string
  -> string list
  -> uid_manager
  -> ancestry * uid_manager

val to_html: ancestry -> Html5_types.formatblock Eliom_content.Html5.D.elt
