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
 variable "public_subnet_cidrs" {
    description = "The CIDR block for the public subnet"
    type        = list(string)
    
   
 }