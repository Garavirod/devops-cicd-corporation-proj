resource "aws_security_group_rule" "outbound_rule_1" {
    description = "Allow all the request outgoing from ec2"
    type        = "egress"
    from_port   = 0
    to_port     = 0
    protocol = "-1"
    security_group_id = aws_security_group.sg_ec2_k8s.id
    cidr_blocks = [ "0.0.0.0/0" ]
}
