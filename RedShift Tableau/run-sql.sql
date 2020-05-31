$rsServer=(Get-RSClusters).Endpoint.Address
$rsPassword="Redshift123"
$rsDatabase="faa" 
$rsUser="administrator" 
$rsPort="5439"

try
{
  $rsConnectionString="Driver={Amazon Redshift (x64)}; Server=$rsServer; Database=$rsDatabase; UID=$rsUser; PWD=$rsPassword; Port=$rsPort"
  $rsConnection=New-Object System.Data.Odbc.OdbcConnection
  $rsConnection.ConnectionString=$rsConnectionString
  $rsCommand=New-Object System.Data.Odbc.OdbcCommand
  $rsConnection.Open()
  $rsCommand.Connection=$rsConnection

  Write-Host -NoNewline "Creating tables........"

  $rsLoadStatement = Get-Content C:\Users\Administrator\Downloads\create-table.sql -Raw
  $rsCommand.CommandText=$rsLoadStatement
  $rsResult=$rsCommand.ExecuteNonQuery()

  Write-Host "Success"

  Write-Host ""

  Write-Host -NoNewline "Loading data..........."

  $rsLoadStatement = Get-Content C:\Users\Administrator\Downloads\load-data.sql -Raw
  $rsLoadStatement = $rsLoadStatement -replace "resdhift_role_arn", "arn:aws:iam::786985637515:role/qls-14322633-527b63cab4b63022-RedshiftRole-RFJCUFMZ27NZ"
  $rsCommand.CommandText=$rsLoadStatement
  $rsResult=$rsCommand.ExecuteNonQuery()

  Write-Host "Success"

  Write-Host ""
}
catch
{
  Write-Host "An error occurred while attempting to initialize Amazon Redshift. Please end the lab and email to aws-course-feedback@amazon.com"
}
finally
{
  if ($rsConnection.State -eq "Open")
  {
    $rsConnection.Close()
  }
}

Write-Host "Press any key to continue...."

$x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
