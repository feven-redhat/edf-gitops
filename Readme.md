#labs GitOps implementation

Log in to your OpenShift cluster as cluster administrator

Open the Administrator perspective of the web console and navigate to Operators → OperatorHub in the menu on the left.

## Configure the HeadQuarter

Create an ArgoCD application via the cli with the following yaml 

```shell
cat << EOF >> applicatin-argo.yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: argo-application
  namespace: argocd
spec:
  project: default
  source:
    repoURL: https://github.com/RHTE-2023-Edge-Lab/
    targetRevision: HEAD
    path: rhte-gitops/headquarter
  destination: 
    server: https://kubernetes.default.svc
    namespace: headquarter
  syncPolicy:
    syncOptions:
    - CreateNamespace=true
    automated:
      selfHeal: true
      prune: true
EOF
```
```shell
oc apply -f application-argo.yaml
```


## Configure the Warehouse
