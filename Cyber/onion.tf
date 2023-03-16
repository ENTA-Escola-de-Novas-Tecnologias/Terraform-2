resource "aws_instance" "onion" {
  ami                                  = var.deb_based
  instance_type                        = var.onion_type
  key_name                             = aws_key_pair.CyberSecurity.key_name
  network_interface {
    device_index         = 0
    network_interface_id = aws_network_interface.desktop_cyber_private1.id
  }
  network_interface {
    device_index         = 1
    network_interface_id = aws_network_interface.desktop_cyber_private2.id
  }
  network_interface {
    device_index         = 2
    network_interface_id = aws_network_interface.desktop_cyber_private3.id
  }
  tags                                 = {
    "Name" = "onion"
  }
  root_block_device {
    delete_on_termination = true
    tags                                 = {
      "Name" = "Volume for desktop"
    }
    volume_size           = 30
    volume_type           = "gp2"
  }
  user_data = data.template_file.onion.rendered
}