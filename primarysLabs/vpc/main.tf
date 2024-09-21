resource "aws_vpc" "webappvpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
  tags = {
    Name = "webapp-vpc"
  }
}

resource "aws_default_network_acl" "default" {
  default_network_acl_id = aws_vpc.webappvpc.default_network_acl_id

  ingress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  egress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  tags = {
    Name = "default-acl"
  }
}

resource "aws_subnet" "public1" {
  vpc_id             = aws_vpc.webappvpc.id
  availability_zone  = "us-east-1a"
  cidr_block         = "10.0.0.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-1a"
  }
}

resource "aws_subnet" "public2" {
  vpc_id             = aws_vpc.webappvpc.id
  availability_zone  = "us-east-1b"
  cidr_block         = "10.0.2.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-1b"
  }
}

resource "aws_subnet" "private1" {
  vpc_id             = aws_vpc.webappvpc.id
  availability_zone  = "us-east-1a"
  cidr_block         = "10.0.1.0/24"

  tags = {
    Name = "private-subnet-1a"
  }
}

resource "aws_subnet" "private2" {
  vpc_id             = aws_vpc.webappvpc.id
  availability_zone  = "us-east-1b"
  cidr_block         = "10.0.3.0/24"

  tags = {
    Name = "private-subnet-1b"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.webappvpc.id

  tags = {
    Name = "internet-gateway"
  }
}

resource "aws_eip" "one" {
  domain = "vpc"

  tags = {
    Name = "nat-eip"
  }
}

resource "aws_nat_gateway" "public" {
  allocation_id = aws_eip.one.id
  subnet_id     = aws_subnet.public1.id

  tags = {
    Name = "nat-gateway"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.webappvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "public-route-table"
  }
}

resource "aws_route_table_association" "public1" {
  subnet_id      = aws_subnet.public1.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public2" {
  subnet_id      = aws_subnet.public2.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.webappvpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.public.id
  }

  tags = {
    Name = "private-route-table"
  }
}

resource "aws_route_table_association" "private1" {
  subnet_id      = aws_subnet.private1.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private2" {
  subnet_id      = aws_subnet.private2.id
  route_table_id = aws_route_table.private.id
}

resource "aws_security_group" "allow_tls" {
  name   = "allow-http"
  vpc_id = aws_vpc.webappvpc.id

  tags = {
    Name = "allow-http-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80

  tags = {
    Name = "allow-http-ingress"
  }
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"

  tags = {
    Name = "allow-all-egress"
  }
}

resource "aws_security_group" "allow_https" {
  name   = "allow-https"
  vpc_id = aws_vpc.webappvpc.id

  tags = {
    Name = "allow-https-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow__protocol_https" {
  security_group_id = aws_security_group.allow_https.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443

  tags = {
    Name = "allow-https-ingress"
  }
}
resource "aws_vpc_security_group_ingress_rule" "allow_inbound_protocol_ssh" {
  security_group_id = aws_security_group.allow_https.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22

  tags = {
    Name = "allow-https-ingress"
  }
}

resource "aws_vpc_security_group_egress_rule" "allow_all_protocol_https" {
  security_group_id = aws_security_group.allow_https.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"

  tags = {
    Name = "allow-all-egress-https"
  }
}
