module "karpenter" {
  source = "terraform-aws-modules/eks/aws//modules/karpenter"
  version = "20.20.0"
  cluster_name = module.eks.cluster_name
  enable_irsa = true
  irsa_oidc_provider_arn = module.eks.oidc_provider_arn
  irsa_namespace_service_accounts = ["karpenter:karpenter"]
}
output "karpenter_queue_name" { value = module.karpenter.queue_name }
output "karpenter_irsa_arn" { value = module.karpenter.iam_role_arn }
output "karpenter_node_role" { value = module.karpenter.node_iam_role_name }
