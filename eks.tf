module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = "my-low-cost-cluster"
  cluster_version = "1.30"

  #Modern EKS clusters (v1.30+) use Access Entries instead of the old aws-auth ConfigMap.
  # If you didn't explicitly tell EKS to trust the creator, 
    authentication_mode                         = "API_AND_CONFIG_MAP"
  enable_cluster_creator_admin_permissions = true

  vpc_id     = "vpc-091918d9aab3e8b40"
  subnet_ids = ["subnet-01ef067e5b989506f", "subnet-061628f2ae1db0ee3"]
  cluster_endpoint_public_access  = true 

  eks_managed_node_groups = {
    free_tier_nodes = {
      instance_types = ["t3.micro"]
      min_size       = 1
      max_size       = 2
      desired_size   = 1
      capacity_type  = "SPOT"
    }
  }
}
