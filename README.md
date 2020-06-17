# **Readme**

### **Introduction**
super minimal serverless AWS resources 

## Run the terraform code


## dependencies

Ensure:

- ensure that you are running terraform 0.12 release.
- The host running Terraform can authenticate to AWS. Authenticate with your aws credential keys or provide a path to your shared credentials on your host machine
  For proper details, see https://www.terraform.io/docs/providers/aws/index.html#authentication.
- Do this only if you wish to manage state in S3, navigate to the root folder and create a backend.tf file and copy all details in backendSample.lock file into your newly created file. Fill in all the appropriate details as required
  OR
- You can run state in your local file and push to github for collaboration.
- If you want to just run a demo of this infrastructure i suggest just ignore trying to run it on S3 and move on to the below steps

### 0. run

- Make sure to navigate into services/dev and run the below commands
- `terraform init` (run this to initialize terraform)
- `terraform plan` (run this to test your infra before applying)
- `terraform apply` (run this to apply your infra setup)
- `terraform destroy` (run this to destroy all resources created after testing)
- copy the DNS name of your front load balancer to see a sample of your application