# Setup
On first run:
1. `docker-compose up postgres` - start just the postgres server
1. `docker-compose up initdb` - initializes the DB
1. `docker-compose up webserver scheduler` - start webserver and scheduler

On subsequent runs you can comment out the `initdb` step in the `docker-compose.yml` file and just do a standard `docker-compose up` command.
