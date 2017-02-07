# -----------------------------------------------------------------------------
#  Input Variables
# -----------------------------------------------------------------------------

variable "system" {}
variable "stack" {}
variable "branch" {}
variable "security_context" {}
variable "network" { type = "map" }
variable "nat" { type = "map" }

# -----------------------------------------------------------------------------
#  Resources
# -----------------------------------------------------------------------------

resource "aws_vpc" "main_vpc" {
    cidr_block = "${var.network["cidr_prefix"]}.0.0/16"
    instance_tenancy = "default"
    tags = {
        Name = "${var.system}_${var.branch}_main_vpc"
        System = "${var.system}"
        Stack = "${var.stack}"
        Branch = "${var.branch}"
        Resource = "main_vpc"
    }
}

resource "aws_internet_gateway" "igw" {
    vpc_id = "${aws_vpc.main_vpc.id}"
    tags = {
        Name = "${var.system}_${var.branch}_igw"
        System = "${var.system}"
        Stack = "${var.stack}"
        Branch = "${var.branch}"
        Resource = "igw"
    }
}


resource "aws_route_table" "public_route_table" {
    vpc_id = "${aws_vpc.main_vpc.id}"
    route {
        cidr_block = "0.0.0.0/0"
         gateway_id = "${aws_internet_gateway.igw.id}"
    }
    tags {
        Name = "${var.system}_${var.branch}_public"
        System = "${var.system}"
        Stack = "${var.stack}"
        Branch = "${var.branch}"
        Resource = "public_route_table"
    }
}

module "nat_security" {
    source = "./nat-security"
    system = "${var.system}"
    stack = "${var.stack}"
    branch = "${var.branch}"
    security_context = "${var.security_context}"
    vpc_id = "${aws_vpc.main_vpc.id}"
    network_prefix = "${var.network["cidr_prefix"]}"
}

module "nat_az1" {
    source = "./nat"
    index = "1"
    system = "${var.system}"
    stack = "${var.stack}"
    branch = "${var.branch}"
    security_context = "${var.security_context}"
    vpc_id = "${aws_vpc.main_vpc.id}"
    route_table_id = "${aws_route_table.public_route_table.id}"
    cidr_prefix = "${var.network["cidr_prefix"]}"
    az = "${var.network["az1"]}"
    security_group_id = "${module.nat_security.security_group_id}"
    nat = "${var.nat}"
}
module "nat_az2" {
    source = "./nat"
    index = "2"
    system = "${var.system}"
    stack = "${var.stack}"
    branch = "${var.branch}"
    security_context = "${var.security_context}"
    vpc_id = "${aws_vpc.main_vpc.id}"
    route_table_id = "${aws_route_table.public_route_table.id}"
    cidr_prefix = "${var.network["cidr_prefix"]}"
    az = "${var.network["az2"]}"
    security_group_id = "${module.nat_security.security_group_id}"
    nat = "${var.nat}"
}

# resource "aws_network_acl" "nat" {
#     vpc_id = "${aws_vpc.main_vpc.id}"
#     subnet_ids = [
#         "${module.nat_az1.subnet_id}",
#         "${module.nat_az2.subnet_id}" 
#     ]
#     tags {
#         Name = "${var.system}_${var.branch}_nat"
#         System = "${var.system}"
#         Stack = "${var.stack}"
#         Branch = "${var.branch}"
#         Resource = "nat_security_group"
#     }
# }

# -----------------------------------------------------------------------------
#  Output Variables
# -----------------------------------------------------------------------------

output "vpc_id" {
    value = "${aws_vpc.main_vpc.id}"
}

output "public_route_table_id" {
    # Route table to be used by public subnets
    value = "${aws_route_table.public_route_table.id}"
}

output "az1_private_route_table_id" {
    # Route table to be used by private subnets to AZ1 NAT
    value = "${module.nat_az1.route_table_id}"
}

output "az2_private_route_table_id" {
    # Route table to be used by private subnets to AZ2 NAT
    value = "${module.nat_az2.route_table_id}"
}
