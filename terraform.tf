terraform {
  backend "pg" {
    conn_str = "postgres://127.0.0.1/terraform_talos_cluster"
  }
}
