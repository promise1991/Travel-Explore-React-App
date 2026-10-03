module "eks" {
  source = "terraform-aws-modules/eks/aws"
  version = "20.20.0"
  cluster_name = "travel-eks-prod"
  cluster_version = "1.32"
  vpc_id = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets
  enable_irsa = true
  enable_cluster_creator_admin_permissions = true
  cluster_endpoint_public_access = true
  cluster_endpoint_private_access = true
  cluster_endpoint_public_access_cidrs = ["0.0.0.0/0"]
  cluster_addons = {
    coredns = { most_recent = true }
    kube-proxy = { most_recent = true }
    vpc-cni = { most_recent = true }
  }
  eks_managed_node_groups = {
    main = {
      ami_type = "AL2023_x86_64_STANDARD"
      instance_types = ["t3.micro"]
      min_size = 2
      max_size = 6
      desired_size = 2
    }
  }
  tags = { Project = "travel-explore" }
}
output "cluster_name" { value = module.eks.cluster_name }
output "connect_cmd" { value = "aws eks update-kubeconfig --region us-east-1 --name ${module.eks.cluster_name}" }
