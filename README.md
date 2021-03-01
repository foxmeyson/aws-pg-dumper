# aws-pg-dumper

For backup postgreSQL database in custom format, compressing and upload to S3 bucket (not only AWS).
Using:

    pg_dump -Fc | gzip | aws cp

Inspired by Zalando Posgres operator for Kubernetes (if you use Zalando Posgres operator, actually they use the built-in dump mechanism, but it didn't work fine for me)

You can added this to the **cronjobs in Kubernetes** for dump PostgreSQL databases. 

Handles errors for all pipelines inside the bash, and **exits with an exit code not equal to 0** in case of any error - you can monitoring jobs in Kubernetes.

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
