data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}


resource "aws_network_interface" "linux-nic" {
  subnet_id = aws_subnet.apps_public1.id
}


resource "aws_instance" "linux" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"

  network_interface {
    device_index         = 0
    network_interface_id = aws_network_interface.linux-nic.id

  }

  tags = {
    Name = "vm-${random_string.this.result}"
  }
}
