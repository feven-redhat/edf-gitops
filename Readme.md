# rhte-2023-lab-deploy

This repo contains the material to deploy the headquarter and warehouse argoCD applications.

For this lab, everything will be deployed in the same cluster :
- headquarter will be deployed in the headquarter namespace
- 10 warehouses namespaces are being deployed

## Deploy ArgoCD, cluster-wide subscriptions and create namespaces (in the gitops version we have now, we can't add labels when they are created by ArgoCD)
```shell
oc apply -f gitops/sub.yaml
oc apply -f gitops/ns.yaml
oc apply -f gitops/rbac.yaml
oc apply -f gitops/idp.yaml
oc delete clusterrolebinding self-provisioners
```

## Configure the Headquarter

Create the argoCD headquarter project
```shell
oc apply -f headquarter/argocd/project.yaml
```

Create the argoCD Application
```shell
oc apply -f headquarter/argocd/application.yaml
```



## Configure the Warehouse (normally, not to be used as that's the target of the lab ;) )

### All Namespaces

Create the argoCD warehouse project
```shell
oc apply -f warehouse/argocd/project.yaml
```

Create the argoCD ApplicationSet (as we are deploying 10 or more namespaces within the cluster)
```shell
oc apply -f warehouse/argocd/applicationSet.yaml
```

### Hack without argocd

Deploy only in a particular namespace if a team need the solution
```shell
oc -n <NAMESPACE> apply -k warehouse/base/
```

