## Monitoring
1. HTTP Health Checks - The Kubelet will call a web hook. If it returns between 200 and 399, it is considered success, failure otherwise. See health check examples here.
2. Container Exec - The Kubelet will execute a command inside your container. If it exits with status 0 it will be considered a success. See health check examples here.
3. TCP Socket - The Kubelet will attempt to open a socket to your container. If it can establish a connection, the container is considered healthy, if it can’t it is considered a failure.