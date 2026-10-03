module "lb_controller_role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version = "5.44.0"

  role_name                              = "aws-load-balancer-controller"
  attach_load_balancer_controller_policy = true
  oidc_providers = {
    main = {
      provider_arn               = module.eks.oidc_provider_arn
      namespace_service_accounts = ["kube-system:aws-load-balancer-controller"]
    }
  }
}


# This Terraform code creates a secure AWS IAM Role for Service Accounts (IRSA). Specifically, it sets 
# up the exact AWS permissions required by the AWS Load Balancer Controller inside your Kubernetes cluster

# • source & version: It uses a verified, pre-built AWS IAM module from the Terraform Registry (terraform-aws-modules/iam/aws) at version 5.44.0.
# • role_name = "aws-load-balancer-controller": This creates an AWS IAM role in your AWS account named exactly aws-load-balancer-controller.
# • attach_load_balancer_controller_policy = true: This tells the module to automatically find and attach the official AWS-managed IAM policy for the Load Balancer Controller. This policy gives the role permission to do things like elasticloadbalancing:CreateLoadBalancer, ModifyTargetGroup, and manage security groups.
# • oidc_providers = { ... }: This configures the Trust Relationship for the IAM role:
# 	• provider_arn = module.eks.oidc_provider_arn: It connects this IAM role to your EKS cluster's unique OpenID Connect (OIDC) identity provider. (This relies on the module.eks block you shared in your previous message).
# 	• namespace_service_accounts = ["kube-system:aws-load-balancer-controller"]: This is a strict security boundary. It dictates that only a Kubernetes Service Account named aws-load-balancer-controller running in the kube-system namespace is allowed to assume this AWS IAM role.
