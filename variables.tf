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

variable "job_name" {
  type        = string
  description = "Name of the job"
}

variable "datacenters" {
  type        = list(string)
  description = "List of datacenters"
  default     = ["dc1"]
}

variable "region" {
  type        = string
  description = "Region to deploy to"
  default     = "global"
}

variable "namespace" {
  type        = string
  description = "Namespace to deploy to"
  default     = "default"
}

variable "image" {
  type        = string
  description = "Image to deploy"
}

variable "args" {
  type        = list(string)
  description = "Arguments to execute"
}

variable "env" {
  type        = map(string)
  description = "Environment variables"
  default     = {}
}

variable "ports" {
  # Mapping of port name to "static" or "to" properties
  type = map(object({
    static       = number
    to           = number
    host_network = string
  }))
  default = {
    "http" = {
      static       = 0
      to           = 0
      host_network = ""
    }
  }
  description = "Mapping of port name to port object"
}

variable "cpu" {
  type = number
  description = "Number of Mhz assigned"
  default = 50
}

variable "memory" {
  type = number
  description = "Memory in MB"
  default = 50
}

variable "constraints" {
  type = list(object({
    attribute = string
    operator  = string
    value     = string
  }))
  description = "Constraints of the job"
}

variable "service_port" {
  type = string
  description = "Service port name, must be one declared in ports"
}

variable "service_tags" {
  type = list(string)
  description = "Tags of the service"
  default = []
}

variable "template_files" {
  type = list(object({
    data = string
    destination = string
    change_mode = string
    change_signal = string
  }))
  description = "Template files to be rendered"
  default = []
}


variable "volumes" {
  type = list(string)
  description = "Volumes to be mounted"
  default = []
}

variable "network_mode" {
  type = string
  description = "Network mode"
  default = "host"
}

variable "docker_network_mode" {
  type = string
  description = "Docker config network mode"
  default = ""
}
