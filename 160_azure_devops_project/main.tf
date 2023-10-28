resource "azuredevops_project" "project" {
  name               = "Project demo TF"
  visibility         = "private"
  version_control    = "Git"
  work_item_template = "Agile"
}

resource "azuredevops_git_repository" "repo" {
  name           = "repo-webapp"
  project_id     = azuredevops_project.project.id
  default_branch = "refs/heads/main"

  initialization {
    init_type = "Clean"
  }
}

resource "azuredevops_variable_group" "var_group" {
  project_id   = azuredevops_project.project.id
  name         = "Variable Group for WebApp"
  description  = "Managed by Terraform"
  allow_access = true

  variable {
    name  = "FOO"
    value = "BAR"
  }
}

resource "azuredevops_build_definition" "pipeline" {
  project_id = azuredevops_project.project.id
  name       = "CI-CD Pipeline"
  path       = "\\webapp"

  ci_trigger {
    use_yaml = false
  }

  schedules {
    branch_filter {
      include = ["main"]
      exclude = ["test", "regression"]
    }
    days_to_build              = ["Wed", "Sun"]
    schedule_only_with_changes = true
    start_hours                = 10
    start_minutes              = 59
    time_zone                  = "(UTC) Coordinated Universal Time"
  }

  repository {
    repo_type   = "TfsGit"
    repo_id     = azuredevops_git_repository.repo.id
    branch_name = azuredevops_git_repository.repo.default_branch
    yml_path    = "azure-pipelines.yml"
  }

  variable_groups = [
    azuredevops_variable_group.var_group.id
  ]

  variable {
    name  = "PipelineVariable"
    value = "Go Microsoft!"
  }

  variable {
    name         = "PipelineSecret"
    secret_value = "ZGV2cw"
    is_secret    = true
  }
}

resource "azuredevops_workitem" "issue" {
  project_id = azuredevops_project.project.id
  title      = "Example Work Item"
  type       = "Issue"  # Bug, Epic, Feature, Issue, Task, Test Case, User Story
  state      = "Active" # New, Active, Resolved, and Closed
  tags       = ["prod"]
}

resource "azuredevops_workitem" "user-story" {
  project_id = azuredevops_project.project.id
  title      = "Creating Login Page"
  type       = "User Story" # Bug, Epic, Feature, Issue, Task, Test Case, User Story
  state      = "Active"     # New, Active, Resolved, and Closed
  tags       = ["frontend", "mobile-app"]
}

resource "azuredevops_workitem" "task" {
  project_id = azuredevops_project.project.id

  title = "Creating Authorisation Server"
  type  = "Task" # Bug, Epic, Feature, Issue, Task, Test Case, User Story
  tags  = ["api", "authorisation"]
}

# import existing Git repository

resource "azuredevops_git_repository" "import-repo" {
  project_id = azuredevops_project.project.id
  name       = "Imported Repository"
  initialization {
    init_type   = "Import"
    source_type = "Git"
    source_url  = "https://github.com/HoussemDellai/azure-devops-pipelines-samples"
  }
}

resource "azuredevops_build_definition" "pipeline-imported" {
  project_id      = azuredevops_project.project.id
  name            = "CI-CD Pipeline Matrix"
  path            = "\\webapp"
  agent_pool_name = "Azure Pipelines"

  ci_trigger {
    use_yaml = true
  }

  features {
    skip_first_run = false
  }

  repository {
    repo_type   = "TfsGit"
    repo_id     = azuredevops_git_repository.import-repo.id
    branch_name = azuredevops_git_repository.import-repo.default_branch
    yml_path    = "azure-pipelines-matrix.yaml"
  }
}
