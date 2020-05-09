# Author: Tyler Petty
# Date: 5/9/2020
# Description: Find either quoted or unquoted service paths

# Do a service dump and save all service names to array, $services
$services = @(Get-Service | Select-Object -Property Name)

foreach ($service in $services) 
    { 
        # Execute a search on services and return only the BINARY_PATH_NAME from the output
        # \s Matchs the whitespace
        # * Match any number of times
        # : The output contained a :
        # \s Match the one whitespace
        # "C: Match the text

        # return all quoted service paths
        sc.exe qc $service.Name | Select-String -Pattern 'BINARY_PATH_NAME\s*:\s"C:'

        # return all unquoted service paths
        sc.exe qc $service.Name | Select-String -Pattern 'BINARY_PATH_NAME\s*:\sC:'
    }