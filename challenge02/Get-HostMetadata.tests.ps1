import-Module Pester -MinimumVersion 5.3.1

$get_api = Invoke-RestMethod -Headers @{"Metadata"="true"} -Method GET -Uri "http://169.254.169.254/metadata/instance?api-version=2021-02-01&format=json" 
$keys = $get_api.compute  | Get-Member | Where-Object{$_.MemberType -eq "NoteProperty"} | Select-Object -ExpandProperty name

Describe 'Test Api return' {
  Context 'no parameters' {
  
    It "Given no parameters, it lists all keys" {
      $allkeys = .\Get-HostMetadata.ps1 | ConvertFrom-Json
      ($allkeys.compute | Measure-Object).Count | Should -Be ($keys | Measure-Object).length
    }

  }
  Context "Filtering on keys" {
    foreach($key in $keys){
      It "$key should be a string" {
        .\Get-HostMetadata.ps1 -KeyName $key | Should -BeOfType System.String
      }
    }
  }
}