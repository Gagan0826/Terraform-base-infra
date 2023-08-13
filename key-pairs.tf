
resource "tls_private_key" "kp2" {
  algorithm   = "RSA"
  rsa_bits = "4096"
}
resource "aws_key_pair" "key" {
  key_name   = "w1"
  public_key = tls_private_key.kp2.public_key_openssh
}
