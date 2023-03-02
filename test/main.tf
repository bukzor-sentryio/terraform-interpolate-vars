module "test-1" {
  source = "../../interpolate-vars"

  text = "$AYY/ohai/$BEE $C"
  values = {
    ayy  = 1
    bee  = "buzz buzz"
    "$C" = "sea"
  }
}


output "test-1" {
  value = module.test-1
}
