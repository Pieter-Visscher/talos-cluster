terraform {
  backend "pg" {
    conn_str = "postgres://10.0.50.10/terraform_talos_cluster"
  }
}
