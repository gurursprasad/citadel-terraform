# Allocate multiple ips for high availability blue/green deployments.
resource "aws_eip" "this" {
    domain = "vpc"
    tags = {
        Name = "${var.env}-nat"
    }
}

resource "aws_nat_gateway" "this" {
    allocation_id = aws_eip.this.id
    subnet_id     = aws_subnet.public_subnet[0].id
    depends_on = [aws_internet_gateway.this]
    

    tags = {
        Name = "${var.env}-nat"
    }
}
