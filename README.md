# aws-pg-dumper

For custom backups postgre database using:

    pg_dump -Fc 

and uploading them to S3 bucket (not only AWS).

You can added this to the **cronjobs in Kubernetes** for dump PostgreSQL databases. 

Handles errors for all pipelines inside the bash, and **exits with an exit code not equal to 0** - you can monitoring jobs in Kubernetes.

---

### **Environment variables (ENV):**

> You can override the following ENV

#### **Defined in Dockerfile:**

$TZ (default value=Europe/Moscow)

#### **Defined in bash script:**

$PG_USER

$PG_PASSWORD

$PG_HOST

$PG_DBNAME

$AWS_BUCKET_NAME

$AWS_HOST

$AWS_REGION
