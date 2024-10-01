variable "credentials"{
    type =file
}
variable "project_id"{
    type = string
    default = "your-porject-id"
}
variable "compute_instance_name"{
    type = string
    default = "your_compute_instance_name"
}
variable "machine_type"{
    type= string
    default = "your_machine_type"
}