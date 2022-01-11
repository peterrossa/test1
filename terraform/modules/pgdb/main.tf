terraform {
	required_providers {
		postgresql = {
			source = "cyrilgdn/postgresql"
			version = "1.14.0"
		}
	}
}

locals {
	sqlfile = file("${path.root}/../_sql/db_${var.dckey}.sql")
}

provider "postgresql" {
	host = "localhost"
	port = replace(replace(var.dcdata.ports[0], "/^[^:]*:/", ""), "/:.*$/", "")
	# username = "postgres_user"
	password = var.dcdata.environment.POSTGRES_PASSWORD
	sslmode = "disable" # provider doesn't work otherwise
	connect_timeout = 15
}

resource "postgresql_database" "d" {
	provider = postgresql
	name = var.dckey
}

resource "null_resource" "psql" {
	count = var.init_db # apply only when initializing

	provisioner "local-exec" {
		command = <<EOF
			docker exec ${var.dcdata.container_name} bash -c "psql -h localhost -U postgres -c \"${local.sqlfile}\""
		EOF
	}

	depends_on =  [postgresql_database.d]
}
