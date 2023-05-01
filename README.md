# assignment

- To Run helm chart: 
    - helm package nginx-chart/
    - helm install my-nginx nginx-chart-0.1.0.tgz --set replicaCount=3 --set webContent="Hello World!" --set vaultEnabled=true

- To create AMI using packer: 
    - packer build -var 'aws_access_key=YOUR_ACCESS_KEY' -var 'aws_secret_key=YOUR_SECRET_KEY' nginx.json

- To run terraform: 
  - terraform init
  - terraform apply 

