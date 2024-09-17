# Kubernetes Communication Between Pods

This project demonstrates deploying a full-stack application using **Kubernetes** and **Docker**, consisting of three components:

- **Frontend**
- **Backend**
- **Database (MongoDB)**

We will use **Kind** (Kubernetes IN Docker) to create a local Kubernetes cluster and manage communication between the containers.

---

## Repository Links

- **Kubernetes Communication Between Pods**: [GitHub Repository](https://github.com/AlphaTab435/Kubernetes-Communication-Between-Pods)
- **Docker Images**: [GitHub Repository](https://github.com/AlphaTab435/Communication-between-Docker-containers)

---

## 🛠 Tools & Technologies

- **Kind**: A tool to run local Kubernetes clusters using Docker containers.
- **Docker Desktop**: To manage containers and images.
- **Kubernetes**: For orchestrating containerized services.

---

## 🚀 Prerequisites

1. **Docker Desktop** should be installed and running.
2. Install **Kind**: [Quick Installation Guide](https://kind.sigs.k8s.io/docs/user/quick-start/).
3. Ensure familiarity with Docker container communication (see [this repository](https://github.com/AlphaTab435/Communication-between-Docker-containers)).

---

## 🐳 Docker Images

You will use pre-built Docker images from a previous exercise:

- **Frontend**: `muhammadtabish/mcqs_frontend_already_build`
- **Backend**: `muhammadtabish/mcqs_backend`
- **Database**: `mongo` (Official MongoDB image)

---

## 📋 Steps to Deploy

### 1. **Create Kubernetes Cluster**

First, create the cluster using Kind:

```bash
kind create cluster
```

### 2. **Deploy MongoDB**

The backend depends on the database, so we deploy MongoDB first:

```bash
kubectl create deployment mongo --image=mongo
```

Expose MongoDB as a service for internal communication:

```bash
kubectl expose deployment mongo --name=mongo --port=27017 --type=ClusterIP
```

### 3. **Deploy Frontend**

Deploy the frontend service:

```bash
kubectl create deployment frontend --image=muhammadtabish/mcqs_frontend_already_build
```

Expose the frontend to access it from outside the cluster:

```bash
kubectl expose deployment frontend --name=frontend --port=80 --type=NodePort
```

### 4. **Deploy Backend**

Once MongoDB is running, deploy the backend:

```bash
kubectl create deployment backend --image=muhammadtabish/mcqs_backend
```

Expose the backend service:

```bash
kubectl expose deployment backend --name=backend --port=3000 --type=NodePort
```

---

## 🔌 Port Mapping

You can use PowerShell to map ports for accessing the frontend and backend services:

```bash
Start-Job -ScriptBlock {kubectl port-forward service/backend 3000:3000}
Start-Job -ScriptBlock {kubectl port-forward service/frontend 80:80}
```

To manage jobs:

```bash
Get-Job           # List running jobs
Stop-Job -Id      # Stop a job
Remove-Job -Id    # Remove a job
```

---

## 🐞 Troubleshooting

If you encounter an **ImagePullBackOff** error, it could be due to:

- Images not being public.
- Images not being pushed to Docker Hub.

Check the pod logs for debugging:

```bash
kubectl logs <pod-name>
```

---

## 📝 Deploy Using YAML (Alternative)

You can deploy all components at once using the provided **YAML configuration** from the GitHub repository.

### Steps:

1. Create a cluster:

   ```bash
   kind create cluster
   ```

2. Apply the deployment configuration:

   ```bash
   kubectl apply -f deployment.yaml
   ```

---

## 🧹 Cleanup

Once you are done with testing, clean up your resources:

```bash
kubectl delete -f deployment.yaml
kind delete cluster
```

---

## 📚 Learn More

To understand the fundamentals of Docker container communication, visit the [Communication Between Docker Containers](https://github.com/AlphaTab435/Communication-between-Docker-containers) repository.
