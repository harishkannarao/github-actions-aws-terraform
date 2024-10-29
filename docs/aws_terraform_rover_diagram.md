# AWS Terraform Component diagram using Rover

AWS component diagram using [Rover](https://github.com/im2nguyen/rover)

    mkdir -p ignored

Create a plan output using terraform

    export ENV_NAME='development'

    terraform -chdir=environments/$ENV_NAME init -reconfigure -input=false

    terraform -chdir=environments/$ENV_NAME validate

    terraform -chdir=environments/$ENV_NAME plan -input=false -var-file="../../variables/$ENV_NAME.tfvars" -out ../../ignored/plan.out

Convert plan output as json output

    terraform -chdir=environments/$ENV_NAME show -json ../../ignored/plan.out > ./ignored/plan.json

Then run the rover by loading the plan json output

    docker run --rm -it -p 9000:9000 -v $(pwd)/ignored/plan.json:/src/plan.json im2nguyen/rover:latest -planJSONPath=plan.json

Go to web browser to see the generated diagram and download it

    http://localhost:9000