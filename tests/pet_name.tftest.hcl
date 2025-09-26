run "pet_name_pattern" {
 module {
    source = "./"
  }
 assert {
    condition = can(regex("^dev-[a-z]+$", output.pet_name))
    error_message = "Le nom (${output.pet_name}) ne respecte pas le pattern"
  }
}
