## Connection, authentication, application configuration variables

# define the GCP authentication file
variable "gcp_auth_file" {
  type = string
  description = "GCP authentication file"
}

# define GCP project name
variable "app_project" {
  type = string
  description = "GCP Project name"
}

# define application name
variable "app_name" {
  type = string
  description = "Application name"
}

# define application environment
variable "app_environment" {
  type = string
  description = "Application environment"
}

# define service account
variable "srv_acct" {
  type = string
  description = "Service account"
}
##########################################################################

## Network variables

# define GCP region
variable "gcp_region_1" {
  type = string
  description = "GCP region"
}

# define GCP zone
variable "gcp_zone_1" {
  type = string
  description = "GCP zone"
}

# define private subnet
variable "private_subnet_cidr_1" {
  type = string
  description = "private subnet CIDR 1"
}


