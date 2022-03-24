### VPC
output "vpc" {
    value = { for key, val in ncloud_vpc.vpc : key => val }
}


### Subnet
output "public_subnet" {
    value = {
        for key, val in ncloud_subnet.public_subnet : key => val
    }
}

output "private_subnet" {
    value = {
        for key, val in ncloud_subnet.private_subnet : key => val
    }
}


### NAT Gateway
output "nat_gateway" {
    value = {
        for key, val in ncloud_nat_gateway.nat_gateway : key => val
    }
}
