type uid = int
type uid_manager = int

let uid_manager_init () = 0

let uid_generate x = x, x + 1
let uid_free i x = if i + 1 = x then i else x
