locals {
  vpc_cidr = "10.0.0.0/16"
}
locals {
  security_groups = {
    public = {
      name        = "public_sg"
      description = "public access"
      ingress = {
        ssh = {
          from        = var.ssh_port
          to          = var.ssh_port
          protocol    = "tcp"
          cidr_blocks = [var.access_ip]
        }

        jenkins = {
          from        = var.jenkins_port
          to          = var.jenkins_port
          protocol    = "tcp"
          cidr_blocks = [var.access_ip]
        }

        host = {
          from        = var.host_port
          to          = var.host_port
          protocol    = "tcp"
          cidr_blocks = [var.access_ip]
        }
        #  eks = {
        #   from        = var.eks_port
        #   to          = var.eks_port
        #   protocol    = "tcp"
        #   cidr_blocks = [var.access_ip]
        # }
      }
    }
  }
}