Write-host 'Number of arguments was: ' ($args.length)
write-output 'they are:'
foreach($arg in $args)
{
        Write-output $arg
}