type uid
type uid_manager

val uid_manager_init: unit -> uid_manager

val uid_generate: uid_manager -> uid * uid_manager
val uid_free: uid -> uid_manager -> uid_manager
