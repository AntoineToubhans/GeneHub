open Eliom_content
open Html5.D

type location = string
type t

val empty: t
val make: Date.t -> ?place:location option -> t

val to_html: t -> Html5_types.formatblock Eliom_content.Html5.D.elt
