# Powershell MS Teams alert template
# 
# This is a template to demonstrate the ability to send notices to 
# Microsoft Teams from PowerShell
# 
# Parse the command variables
param (
    [string]$message = "This is a test of the alert system",
    [string]$title = "Test Message",
    [string]$status = "Cleared",
    [string]$monitor = "Testing - monitor",
    [string]$location = "Downtown",
    [string]$system = "labsys01"
)

# Edit the URI with the webhook url that was provided
$uri = 'https://outlook.office365.com/webhook/MISSING';

# Build the message Body
$body = ConvertTo-Json -Depth 4 @{
    title = $title
    text = ' '
    sections = @(
        @{
            activityText = $message
        },
        @{
            facts = @(
                @{
                    name = 'Status'
                    value = $status
                },
                @{
                    name = 'System Name'
                    value = $system
                },
                @{
                    name = 'Monitor'
                    value = $monitor
                },
                @{
                    name = 'Location'
                    value = $location
                }
            )
        }
    )
}

#Send the message to MS Teams
Invoke-RestMethod -uri $uri -Method Post -body $body -ContentType 'application/json';

Write-Output "INFO - Message has been sent.";