# AWS Terraform Graph

Terraform graphs using [GraphViz](https://www.graphviz.org)

    mkdir -p ignored

Create a graph based on current state of AWS

    terraform -chdir=environments/$ENV_NAME graph -type=refresh | dot -Tpng > ignored/refresh_graph.png

Create a graph based on new changes to be applied in AWS

    terraform -chdir=environments/$ENV_NAME graph -type=plan | dot -Tpng > ignored/plan_graph.png

    terraform -chdir=environments/$ENV_NAME graph -type=apply | dot -Tpng > ignored/apply_graph.png

Create a graph based on new changes to be destroyed in AWS

    terraform -chdir=environments/$ENV_NAME graph -type=plan-destroy | dot -Tpng > ignored/plan_destroy_graph.png