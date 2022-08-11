variable "region" {
  description = "The target AWS region for the codepipeline."
  type        = string
  default     = "ap-southeast-2"
}

variable "env" {
  type        = string
  description = "The codepipeline environment name."
  default     = "demo"
}

variable "name" {
  description = "Codepipeline name."
  type        = string
  default     = ""
}

variable "byo_iam_role"  {
  description = "Indicates whether to use existing IAM role."
  type        = bool
  default     = false
}

variable "byo_role_arn" {
  description = "BYO codepipeline IAM role ARN."
  type        = string
  default     = ""
}

variable "policypath" {
  description = "Codepipeline IAM role policy path."
  type        = string
  default     = ""
}

variable "stages" {
  type        = list(any)
  description = "This list describes each stage of the codebuild."
  default     = []
}

variable "artifact_store" {
  description = "Map to populate the artifact block."
  type        = map(any)
}

variable "kms_key_id" {
  description = "The KMS key id that should be used to encrypt arteficts."
  type        = string
  default     = ""
}

# variable "enable_artifact_store" {
#   description = "Inidicate whether to enable artifact store for codepipeline."
#   type        = bool
#   default     = false 
# }

variable "tags" {
  description = "AWS tags to be applied to created resources."
  type        = map(string)
  default     = {}
}