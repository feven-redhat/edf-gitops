#labs GitOps implementation

Log in to your OpenShift cluster as cluster administrator

Open the Administrator perspective of the web console and navigate to Operators → OperatorHub in the menu on the left.

Create a namespace for argoCD

```shell
oc new-project argocd
```

Create argoCD instance with the following yaml

```shell
cat << EOF >> argocd.yaml
apiVersion: argoproj.io/v1alpha1
kind: ArgoCD
metadata:
  name: argocd
  namespace: argocd
spec:
  server:
    resources:
      limits:
        cpu: 500m
        memory: 256Mi
      requests:
        cpu: 125m
        memory: 128Mi
    route:
      enabled: true
  sso:
    dex:
      resources:
        limits:
          cpu: 500m
          memory: 256Mi
        requests:
          cpu: 250m
          memory: 128Mi
      openShiftOAuth: true
    provider: dex
  rbac:
    defaultPolicy: ''
    policy: |
      g, system:cluster-admins, role:admin
    scopes: '[groups]'
  repo:
    resources:
      limits:
        cpu: 1000m
        memory: 1024Mi
      requests:
        cpu: 250m
        memory: 256Mi
  ha:
    resources:
      limits:
        cpu: 500m
        memory: 256Mi
      requests:
        cpu: 250m
        memory: 128Mi
    enabled: false
  redis:
    resources:
      limits:
        cpu: 500m
        memory: 256Mi
      requests:
        cpu: 250m
        memory: 128Mi
  controller:
    resources:
      limits:
        cpu: 2000m
        memory: 2048Mi
      requests:
        cpu: 250m
        memory: 1024Mi
  resourceExclusions: |
    - apiGroups:
      - tekton.dev
      clusters:
      - '*'
      kinds:
      - TaskRun
      - PipelineRun        
```



## Configure the HeadQuarter

Create an ArgoCD application via the cli with the following yaml 




```shell
cat << EOF >> application-argo.yaml
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
