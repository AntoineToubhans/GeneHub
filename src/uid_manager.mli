type uid
type t

val init: unit -> t

val generate: t -> uid
val free: uid -> t -> unit
