resource "aws_security_group" "k8s-training-sg" {
    vpc_id=aws_vpc.k8s_training.id
    tags = {
        Name    = "${var.tag_prefix}_sg_local"
        Project = "${var.tag_project}"

    }
}

resource "aws_security_group_rule" "self-in" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  self              = true
  security_group_id = aws_security_group.k8s-training-sg.id
}

resource "aws_security_group_rule" "ssh-in" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = aws_security_group.k8s-training-sg.id
}
resource "aws_security_group_rule" "http-in" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = aws_security_group.k8s-training-sg.id
}
resource "aws_security_group_rule" "egress" {
  type              = "egress"
  
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = aws_security_group.k8s-training-sg.id
}

