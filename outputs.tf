output "codepipeline" {
  description = "The output of the aws_codepipeline resource."
  value       = aws_codepipeline.pipe
}

output "cp_role_arn" {
  description = "ARN of the pipeline role if var.role_arn is not supplied."
  value       = local.role_arn
}

output "cp_role_name" {
  description = "Name of the pipeline role created if var.role_arn is not supplied."
  value       = local.role_name
}