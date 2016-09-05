[%%shared
    open Eliom_lib
    open Eliom_content
    open Html5
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

let widgetService =
  Eliom_service.App.service ~path:["widget"] ~get_params:Eliom_parameter.unit ()

let addHeadToBody (body: Html5_types.body Html5.elt): Html5_types.html Html5.elt =
  Eliom_tools.F.html
    ~title: "GeneHub"
    ~css: [["css"; "GeneHub.css"]]
    body

let registerBasicService service bodyTemplate =
  GeneHubApp.register ~service:service (fun () () -> Lwt.return (addHeadToBody bodyTemplate))

let baseTemplate (titleText: string) linkText linkService =
  body [
    h2 [pcdata titleText];
    div [a ~service:linkService [pcdata linkText] ()];
    div [a ~service:loginService [pcdata "login"] ()];
  ]

let loginTemplate =
  body [
    input ~a:[a_class ["login"]; a_placeholder "Enter your email";] ();
  ]

[%%client
    let switch_visibility elt =
      let elt = To_dom.of_element elt in
      if Js.to_bool (elt##.classList##contains (Js.string "hidden")) then
        elt##.classList##remove (Js.string "hidden")
      else
        elt##.classList##add (Js.string "hidden")

    let clientWidget s1 s2 =
      let button = div ~a:[a_class ["button"]] [pcdata s1] in
      let content = div ~a:[a_class ["content"]] [pcdata s2] in
      Lwt.async (fun () ->
        Lwt_js_events.clicks (To_dom.of_element button)
          (fun _ _ -> switch_visibility content; Lwt.return ()));
      div ~a:[a_class ["widget"]] [button; content]

    let _ =
      let%lwt _ = Lwt_js_events.onload () in
      Dom.appendChild
        (Dom_html.document##.body)
        (To_dom.of_element (clientWidget "Click me" "Client side"));
      Lwt.return ()
]

let serverWidget s1 s2 =
  let button = div ~a:[a_class ["button"]] [pcdata s1] in
  let content = div ~a:[a_class ["content"]] [pcdata s2] in
  let _ = [%client
    (Lwt.async (fun () ->
       Lwt_js_events.clicks (To_dom.of_element ~%button)
         (fun _ _ -> switch_visibility ~%content; Lwt.return ()))
     : unit)
  ] in
  div ~a:[a_class ["widget"]] [button; content]

let widgetTemplate =
  body [
    h2 [pcdata "Welcome to Ocsigen!"];
    serverWidget "Click me" "Server side"
  ]

let () =
  registerBasicService mainService (baseTemplate "Welcome !" "Check this out" otherService);
  registerBasicService otherService (baseTemplate "BoooOOooo" "Back" mainService);
  registerBasicService loginService loginTemplate;
  registerBasicService widgetService widgetTemplate
