### VPC
resource "ncloud_vpc" "vpc" {
 name                     = var.vpc_name
 ipv4_cidr_block          = var.ipv4_cidr
}


### Subnet
data "ncloud_zones" "zones" { region = var.region}
resource "ncloud_subnet" "public_subnet" {
    vpc_no                = ncloud_vpc.vpc.id
    network_acl_no        = ncloud_vpc.vpc.default_network_acl_no
    for_each              = { for k, v in var.public_cidr : k => v if length(var.public_cidr) < 3 }
    subnet                = each.value
    zone                  = data.ncloud_zones.zones.zones[index(var.public_cidr, each.value)].zone_code
    subnet_type           = var.subnet_type[0]
    usage_type            = var.usage_type[0]
    name                  = "${var.subnet_name}-public-subnet-${lower(data.ncloud_zones.zones.zones[index(var.public_cidr, each.value)].zone_code)}"
}

resource "ncloud_subnet" "private_subnet" {
    vpc_no                = ncloud_vpc.vpc.id
    network_acl_no        = ncloud_vpc.vpc.default_network_acl_no
    for_each              = { for k, v in var.private_cidr : k => v if length(var.private_cidr) < 3 }
    subnet                = each.value
    zone                  = data.ncloud_zones.zones.zones[index(var.private_cidr, each.value)].zone_code
    subnet_type           = var.subnet_type[1]
    usage_type            = var.usage_type[0]
    name                  = "${var.subnet_name}-private-subnet-${lower(data.ncloud_zones.zones.zones[index(var.private_cidr, each.value)].zone_code)}"
}

### NAT Gateway
resource "ncloud_nat_gateway" "nat_gateway" {
    count                 = var.enable_ngw ? var.single_ngw ? 1 : length(data.ncloud_zones.zones.zones) : 0
    vpc_no                = ncloud_vpc.vpc.id
    zone                  = data.ncloud_zones.zones.zones[count.index].zone_code
    name                  = "${var.ngw_name}-${lower(data.ncloud_zones.zones.zones[count.index].zone_code)}"
}


### Route Table
resource "ncloud_route_table" "private_route_table" {
    vpc_no                = ncloud_vpc.vpc.id  
    supported_subnet_type = "PRIVATE"
    count                 = length(ncloud_nat_gateway.nat_gateway)
    name                  = "${var.vpc_name}-private-route-${lower(data.ncloud_zones.zones.zones[count.index].zone_code)}"
}

resource "ncloud_route" "private_route" {
    count                 = length(ncloud_nat_gateway.nat_gateway)
    route_table_no          = ncloud_route_table.private_route_table[count.index].id
    destination_cidr_block  = "0.0.0.0/0"
    target_type             = "NATGW"
    target_name             = ncloud_nat_gateway.nat_gateway[count.index].name
    target_no               = ncloud_nat_gateway.nat_gateway[count.index].id

    depends_on              = [ncloud_nat_gateway.nat_gateway]
}

resource "ncloud_route_table_association" "route_table_subnet" {
    count                 = length(ncloud_nat_gateway.nat_gateway)
    route_table_no        = ncloud_route_table.private_route_table[count.index].id
    subnet_no             = ncloud_subnet.private_subnet[count.index].id
}