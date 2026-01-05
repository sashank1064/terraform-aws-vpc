# VPC Module

This module is developed for my personal project called Roboshop. Roboshop project follows this module to create the VPC

## Inputs

* Project(required) - Users should specify their project name
* Environment (required) - Users should specify their environment
* cidr_block (optional) - Users can provide their CIDR block. Default is 10.0.0.0/16

## Outputs
* vpc_id = Exports VPC ID created