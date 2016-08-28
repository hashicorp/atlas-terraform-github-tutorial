variable "aws_instance_type" {
  default = "t2.nano"
}
variable "aws_ami_id" {
  default = "ami-6869aa05"
}
variable "vpc_cidr_block" {
  default = "10.131.0.0/16"
}
variable "public_cidr_block_1" {
  default = "10.131.1.0/24"
}
variable "public_cidr_block_2" {
  default = "10.131.2.0/24"
}
variable "private_cidr_block_1" {
  default = "10.131.3.0/24"
}
variable "private_cidr_block_2" {
  default = "10.131.4.0/24"
}
