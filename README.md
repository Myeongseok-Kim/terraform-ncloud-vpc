# Usage
module "vpc" {
	source = "Myeongseok-Kim/vpc/ncloud"

// VPC
    vpc_name        =   "tf-vpc"
    ipv4_cidr       =   "172.22.0.0/16"

// Subnet
    subnet_name     =   "tf"	                                // Name: {subnet_name}-public-subnet-{zone_code}, subnet_name}-private-subnet-{zone_code}
    public_cidr     =   ["172.22.0.0/24", "172.22.1.0/24"]		// Min: 1, Max: 2(Create each in two zones)
    private_cidr    =   ["172.22.10.0/24", "172.22.11.0/24"] 	// Min: 1, Max: 2(Create each in two zones)

// NAT Gateway
    enable_ngw      =   true
    single_ngw      =   true		                            // if false, Create each in two zones
    ngw_name        =   "tf-ngw"

}