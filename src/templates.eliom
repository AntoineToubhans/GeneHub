[%%shared
    open Eliom_lib
    open Eliom_content
    open Html5.D
    open Ancestry_tree
]

let app_title = "GeneHub"

let css_sheets =
  [
    ["css"; "genehub.css"] ;
  ]

let link_genehub_icon =
  link
    ~href:(make_uri (Eliom_service.static_dir ()) ["icons"; "favicon32.ico"])
    ~rel:[`Icon]
    ()

let genehub_header =
  div ~a:[a_id "genehub-header"] [
    div ~a:[a_class ["genehub-title"]] [
      img ~alt:"icon" ~src:(make_uri (Eliom_service.static_dir()) ["svg"; "favicon.svg"]) ();
      div [pcdata app_title] ;
    ] ;
  ]

let genehub_main_page () =
  let body_elt = body [
    genehub_header ;
    div ~a:[a_id "genehub-main"] [] ;
  ] in
  Eliom_tools.F.html
    ~title:app_title
    ~css:css_sheets
    ~other_head:[link_genehub_icon]
    body_elt
