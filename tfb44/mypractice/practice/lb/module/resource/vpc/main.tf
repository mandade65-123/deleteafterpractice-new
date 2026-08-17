resource "aws_vpc" "ws_vpc" {
    cidr_blocks = var.this_vpc_cidr
}

resource "aws_subnet" "ws_subnet" {
    vpc_id = aws_vpc.aw_vpc.id
    cidr_blocks = var.this_subcidr
}
