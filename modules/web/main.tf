resource "aws_security_group" "web_sg" {
  name   = "web-sg"
  vpc_id = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "web" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = element(var.public_subnets, 0)
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  tags = { Name = "web-tier" }
}

output "web_instance_id" { value = aws_instance.web.id }
