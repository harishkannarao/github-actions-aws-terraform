# AWS Terraform Graph

Terraform graphs using [GraphViz](https://www.graphviz.org)

    mkdir -p ignored

Create a graph based on current state of AWS

    terraform graph -type=refresh environments/$ENV_NAME | dot -Tpng > ignored/refresh_graph.png

Create a graph based on new changes to be applied in AWS

    terraform graph -type=plan environments/$ENV_NAME | dot -Tpng > ignored/plan_graph.png

    terraform graph -type=apply environments/$ENV_NAME | dot -Tpng > ignored/apply_graph.png

Create a graph based on new changes to be destroyed in AWS

    terraform graph -type=plan-destroy environments/$ENV_NAME | dot -Tpng > ignored/plan_destroy_graph.png