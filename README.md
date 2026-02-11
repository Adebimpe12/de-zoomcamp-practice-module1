# de-zoomcamp-practice-module1
A practice project for Module 1 of Data Engineering Zoomcamp — includes Docker, Docker Compose, SQL, and Terraform exercises.

# DE Zoomcamp Practice - Module 1

**Project Name:** `de-zoomcamp-practice-module1`  
**Description:** A practice project for Module 1 of Data Engineering Zoomcamp — includes **Docker, Docker Compose, SQL, and Terraform** exercises.  

This repository contains simplified exercises to practice the core concepts from Module 1.

---

## **1️⃣ Docker Practice**

**Goal:** Run a Python container and check `pip` version.

**Steps:**

1. Pull the Python image and run an interactive bash session:
```bash
docker run -it --rm python:3.13 bash


Check the pip version:

pip --version


Expected output: pip 25.3 ...

Exit the container:

exit


Concepts Practiced:

Docker images

Interactive containers

Checking installed tools

2️⃣ Docker Compose Practice

Goal: Run a Postgres database and PGAdmin using Docker Compose.

File: docker-compose-practice/docker-compose.yml

version: '3.9'
services:
  db:
    image: postgres:17-alpine
    environment:
      POSTGRES_USER: test
      POSTGRES_PASSWORD: test
      POSTGRES_DB: testdb
    ports:
      - "5433:5432"

  pgadmin:
    image: dpage/pgadmin4:latest
    environment:
      PGADMIN_DEFAULT_EMAIL: "admin@example.com"
      PGADMIN_DEFAULT_PASSWORD: "admin"
    ports:
      - "8080:80"


Steps:

Start the containers:

docker-compose up -d


Connect to Postgres in PGAdmin:

Parameter	Value
Hostname	db (or localhost if using host port)
Port	5433
User	test
Password	test
Database	testdb

Concepts Practiced:

Docker networking

Compose services

Environment variables

3️⃣ SQL Practice

Goal: Practice basic SQL queries on a small dataset.

File: sql-practice/trips.csv

pickup_datetime,dropoff_datetime,trip_distance,total_amount,tip_amount,pu_zone,do_zone
2025-11-01 10:00,2025-11-01 10:15,0.5,10,2,ZoneA,ZoneB
2025-11-01 11:00,2025-11-01 11:25,5.2,20,3,ZoneC,ZoneD
2025-11-02 09:30,2025-11-02 09:50,1.0,12,2,ZoneA,ZoneC
2025-11-02 12:00,2025-11-02 12:45,15,50,8,ZoneB,ZoneD


Steps:

Connect to Postgres:

docker exec -it docker-compose-practice_db_1 psql -U test -d testdb


Create the table:

CREATE TABLE trips (
    pickup_datetime TIMESTAMP,
    dropoff_datetime TIMESTAMP,
    trip_distance FLOAT,
    total_amount FLOAT,
    tip_amount FLOAT,
    pu_zone TEXT,
    do_zone TEXT
);


Load CSV data:

COPY trips FROM '/path/to/trips.csv' DELIMITER ',' CSV HEADER;


Example queries:

Count short trips (trip_distance <= 1):

SELECT COUNT(*) FROM trips WHERE trip_distance <= 1;


Longest trip per day (trip_distance < 100):

SELECT DATE(pickup_datetime), MAX(trip_distance)
FROM trips
WHERE trip_distance < 100
GROUP BY DATE(pickup_datetime);


Pickup zone with largest total_amount for a day (2025-11-01):

SELECT pu_zone, SUM(total_amount) AS total
FROM trips
WHERE DATE(pickup_datetime) = '2025-11-01'
GROUP BY pu_zone
ORDER BY total DESC
LIMIT 1;


Dropoff zone with largest tip for pickup zone "ZoneA":

SELECT do_zone, MAX(tip_amount)
FROM trips
WHERE pu_zone='ZoneA'
GROUP BY do_zone
ORDER BY MAX(tip_amount) DESC
LIMIT 1;


Concepts Practiced:

SQL SELECT, WHERE, GROUP BY, ORDER BY

Aggregations: SUM, MAX, COUNT

4️⃣ Terraform Practice

Goal: Create and destroy a GCP storage bucket using Terraform.

File: terraform-practice/main.tf

terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 5.0"
    }
  }
}

provider "google" {
  project = "YOUR_GCP_PROJECT_ID"
  region  = "us-central1"
}

resource "google_storage_bucket" "my_bucket" {
  name     = "my-practice-bucket-2026"
  location = "US"
}


Steps:

Initialize Terraform:

terraform init


Apply changes:

terraform apply -auto-approve


Destroy resources:

terraform destroy -auto-approve


Concepts Practiced:

Terraform workflow (init, apply, destroy)

Providers and resources

5️⃣ Repository Structure
de-zoomcamp-practice-module1/
├── docker-practice/
├── docker-compose-practice/
│   └── docker-compose.yml
├── sql-practice/
│   └── trips.csv
├── terraform-practice/
│   └── main.tf
└── README.md
