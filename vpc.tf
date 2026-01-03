resource "aws_vpc" "main" {
  cidr_block       = var.cidr_block
  instance_tenancy = "default"
  enable_dns_hostnames = "true"

  tags = merge(
    local.common_tags,
    {
      Name = "${var.Project}-${var.environment}-vpc"
    }
  )
  }

  resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id # associates the IGW with the VPC

  tags = merge(
    local.common_tags,
    {
      Name = "${var.Project}-${var.environment}-igw"
    }
  )
  }

    resource "aws_subnet" "public" {
        count = length(var.public_subnet_cidrs)
      vpc_id            = aws_vpc.main.id
      cidr_block        = var.public_subnet_cidrs[count.index]
      availability_zone = local.az_names[count.index]
      map_public_ip_on_launch = true    
      tags = merge(
        local.common_tags,
        {
          Name = "${var.Project}-${var.environment}-public-${local.az_names[count.index]}"
        }
      )
    }