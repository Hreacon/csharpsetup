$path = (Get-Item -Path ".\\" -Verbose).FullName
$env:Path = $env:Path + ";" + $path
