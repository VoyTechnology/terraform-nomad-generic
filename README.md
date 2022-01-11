# Generic Nomad Job Terraform Module

> STILL IN HEAVY DEVELOPMENT. SOME FEATURES ARE MISSING

Did you know that you can easily provision a nomad job Terraform? The only
disadvantage is that you are writing the job over and over. This module
provides an a slightly opinonated jobspec, where you can just fill in a couple
of variables and you are deploying.

## Usage

```tf
// Make sure to init the provider

module "http-echo" {
  source = "https://github.com/Voytechnology/terraform-nomad-generic"

  job_name = "generic"
  image = "hashicorp/http-echo"
}
```
