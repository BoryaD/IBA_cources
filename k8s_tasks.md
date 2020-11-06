## Task1
	Deplyment.YAML:

		apiVersion: apps/v1
		kind: Deployment
		metadata:
		  name:   app
		spec:
		  replicas: 2 
		  selector:
		    matchLabels:
		      app: app
		  strategy:
		    rollingUpdate:
		      maxSurge: 1
		      maxUnavailable: 1
		    type: RollingUpdate
		  template:
		    metadata:
		      labels:
		        app: app
		    spec:
		      containers:
		      - image: nginx:1.17
		        name: nginx
		        ports:
		        - containerPort: 80
	Service.YAML: 

		kind: Service
		apiVersion: v1
		metadata:
		  name: myservice
		spec:
		  selector:
		    app: app
		  ports:
		  - protocol: TCP
		    port: 80
		    targetPort: 80


## Task2
	Command: 
		kubectl create configmap configapp --from-file=default.conf

	With command kubectl get configmaps configapp -o yaml get config.YAML

	Config.YAML

		apiVersion: v1
		data:
		  default.conf: |
		    server {
		        listen       80 default_server;
		        server_name  _;

		        default_type text/plain;

		        location / {
		            return 200 '$hostname request: $request_uri\n';
		        }
		    }
		kind: ConfigMap
		metadata:
		  creationTimestamp: "2020-11-05T18:19:07Z"
		  managedFields:
		  - apiVersion: v1
		    fieldsType: FieldsV1
		    fieldsV1:
		      f:data:
		        .: {}
		        f:default.conf: {}
		    manager: kubectl-create
		    operation: Update
		    time: "2020-11-05T18:19:07Z"
		  name: configapp
		  namespace: dashko
		  resourceVersion: "47308"
		  selfLink: /api/v1/namespaces/dashko/configmaps/configapp
		  uid: d232720d-4bc2-4598-8ee7-c956d4302dcf


## Task3
	Deployment.YAML:
		apiVersion: apps/v1
		kind: Deployment
		metadata:
		  name:   app
		spec:
		  replicas: 2 
		  selector:
		    matchLabels:
		      app: app
		  strategy:
		    rollingUpdate:
		      maxSurge: 1
		      maxUnavailable: 1
		    type: RollingUpdate
		  template:
		    metadata:
		      labels:
		        app: app
		    spec:
		      containers:
		      - image: nginx:1.17
		        name: nginx
		        ports:
		        - containerPort: 80
		        volumeMounts:
		        - name: config
		          mountPath: /etc/nginx/conf.d
		      volumes:
		      - name: config
		        configMap:
		          name: configapp


## Task4
	Secret.YAML
		apiVersion: v1
		kind: Secret
		metadata:
		  name: mysecret
		type: Opaque
		data:
		  USER_NAME: DASHKO==
		  PASSWORD: PASSWORD



## Task5
	Command:
		kubectl create configmap config2 --from-file=default-secret.conf

	Configmap.YAML:

		apiVersion: v1
		data:
		  default-secret.conf: |
		    server {
		        listen       80 default_server;
		        server_name  _;

		        default_type text/plain;

		        location /secret {
		          root /opt;
		        }

		        location / {
		            return 200 '$hostname request: $request_uri\n';
		        }
		    }
		kind: ConfigMap
		metadata:
		  creationTimestamp: "2020-11-05T19:05:03Z"
		  managedFields:
		  - apiVersion: v1
		    fieldsType: FieldsV1
		    fieldsV1:
		      f:data:
		        .: {}
		        f:default-secret.conf: {}
		    manager: kubectl-create
		    operation: Update
		    time: "2020-11-05T19:05:03Z"
		  name: config2
		  namespace: dashko
		  resourceVersion: "48041"
		  selfLink: /api/v1/namespaces/dashko/configmaps/config2
		  uid: 14c63b45-0f44-4649-a75b-74ac9e1c9bb2


## Task6
	Just copy file Deployment and rename it to appsecret.YAML


## Task7

	appsecret.YAML:
		apiVersion: apps/v1
		kind: Deployment
		metadata:
		  name:   app1
		spec:
		  replicas: 2 
		  selector:
		    matchLabels:
		      app: app1
		  strategy:
		    rollingUpdate:
		      maxSurge: 1
		      maxUnavailable: 1
		    type: RollingUpdate
		  template:
		    metadata:
		      labels:
		        app: app1
		    spec:
		      containers:
		      - image: nginx:1.17
		        name: nginx
		        ports:
		        - containerPort: 80
		        volumeMounts:
		        - name: config
		          mountPath: /etc/nginx/conf.d
		        - name: secret
		          mountPath: /opt/secret.yaml
		      volumes:
		      - name: config
		        configMap:
		          name: config2
		      - name: secret
		        hostPath:
		          path: /secret.yaml
          
## Task8 
	command:
		kubectl apply -f appsecret.yaml

	command: 
		kubectl get po
	resul:
		NAME   READY   UP-TO-DATE   AVAILABLE   AGE
		app    2/2     2            2           16h
		app1   2/2     2            2           14h


## Task9
	service2.YAML:
		kind: Service
		apiVersion: v1
		metadata:
		  name: myserv1
		spec:
		  selector:
		    app: app1
		  ports:
		  - protocol: TCP
		    port: 80
		    targetPort: 80 

	Commans and results:
		C:\Users\User>kubectl get ep
		NAME      ENDPOINTS                           AGE
		myserv    172.30.100.33:80,172.30.100.34:80   14h
		myserv2   172.30.100.46:80,172.30.100.47:80   14h

		C:\Users\User>kubectl get pod -o wide
		NAME                    READY   STATUS    RESTARTS   AGE   IP              NODE             NOMINATED NODE   READINESS GATES
		app-757b8975cb-x5q67    1/1     Running   0          15h   172.30.100.34   10.144.185.200   <none>           <none>
		app-757b8975cb-xgpfj    1/1     Running   0          15h   172.30.100.33   10.144.185.200   <none>           <none>
		app1-75c48c4b6d-htmfx   1/1     Running   0          14h   172.30.100.46   10.144.185.200   <none>           <none>
		app1-75c48c4b6d-wsgk5   1/1     Running   0          14h   172.30.100.47   10.144.185.200   <none>           <none>
