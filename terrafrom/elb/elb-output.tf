output "private_target_group_arn" {
    value = aws_lb_target_group.private_tg.arn
}

output "public_target_group_arn" {
    value = aws_lb_target_group.public_tg.arn
}

output "lb_listener_private" {
    value = aws_lb_listener.private_listener.arn
}

output "lb_listener_public" {
    value = aws_lb_listener.public_listener.arn
}
