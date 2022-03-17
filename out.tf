### VPC
output "vpc_id" {
    value = ncloud_vpc.vpc.id
}
output "vpc_name" {
    value = ncloud_vpc.vpc.name
}
output "vpc_cidr" {
    value = ncloud_vpc.vpc.ipv4_cidr_block
}
output "default_network_acl_no" {
    value = ncloud_vpc.vpc.default_network_acl_no
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
