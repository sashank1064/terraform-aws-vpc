data "aws_availability_zones" "available" {
  state = "available"

}

data "aws_vpc" "default" {
  default = true
  
}

data "aws_route_table" "main" {    # gets the main route table of default VPC
  vpc_id = data.aws_vpc.default.id
  filter {
    name = "association.main"
    values = ["true"]
  }
}

/* output "azs_info" {
    value = data.aws_availability_zones.available
  
} */