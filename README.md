# terraform-aws-vpc

A reusable Terraform module that creates a three-tier VPC on AWS: public, private, and database subnets across multiple AZs, with an Internet Gateway, NAT, route tables, and optional peering to the default VPC.

![Terraform](https://img.shields.io/badge/Terraform-7B42BC?logo=terraform&logoColor=white)
![AWS](https://img.shields.io/badge/AWS-232F3E?logo=amazonaws&logoColor=white)
![HCL](https://img.shields.io/badge/HCL-844FBA?logo=terraform&logoColor=white)

## Overview

This is the VPC module I use across the RoboShop platform. It's consumed directly from GitHub as a remote module:

```hcl
module "vpc" {
  source = "git::https://github.com/sashank1064/terraform-aws-vpc.git?ref=main"

  Project     = var.Project
  environment = var.environment

  public_subnet_cidrs   = var.public_subnet_cidrs
  private_subnet_cidrs  = var.private_subnet_cidrs
  database_subnet_cidrs = var.database_subnet_cidrs

  is_peering_required = true
}
```

## What it creates

| Resource | Notes |
|---|---|
| `aws_vpc` | `enable_dns_hostnames = true`, configurable CIDR (default `10.0.0.0/16`) |
| `aws_internet_gateway` | Attached to the VPC |
| `aws_subnet` (public) | `map_public_ip_on_launch = true`, spread across AZs |
| `aws_subnet` (private) | For app-tier instances |
| `aws_subnet` (database) | Isolated for RDS and internal data stores |
| Route tables | Separate public / private / database routing |
| `aws_vpc_peering_connection` | Optional, gated by `is_peering_required` |
| Peering routes | Added to public and private route tables when peering is on |

AZs are discovered with a `data "aws_availability_zones"` lookup, not hard-coded, so the module works in any region.

## Inputs

| Name | Type | Required | Notes |
|---|---|---|---|
| `Project` | `string` | yes | Used in resource names and tags |
| `environment` | `string` | yes | `dev`, `stage`, `prod`, etc. |
| `cidr_block` | `string` | no | Default `10.0.0.0/16` |
| `public_subnet_cidrs` | `list(string)` | yes | One CIDR per AZ |
| `private_subnet_cidrs` | `list(string)` | yes | One CIDR per AZ |
| `database_subnet_cidrs` | `list(string)` | yes | One CIDR per AZ |
| `vpc_tags`, `igw_tags`, etc. | `map(string)` | no | Merged into `local.common_tags` |
| `is_peering_required` | `bool` | no | Default `false`. Turns on peering with the default VPC |
| `vpc_peering_tags` | `map(string)` | no | Tags for the peering resource |

## Outputs

- `vpc_id`
- `public_subnet_ids`
- `private_subnet_ids`
- `database_subnet_ids`

These are the handles every downstream module (SGs, ALBs, EC2) consumes.

## Design notes

- **Peering is opt-in.** Consumers set `is_peering_required = true` in non-prod to access shared tooling; prod stays isolated.
- **Tags are merged, not replaced.** `local.common_tags` ensures `Project` and `Environment` always land on every resource for cost attribution and cleanup.
- **Pin the ref.** In real consumers, replace `?ref=main` with a commit SHA or tag so upgrades are deliberate.

## Used by

- [`roboshop-infra-dev`](https://github.com/sashank1064/roboshop-infra-dev) phase `00-vpc`
- [`terraform-aws-roboshop`](https://github.com/sashank1064/terraform-aws-roboshop) (downstream components look up the VPC by project and environment tags)

## Related modules

1. `terraform-aws-vpc` (this repo)
2. [`terraform-aws-securitygroup`](https://github.com/sashank1064/terraform-aws-securitygroup): per-service SG factory
3. [`terraform-aws-instance`](https://github.com/sashank1064/terraform-aws-instance): validated EC2 module
