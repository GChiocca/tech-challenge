[CmdletBinding()]

Param
(
[Parameter(
    Mandatory=$false,
    ValueFromPipelineByPropertyName=$true,
    Position=0
)]
[string]$KeyName
)

Process
{
    if(-not [string]::IsNullOrEmpty($KeyName)){
        Invoke-RestMethod -Headers @{"Metadata"="true"} -Method GET -Uri "http://169.254.169.254/metadata/instance/compute/$($KeyName)?api-version=2021-02-01&format=text" 
    }
    Else{
        Invoke-RestMethod -Headers @{"Metadata"="true"} -Method GET -Uri "http://169.254.169.254/metadata/instance?api-version=2021-02-01" | ConvertTo-Json -Depth 64
    }
}
