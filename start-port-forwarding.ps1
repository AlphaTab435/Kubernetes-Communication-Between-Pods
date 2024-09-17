# Define the script block for port forwarding backend service
$backendPortForwarding = {
    kubectl port-forward service/backend 3000:3000
}

# Define the script block for port forwarding frontend service
$frontendPortForwarding = {
    kubectl port-forward service/frontend 80:80
}

# Start the port forwarding jobs
Start-Job -ScriptBlock $backendPortForwarding
Start-Job -ScriptBlock $frontendPortForwarding

# Optional: Wait for jobs to complete (if needed) or add other logic here
# Start-Job -ScriptBlock {kubectl port-forward service/backend 3000:3000}
# Start-Job -ScriptBlock {kubectl port-forward service/frontend 80:80}
# Stop-Job Id
# Remove-Job Id
# Get-Job