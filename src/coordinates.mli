open Eliom_content
open Html5.D

type location = string
type t

val make: Date.t -> location -> t

val to_html: t -> Html5_types.formatblock Eliom_content.Html5.D.elt
