data "aws_ami" "latest_amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "proxy_az1" {
  ami           = data.aws_ami.latest_amazon_linux.id
  instance_type = "t2.micro"
  subnet_id     = var.subnet_public_AZ1_id
  security_groups = [var.public_SG_id]

  user_data = <<-EOF
              #!/bin/bash
              amazon-linux-extras install nginx1 -y
              systemctl start nginx
              systemctl enable nginx
              echo "<h1>Proxy AZ1</h1>" > /usr/share/nginx/html/index.html
              EOF

  tags = {
    Name = "proxy-az1"
  }
}

# Proxy Instance AZ2
resource "aws_instance" "proxy_az2" {
  ami           = data.aws_ami.latest_amazon_linux.id
  instance_type = "t2.micro"
  subnet_id     = var.subnet_public_AZ2_id
  security_groups = [var.public_SG_id]

  user_data = <<-EOF
              #!/bin/bash
              amazon-linux-extras install nginx1 -y
              systemctl start nginx
              systemctl enable nginx
              echo "<h1>Proxy AZ2</h1>" > /usr/share/nginx/html/index.html
              EOF

  tags = {
    Name = "proxy-az2"
  }
}

# Backend Instance AZ1
resource "aws_instance" "backend_az1" {
  ami           = data.aws_ami.latest_amazon_linux.id
  instance_type = "t2.micro"
  subnet_id     = var.subnet_private_AZ1_id
  security_groups = [var.public_SG_id]

  user_data = <<-EOF
              #!/bin/bash
              yum install -y httpd
              systemctl start httpd
              systemctl enable httpd
              echo "<h1>Backend AZ1</h1>" > /var/www/html/index.html
              EOF

  tags = {
    Name = "backend-az1"
  }
}

# Backend Instance AZ2
resource "aws_instance" "backend_az2" {
  ami           = data.aws_ami.latest_amazon_linux.id
  instance_type = "t2.micro"
  subnet_id     = var.subnet_private_AZ2_id
  security_groups = [var.public_SG_id]

  user_data = <<-EOF
              #!/bin/bash
              yum install -y httpd
              systemctl start httpd
              systemctl enable httpd
              echo "<h1>Backend AZ2</h1>" > /var/www/html/index.html
              EOF

  tags = {
    Name = "backend-az2"
  }
}

# Attach Proxies to Public Target Group
resource "aws_lb_target_group_attachment" "proxy_az1" {
  target_group_arn = var.public_target_group_arn
  target_id        = aws_instance.proxy_az1.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "proxy_az2" {
  target_group_arn = var.public_target_group_arn
  target_id        = aws_instance.proxy_az2.id
  port             = 80
}

# Attach Backends to Private Target Group
resource "aws_lb_target_group_attachment" "backend_az1" {
  target_group_arn = var.private_target_group_arn
  target_id        = aws_instance.backend_az1.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "backend_az2" {
  target_group_arn = var.private_target_group_arn
  target_id        = aws_instance.backend_az2.id
  port             = 80
}
