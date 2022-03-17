### VPC
variable "vpc_name" {
    type = string
}
variable "ipv4_cidr" {
    type    =   string
    default =   "172.22.0.0/16"
}

variable "region" {
    type = string
    default = ""
}


### Subnet
variable "subnet_name" {
    type = string
    default = "tf"
}

variable "public_cidr" {
    type = list
    default = ["172.22.0.0/24","172.22.1.0/24"]
}

variable "private_cidr" {
    type = list
    default = ["172.22.10.0/24","172.22.11.0/24"]
}

variable "subnet_zone" {
    type = list(string)
    default = ["KR-1","KR-2"]
}

variable "subnet_type" {
    type = list(string)
    default = ["PUBLIC","PRIVATE"]
}

variable "usage_type" {
    type = list(string)
    default = ["GEN","LOADB"]
}


### NAT Gateway
variable "ngw_name" {
    type    =   string
    default = "tf-nat-gateway"
}


### Route Table
variable "route_type" {
    type    = list(string)
    default = ["PUBLIC","PRIVATE"]
}

variable "private_rt_name" {
    type    = string
    default = "tf-private-rt"
}