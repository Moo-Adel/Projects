output "public_SG_id" {
    value = aws_security_group.public-sg.id
}

output "private_SG_id" {
    value = aws_security_group.private-sg.id
}
