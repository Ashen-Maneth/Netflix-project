provider "aws" {
  region = "us-east-1" 
}

# 1. The Firewall (Security Group)
resource "aws_security_group" "web_sg" {
  name        = "netflix-prod-web-sg"
  description = "Security group for Netflix production web tier"

  ingress {
    description = "Allow SSH from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTP web traffic"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow Argo CD Port Forwarding"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow Netflix Clone NodePort"
    from_port   = 30586
    to_port     = 30586
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "netflix-prod-web-sg"
    Environment = "prod"
    Project     = "netflix-clone"
    ManagedBy   = "terraform"
  }
}

# 2. The Cloud Server (EC2 Instance)
resource "aws_instance" "app_server" {
  ami           = "ami-0c7217cdde317cfec" # Standard Ubuntu 22.04 LTS
  instance_type = "t3.medium"      
  key_name      = aws_key_pair.netflix_auth.key_name       
  
  vpc_security_group_ids = [aws_security_group.web_sg.id]


  tags = {
    Name        = "netflix-prod-k3s-node"
    Environment = "prod"
    Project     = "netflix-clone"
    ManagedBy   = "terraform"
    Role        = "kubernetes-server"
  }
}


resource "aws_key_pair" "netflix_auth" {
  key_name   = "netflix-prod-key"
  public_key = file("~/.ssh/netflix_key.pub")
}