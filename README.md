# Terraform module for AWS CodePipeline

The purpose of the module is to create a AWS CodePipeline.

- AWS CodePipeline
- AWS IAM Role (Optional)

## Prerequisites

- The Terraform CLI, version 1.2.5 or later.
- AWS Credentials configured for use with Terraform.
- The git CLI.

## Setup

The following example shows how to use the module.

```hcl

module "codepipeline" {
  source         = "../"
  artifact_store = var.artifact_store
  common_tags    = var.tags
  description    = var.description
  name           = var.name
  stages         = var.stages
  kms_key_id     = aws_kms_key.example.arn
}

```

## Variables

The following are the variables used for this module.

| Name | Type | Default | Description |
|:-:|:-:|:-:|:-:|
| region | String | ap-southeast-2 | The target AWS region for the cluster.             |
| env | String | demo | The codepipeline environment name            |
| name | String | "" | Codepipeline name.             |
| byo_iam_role | bool | false| Indicates whether to use existing IAM role.             |
| byo_role_arn | String | "" | BYO codepipeline IAM role ARN.            |
| policypath | String | " | Codepipeline IAM role policy path.             |
| stages | list() | [] | This list describes each stage of the codebuild.            |
| artifact_store | map | {} | Map to populate the artifact block. The creation of the artifact store not managed within the module. It needs to be created outside the module and pass the location ID/ARN to the module. |
| kms_key_id | String | "" | The KMS key id that should be used to encrypt arteficts.             |
| tags | Map | {} | AWS tags to be applied to created resources. |


## Variable Example 

```hcl
description   = "Codepipeline for Terraform deploy"
env           = "prod"
name          = "cp-tf"
byo_iam_role  = true
byo_role_arn  = arn:aws:iam::xxxx:role/samplerole

artifact_store = {
    location = "codepipeline-<S3_bucket_name>"
    type = "S3" 
  }

stages = [
  {
    name = "Source"
    action = [{
      name     = "Source"
      category = "Source"
      owner    = "AWS"
      provider = "CodeCommit"
      version  = "1"
      configuration = {
        BranchName           = "master"
        PollForSourceChanges = "false"
        RepositoryName       = "testrepo"
      }
      input_artifacts  = []
      output_artifacts = ["SourceArtifact"]
      run_order        = 1
    }]
  },
  {
    name = "Build"
    action = [{
      name             = "Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["SourceArtifact"]
      output_artifacts = ["BuildArtifact"]
      version          = "1"
      run_order        = 2
      configuration = {
        ProjectName = "testrepo"
      }
    }]
  }
]

tags = {
  name   = "codepipeline"
  module = "module/tf-module-aws-codepipeline"
}
```

## Outputs

This module will provide the following outputs.

| Output Name | Type | Description |
|:-:|:-:|:-:|
| codepipeline  | string  | The output of the aws_codepipeline resource. |
| cp_role_arn | string | ARN of the pipeline role if var.role_arn is not supplied. |
| cp_role_name | string | Name of the pipeline role created if var.role_arn is not supplied. |

