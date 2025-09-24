run "pet_name_pattern" {
 module {
    source = "../"
  }
 assert {
    condition = can(regex("^dev-[a-z]+$", random_pet.pet.content))
    error_message = "Le nom (${output.pet_name}) ne respecte pas le pattern"
  }
}