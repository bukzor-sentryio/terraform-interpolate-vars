terraform {
  required_version = "~> 1.3.9"
  required_providers {
    null = { version = "~> 3.2.1" }
  }
}

variable "text" {
  type = string
}
variable "values" {
  type = map(any)
}


locals {
  placeholder-re = "\\$[A-Z_]+\\b"

  vars = {
    for key, val in var.values :
    join("", ["$", upper(trimprefix(key, "$"))]) => val
  }
  template      = replace(replace(var.text, "%", "%%"), "/${local.placeholder-re}/", "%v")
  template-vars = regexall(local.placeholder-re, var.text)
  template-values = [
    for var in local.template-vars :
    local.vars[var]
  ]

  result = format(local.template, local.template-values...)
}

output "_" {
  value = local.result
}
