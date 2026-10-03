data "aws_availability_zones" "available" {} # • Automatically fetches a list of all active data center zones (e.g., us-east-1a, us-east-1b) in your current AWS region.

module "vpc" {
  source               = "terraform-aws-modules/vpc/aws"
  version              = "5.8.1"
  name                 = "travel-eks-prod-vpc"
  cidr                 = "10.0.0.0/16"
  azs                  = slice(data.aws_availability_zones.available.names, 0, 2) # • Grabs the first two availability zones from that list to ensure high availability across two separate physical data centers.
  public_subnets       = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets      = ["10.0.3.0/24", "10.0.4.0/24"]
  enable_nat_gateway   = true # Also MUST have NAT Gateway for private nodes to pull nginx/ECR images
  single_nat_gateway   = true
  enable_dns_hostnames = true
  tags                 = { Project = "travel-explore" }
}

output "vpc_id" { value = module.vpc.vpc_id }
output "private_subnets" { value = module.vpc.private_subnets }
output "public_subnets" { value = module.vpc.public_subnets }
