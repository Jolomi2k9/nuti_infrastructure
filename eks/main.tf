##############################################
resource "aws_eks_cluster" "eks" {
  name = "kube-eks-01"
  role_arn = "arn:aws:iam::566001962420:role/LabRole"

  vpc_config {
    subnet_ids = [var.public_subnets[0],var.public_subnets[1]]    
  }
  

}
################################################

resource "aws_key_pair" "tr_auth" {      
  public_key = file(var.public_key_path)
}

resource "aws_eks_node_group" "backend" {
  cluster_name    = aws_eks_cluster.eks.name
  node_group_name = "dev"
  node_role_arn   = "arn:aws:iam::566001962420:role/LabRole"
  subnet_ids = [var.public_subnets[0],var.public_subnets[1]]  
  capacity_type = "ON_DEMAND"
  disk_size = "20"
  instance_types = ["t2.small"]
  remote_access {
    ec2_ssh_key = aws_key_pair.tr_auth.id
    source_security_group_ids = [var.public_sg]
  } 
  
  labels =  tomap({env = "dev"})
  
  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 1
  }

  update_config {
    max_unavailable = 1
  }
}