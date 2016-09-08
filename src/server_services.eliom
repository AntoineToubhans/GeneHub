module GeneHub_app =
  Eliom_registration.App (struct
    let application_name = "GeneHub"
  end)

let main_service =
  Eliom_service.App.service ~path:[""] ~get_params:Eliom_parameter.unit ()
