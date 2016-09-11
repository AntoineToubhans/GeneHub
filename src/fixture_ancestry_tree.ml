open Ancestry_tree
open Uid_manager

let uid_manager = uid_manager_init ()

let thierry, uid_manager =
  let birthDate = Date.year 1961 in
  let coordinates = Coordinates.make birthDate ~place:(Some "Nogent sur Marne") in
  make_ancestry ~birth:coordinates "Toubhans" ["Thierry"; "Claude"; "Jean"] uid_manager

let nadine, uid_manager =
  let birthDate = Date.year 1962 in
  let coordinates = Coordinates.make birthDate ~place:(Some "Saint Cloud") in
  make_ancestry ~birth:coordinates "Pupier" ["Nadine"] uid_manager

let me, uid_manager =
  let birthDate = Date.year 1987 in
  let coordinates = Coordinates.make birthDate ~place:(Some "Harfleur") in
  make_ancestry ~birth:coordinates "Toubhans" ["Antoine"] uid_manager

let helene, uid_manager =
  let birthDate = Date.year 1989 in
  let coordinates = Coordinates.make birthDate ~place:(Some "Harfleur") in
  make_ancestry ~birth:coordinates "Toubhans" ["Hélène"] uid_manager
