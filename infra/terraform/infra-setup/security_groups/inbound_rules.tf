// Inbound rules
resource "aws_security_group_rule" "inbound_rule_1" {
    description = "HTTP inbound rule"
    type        = "ingress"
    from_port   = 80
    to_port     = 80
    protocol = "tcp"
    security_group_id = aws_security_group.sg_ec2_k8s.id
    cidr_blocks = [ "0.0.0.0/0" ]
    
}

resource "aws_security_group_rule" "inbound_rule_2" {
    description = "HTTPS inbound rule"
    type        = "ingress"
    from_port   = 443
    to_port     = 443
    protocol = "tcp"
    security_group_id = aws_security_group.sg_ec2_k8s.id
    cidr_blocks = [ "0.0.0.0/0" ]
}

resource "aws_security_group_rule" "inbound_rule_3" {
    description = "SSH inbound rule"
    type        = "ingress"
    from_port   = 22
    to_port     = 22
    protocol = "tcp"
    security_group_id = aws_security_group.sg_ec2_k8s.id
    cidr_blocks = [ "0.0.0.0/0" ]
}

resource "aws_security_group_rule" "inbound_rule_4" {
    description = "SMTP inbound rule"
    type        = "ingress"
    from_port   = 25
    to_port     = 25
    protocol = "tcp"
    security_group_id = aws_security_group.sg_ec2_k8s.id
    cidr_blocks = [ "0.0.0.0/0" ]
}

resource "aws_security_group_rule" "inbound_rule_5" {
    description = "SMTPS rule"
    type        = "ingress"
    from_port   = 465
    to_port     = 465
    protocol = "tcp"
    security_group_id = aws_security_group.sg_ec2_k8s.id
    cidr_blocks = [ "0.0.0.0/0" ]
}

resource "aws_security_group_rule" "inbound_rule_6" {
    description = "Custom TCP rule"
    type        = "ingress"
    from_port = 30000
    to_port = 32767
    protocol = "tcp"
    security_group_id = aws_security_group.sg_ec2_k8s.id
    cidr_blocks = [ "0.0.0.0/0" ]
}

resource "aws_security_group_rule" "inbound_rule_7" {
    description = "Custom TCP rule"
    type        = "ingress"
    from_port = 3000
    to_port = 10000
    protocol = "tcp"
    security_group_id = aws_security_group.sg_ec2_k8s.id
    cidr_blocks = [ "0.0.0.0/0" ]
}
