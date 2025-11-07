Kubernetes Ingress Setup
This guide explains how to deploy an NGINX Ingress Controller and configure Ingress resources to route traffic to services inside a Kubernetes cluster.

✅ Prerequisites
You need:

A Kubernetes cluster (Minikube, Docker Desktop, EKS, GKE, etc.)

kubectl installed and configured

Optional: minikube for local development

✅ 1. Install NGINX Ingress Controller
Using Minikube:
bash
Copy code
minikube addons enable ingress
Verify installation:

bash
Copy code
kubectl get pods -n ingress-nginx
kubectl get svc -n ingress-nginx
✅ 2. Create a Service
Example: app-service.yaml

yaml
Copy code
apiVersion: v1
kind: Service
metadata:
  name: app-service
spec:
  selector:
    app: app
  ports:
    - protocol: TCP
      port: 80
      targetPort: 8080
Apply:

bash
Copy code
kubectl apply -f app-service.yaml
✅ 3. Create an Ingress Resource
Example: app-ingress.yaml

yaml
Copy code
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: app-ingress
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
spec:
  rules:
    - host: app.local
      http:
        paths:
          - path: /
            pathType: Prefix
            backend:
              service:
                name: app-service
                port:
                  number: 80
Apply:

bash
Copy code
kubectl apply -f app-ingress.yaml
✅ 4. Add Hostname Entry (Local Development)
Edit /etc/hosts:

bash
Copy code
sudo nano /etc/hosts
Add:

lua
Copy code
127.0.0.1 app.local
Or if using Minikube:

bash
Copy code
echo "$(minikube ip) app.local" | sudo tee -a /etc/hosts
✅ 5. Test the Ingress
bash
Copy code
curl http://app.local
Or open in your browser:

arduino
Copy code
http://app.local
✅ 6. Troubleshooting
Check Ingress events:
bash
Copy code
kubectl describe ingress app-ingress
Check NGINX controller logs:
bash
Copy code
kubectl logs -n ingress-nginx deployment/ingress-nginx-controller
Check endpoints:
bash
Copy code
kubectl get endpoints app-service
Verify service port map:
Service targetPort must match your Pod's containerPort.

✅ Summary
Component	Purpose
Ingress Controller	Receives external traffic
Ingress Resource	Rules for routing traffic
Service	Exposes pods inside the cluster
Pods	Your application containers

