# aws-pg-dumper

Dockerimage is needed to create custom backups and uploading them to S3 bucket (not only AWS). 
You can added to the cronjobs in Kubernetes for dump Postgre databases (For example, if you use Zalando Posgres-operator, actually they use the built-in dump mechanism, but it didn't work fine for me).
