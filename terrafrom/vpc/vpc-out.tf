output "vpc_id" {
    description = "this is the id of the vpc"
    value = aws_vpc.project.id
}