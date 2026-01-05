variable "cidr_block" {
    description = "The CIDR block for the VPC"
    type        = string
    default     = "10.0.0.0/16"
  
}

variable "Project" {
    description = "The name of the project"
    type        = string
  
}

 variable "environment" {
    description = "The environment name"
    type        = string
   
 }

 variable "vpc_tags" {
    description = "A map of tags to assign to the VPC"
    type        = map(string)
    default     = {}
  
}

variable "igw_tags" {
    description = "A map of tags to assign to the Internet Gateway"
    type        = map(string)
    default     = {}
  }

 variable "public_subnet_cidrs" {
    description = "The CIDR block for the public subnet"
    type        = list(string)
    
   
 }
 variable "public_subnet_tags" {
    description = "A map of tags to assign to the public subnets"
    type        = map(string)
    default     = {}
   
 }

 variable "private_subnet_cidrs" {
    description = "The CIDR block for the private subnet"
    type        = list(string)
    
 }
    variable "private_subnet_tags" {
        description = "A map of tags to assign to the private subnets"
        type        = map(string)
        default     = {}
    
    }


variable "database_subnet_cidrs" {
    description = "The CIDR block for the database subnet"
    type        = list(string)
  
}


variable "database_subnet_tags" {
    description = "A map of tags to assign to the database subnets"
    type        = map(string)
    default     = {}
  
}

variable "eip_tags" {
    description = "A map of tags to assign to the NAT EIPs"
    type        = map(string)
    default     = {}
  
}

variable "nat_gateway_tags" {
    description = "A map of tags to assign to the NAT Gateways"
    type        = map(string)
    default     = {}
  
}

variable "public_route_table_tags" {
    description = "A map of tags to assign to the public route tables"
    type        = map(string)
    default     = {}
  

}

variable "private_route_table_tags" {
    description = "A map of tags to assign to the private route tables"
    type        = map(string)
    default     = {}
  
}

variable "database_route_table_tags" {
    description = "A map of tags to assign to the database route tables"
    type        = map(string)
    default     = {}
  
}

variable "is_peering_required" {
    description = "Boolean to specify whether VPC peering is required"
    type        = bool
    default     = false
  

}


variable "vpc_peering_tags" {
    description = "A map of tags to assign to the VPC peering connection"
    type        = map(string)
    default     = {}
  
}