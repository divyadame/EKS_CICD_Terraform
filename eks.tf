# 2. Use the official EKS module for efficiency
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = "my-low-cost-cluster"
  cluster_version = "1.30"

  # Use default VPC for simplicity in testing
  vpc_id     = "vpc-091918d9aab3e8b40"
  subnet_ids = ["subnet-01ef067e5b989506f", "subnet-061628f2ae1db0ee3"]

  cluster_compute_config = {
    enabled = false
  }
  tags = {
    Environment = "dev"
    Project     = "learning-eks"
    ManagedBy   = "terraform"
  }

  # Configure managed node groups with Free Tier eligible instances
  eks_managed_node_groups = {
    free_tier_nodes = {
      instance_types = ["t3.micro"] # Free tier eligible in many regions
      min_size       = 1
      max_size       = 2
      desired_size   = 1

      # OPTIONAL: Use Spot instances to save up to 90% (Not Free Tier, but cheaper)
      capacity_type = "SPOT"
    }
  }
}
