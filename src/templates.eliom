[%%shared
    open Eliom_lib
    open Eliom_content
    open Html5.D
    open Ancestry_tree
]

let app_title = "GeneHub"

let css_sheets =
  [
    ["css";"GeneHub.css"]
  ]

let link_genehub_icon =
  link
    ~href:(make_uri (Eliom_service.static_dir ()) ["icons"; "favicon32.ico"])
    ~rel:[`Icon]
    ()

let make_page =
  Eliom_tools.F.html
    ~title:app_title
    ~css:css_sheets
    ~other_head:[link_genehub_icon]

let main_body =
  body [
    h2 [pcdata "GeneHub"] ;
    Ancestry_tree.to_html Fixture_ancestry_tree.thierry ;
  ]
