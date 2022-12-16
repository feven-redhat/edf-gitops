# rhte-2023-lab-deploy

## Configure the HeadQuarter


Create an argoCD project
```shell
oc apply -f headquarter/argocd/project.yaml
EOF
```

Create the argoCD Application
```shell
oc apply -f headquarter/argocd/application.yaml
```



## Configure the Warehouse

Create an argoCD project
```shell
oc apply -f warehoouse/argocd/project.yaml
EOF
```

Create the argoCD ApplicationSet (as we are deploying 10 or more namespaces within the cluster)
```shell
oc apply -f warehouse/argocd/applicationSet.yaml
```

