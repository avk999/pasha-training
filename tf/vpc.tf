resource "aws_vpc" "k8s_training" {
  cidr_block = var.vpc_cidr
  tags = {
    Name    = "${var.tag_prefix}_vpc"
    Project = "${var.tag_project}"
  }

}

resource "aws_internet_gateway" "k8s_training_igw" {
  vpc_id = aws_vpc.k8s_training.id
  tags = {
   Name    = "${var.tag_prefix}_igw"
    Project = "${var.tag_project}"
  }
}

resource "aws_subnet" "public_subnet" {
  
  vpc_id     = aws_vpc.k8s_training.id
  cidr_block = var.subnet_cidr
  map_public_ip_on_launch = true
  tags = {
    Name    = "${var.tag_prefix}_subnet"
    Project = "${var.tag_project}"
  }
}

resource "aws_route_table" "k8s_training_public_rt" {
  vpc_id = aws_vpc.k8s_training.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.k8s_training_igw.id

  }
    tags = {
      Name    = "${var.tag_prefix}_rt"
      Project = "${var.tag_project}"
    }
  }


resource "aws_route_table_association" "k8s_route_association" {
    
subnet_id      = aws_subnet.public_subnet.id
route_table_id = aws_route_table.k8s_training_public_rt.id
}

