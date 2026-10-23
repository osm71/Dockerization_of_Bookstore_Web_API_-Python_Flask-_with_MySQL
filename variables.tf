variable "instance_type" {
        default = "t2.micro"
}
variable "github_repo_url" {
  description = "GitHub repository URL for the application"
  type        = string
 }
    
variable "github_token" {
  description = "GitHub PAT for private repo clone"
  type        = string
  sensitive   = true
 }

 variable tag_name {
  type        = string
  default     = "Web Server of Bookstore"
  
}

variable "db_root_password" {
  type        = string
  description = "MySQL Root Password"
  sensitive   = true
}

variable "db_user_password" {
  type        = string
  description = "MySQL User Password"
  sensitive   = true
}

 
