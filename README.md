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

$TZ - timezone (default `value=Europe/Moscow`)

#### **Defined in bash script:**

$PG_USER - database user

$PG_PASSWORD - database password

$PG_HOST - database host (you can use PgBouncer address)

$PG_DBNAME - database name (this will be used to coonect DB and form name dump-file)

$AWS_BUCKET_NAME - name bucket in AWS (this will be used to form an address in the `aws cp` command)

$AWS_HOST - will be used to form an key awscli `--endpoint-url=`

$AWS_REGION - will be used to form an key awscli `--region=`

> example:

    $PG_DBNAME = testDB
    $AWS_BUCKET_NAME = my/bucket/for/dump
    $AWS_HOST = 127.0.0.1
    $AWS_REGION = en-3z

> result awscli bucket for upload:

    s3://my/bucket/for/dump/dump_testDB_01-03-2021_13:20:12_232447103.gz --endpoint-url=127.0.0.1 --region=en-3z
