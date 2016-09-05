[%%shared
    open Eliom_lib
    open Eliom_content
    open Html5.D
]

module GeneHubApp =
  Eliom_registration.App (
    struct
      let application_name = "GeneHub"
    end)

let mainService =
  Eliom_service.App.service ~path:[] ~get_params:Eliom_parameter.unit ()

let otherService =
  Eliom_service.App.service ~path:["plop"] ~get_params:Eliom_parameter.unit ()

let loginService =
  Eliom_service.App.service ~path:["login"] ~get_params:Eliom_parameter.unit ()

let addHeadToBody (body: Html5_types.body Html5.elt): Html5_types.html Html5.elt =
  Eliom_tools.F.html
    ~title: "GeneHub"
    ~css: [["css"; "GeneHub.css"]]
    body

let registerBasicService service bodyTemplate =
  GeneHubApp.register ~service:service (fun () () -> Lwt.return (addHeadToBody bodyTemplate))

let baseTemplate (titleText: string) linkText linkService =
  Html5.F.(body [
    h2 [pcdata titleText];
    div [a ~service:linkService [pcdata linkText] ()];
    div [a ~service:loginService [pcdata "login"] ()];
  ])

let loginTemplate =
  Html5.F.(body [
    input ~a:[a_class ["login"]; a_placeholder "Enter your email";] ();
  ])

let () =
  registerBasicService mainService (baseTemplate "Welcome !" "Check this out" otherService);
  registerBasicService otherService (baseTemplate "BoooOOooo" "Back" mainService);
  registerBasicService loginService loginTemplate
