# Script que comprime os arquivos em .Zip no desktop, copia o .Zip para pasta desejada
#
#########################################################
##################### Scheduled Job #####################

$daily = New-JobTrigger -Daily -At "7:00 PM"
Register-ScheduledJob -Name Backup -Trigger $daily -ScriptBlock {
    ##################### Declaração de variaveis #####################
    
    $date= Get-Date -Format "yyyy MMM dd"
    $compressedFile = "C:\EXAMPLE\Exampe-$date.Zip"
    $compressedFileDestiny = "C:\EXAMPLE\Backup"
    $logfile = "C:\EXAMPLE\Backup\logfile-$date.txt"
    
    #$accessKeyID = "insert key id"
    #$secretAccessKey = "insert secret access key"
    #$defaultRegion = "insert region"
    
    ##################### Comprimindo dados #####################
    $compress = @{
        Path = "C:\example.txt", "C:\EXAMPLE.txt"
        CompressionLevel = "Fastest"
        DestinationPath = "C:\CompressFilesTest-$date.Zip"
    } 
    Compress-Archive @compress -Update -Verbose *> $logfile
    
    ##################### Cria dir. e ou envia arq. comprimido para pasta desejada #####################
    if (!(Test-Path $compressedFileDestiny)) {
        Write-Host $compressedFileDestiny does not exists. Creating new Dir $compressedFileDestiny
        New-Item $compressedFileDestiny -ItemType Directory -Force -Verbose *>> $logfile
        Test-Path $compressedFileDestiny
        Copy-Item $compressedFile  $compressedFileDestiny -Recurse -Force -Verbose *>> $logfile
    
    }
    else {
        Write-Host $compressedFileDestiny already exists. Proceeding if copy.
        Copy-Item $compressedFile $compressedFileDestiny -Recurse -Force -Verbose *>> $logfile
    }

    ##################### AWS S3 Upload #####################

    #aws configure set AWS_ACCESS_KEY_ID $accessKeyID
    #aws configure set AWS_SECRET_ACCESS_KEY $secretAccessKey
    #aws configure set default.region $defaultRegion

    #aws s3 sync $compressedFileDestiny s3://mybucket
    #aws s3 ls s3://mybucket --recursive --human-readable --summarize
}

# Get-ScheduledJob Backup | Unregister-ScheduledJob
# Get-Command -Module PSScheduledJob | Sort-Object Noun