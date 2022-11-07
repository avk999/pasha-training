# # https://cloudinit.readthedocs.io/en/latest/topics/format.html
data "cloudinit_config" "k3s_master" {
  gzip          = true
  base64_encode = true

  # Debug with:
  # cat /var/log/cloud-init.log
  # part {
  #   filename     = "init.cfg"
  #   content_type = "text/cloud-config"
  #   content = templatefile("${path.module}/user_data/master/cloud-config.yaml", {
  #     aws_ccm_ds   = filebase64("${path.module}/user_data/master/cloud-provider-aws/aws-cloud-controller-manager-daemonset.yaml"),
  #     aws_rbac     = filebase64("${path.module}/user_data/master/cloud-provider-aws/rbac.yaml")
  #     storageclass = filebase64("${path.module}/user_data/master/cloud-provider-aws/storageclass.yaml")
  #     aliases      = filebase64("${path.module}/user_data/master/env/aliases")
  #   })
  # }

  # Debug with:
  # cat /tmp/k3s-server-install-debug.log
  # Generated code can be found in /var/lib/cloud/instance/scripts (for debugging purpose)
  part {
    content_type = "text/x-shellscript"
    content = templatefile("${path.module}/user_data/master/makesite.sh", {
      
    })
  }
}

# get first subnet id
data "aws_subnets" "k8s_training_subnets" {
  filter {
    name   = "vpc-id"
    values = [aws_vpc.k8s_training.id]
  }
}



resource "aws_instance" "k3s_master" {
  #count                = 1 #local.master_count now we support only single master clusters
  ami                  = data.aws_ami.amz2-x86_64.id #local.master_ami
  instance_type        = var.instance_type
  key_name=var.key_name

  subnet_id=aws_subnet.public_subnet.id
  associate_public_ip_address = true

  vpc_security_group_ids = [
     aws_security_group.k8s-training-sg.id
     
   ]




  user_data = data.cloudinit_config.k3s_master.rendered

  tags = {
    Name    = "${var.tag_prefix}_instance"
    Project = "${var.tag_project}"
  }


  lifecycle {
    ignore_changes = [
      ami,       # new ami changes by amazon should not affect change to this instance
      user_data, # https://github.com/hashicorp/terraform-provider-aws/issues/4954
      tags,
      volume_tags,
    ]
  }
}
 