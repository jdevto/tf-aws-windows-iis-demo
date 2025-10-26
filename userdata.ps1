# Install IIS
Install-WindowsFeature -name Web-Server -IncludeManagementTools

# Get instance metadata
$instanceId = Invoke-RestMethod -Uri "http://169.254.169.254/latest/meta-data/instance-id"
$az = Invoke-RestMethod -Uri "http://169.254.169.254/latest/meta-data/placement/availability-zone"
$privateIp = Invoke-RestMethod -Uri "http://169.254.169.254/latest/meta-data/local-ipv4"
$hostname = $env:COMPUTERNAME
$osVersion = (Get-ComputerInfo).WindowsProductName

# Create HTML content
$html = @"
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Windows IIS Demo</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            margin: 0;
            padding: 20px;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .container {
            background: white;
            border-radius: 10px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.2);
            padding: 40px;
            max-width: 600px;
            width: 100%;
        }
        h1 {
            color: #667eea;
            text-align: center;
            margin-bottom: 30px;
            border-bottom: 3px solid #667eea;
            padding-bottom: 15px;
        }
        .info-card {
            background: #f8f9fa;
            padding: 15px;
            margin: 15px 0;
            border-radius: 5px;
            border-left: 4px solid #667eea;
        }
        .label {
            font-weight: bold;
            color: #555;
            display: inline-block;
            min-width: 150px;
        }
        .value {
            color: #333;
        }
        .timestamp {
            text-align: center;
            color: #888;
            font-size: 0.9em;
            margin-top: 30px;
            padding-top: 20px;
            border-top: 1px solid #ddd;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Windows IIS on AWS</h1>
        <div class="info-card">
            <span class="label">Instance ID:</span>
            <span class="value">$instanceId</span>
        </div>
        <div class="info-card">
            <span class="label">Availability Zone:</span>
            <span class="value">$az</span>
        </div>
        <div class="info-card">
            <span class="label">Private IP:</span>
            <span class="value">$privateIp</span>
        </div>
        <div class="info-card">
            <span class="label">Hostname:</span>
            <span class="value">$hostname</span>
        </div>
        <div class="info-card">
            <span class="label">Operating System:</span>
            <span class="value">$osVersion</span>
        </div>
        <div class="timestamp">
            Page loaded at: <span id="timestamp"></span>
        </div>
    </div>
    <script>
        document.getElementById('timestamp').textContent = new Date().toLocaleString();
    </script>
</body>
</html>
"@

# Write HTML to IIS directory
Set-Content -Path "C:\inetpub\wwwroot\index.html" -Value $html

# Ensure IIS is running
Start-Service W3SVC
