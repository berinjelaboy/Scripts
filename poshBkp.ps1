Get-Command -Module PSScheduledJob | Sort-Object Noun

$diario = New-JobTrigger -Daily at 2pm
$umavez = New-JobTrigger -Once -At (Get-Date).AddHours(1)
$semanal = New-JobTrigger -Weekly -DaysOfWeek Monday -At 6pm

Register-ScheduledJob -name Backup -Trigger $diario -ScriptBlock {
    Copy-Item C:\Scripts\*.* C:\OneDrive\Scripts\ -Recurse -Force
}

Get-ScheduledJob Backuup | Unregister-ScheduledJob