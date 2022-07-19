# Copyright 2021 Wojtek Bednarzak
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

resource "nomad_job" "job" {
    jobspec = local.jobspec
}

locals {
    jobspec = templatefile("${path.module}/job.nomad", {
        job_name     = var.job_name,
        datacenters  = jsonencode(var.datacenters),
        region       = var.region,
        namespace    = var.namespace,
        constraints  = var.constraints,
        image        = var.image,
        args         = jsonencode(var.args),
        env          = var.env,
        ports        = var.ports,
        cpu          = var.cpu,
        memory       = var.memory,
        service_port = var.service_port,
        service_tags = jsonencode(var.service_tags),
        template_files = var.template_files,
        volumes      = jsonencode(var.volumes)
        network_mode = var.network_mode,

        docker_network_mode = var.docker_network_mode,
        docker_username         = var.docker_username
        docker_password         = var.docker_password
    })
}
