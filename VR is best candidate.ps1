# Text for unsuccessful and successful candidate/s
$no = "Dear $($candidate.name), 
    We regret to inform you that after careful consideration it has been decided 
    not to proceed with your application on this occasion. 
    Please accept our apologies for the disappointing response.
    Best Wishes"

$yes = "Dear $($bestCandidate.name) , 
    We are happy to inform you that after careful consideration it has been decided 
    to proceed with your application.
    We wish you a warm welcome to our team. 
    Best Regards"

# Candidates data
$candidates = @(
    @{
        Name = "Mr. Vladimir Rackovic"
        Status = "Eligible"
        Experience = 5
        Skills = "Leadership", "Problem-solving", "Teamwork", "Data Engineering", "Power BI", "Data Warehouse", "Synapse Analytics", 
        "Data Factory", "SQL", "DAX", "Python", "PowerShell"
        Education = "Bachelor's Degree"
        Certifications = "Microsoft Azure Data Engineer Associate", "Microsoft Dynamics 365 CRM"
    },
    @{
        Name = "Ms. Jane Doe"
        Status = "Eligible"
        Experience = 8
        Skills = "Communication", "Project Management", "Negotiation", "SQL", "DAX", "Python"
        Education = "Master's Degree"
        Certifications = "AWS Certified Solutions Architect"
    },
    @{
        Name = "Mr. John Doe"
        Status = "Eligible"
        Experience = 3
        Skills = "Technical expertise", "Analytical thinking", "Adaptability", "Python", "PowerShell", "Databricks"
        Education = "Bachelor's Degree"
        Certifications = "Microsoft Azure Data Engineer Fundamentals"
    }
)

# Evaluate candidates
$bestCandidate = $null
$bestScore = 0

foreach ($candidate in $candidates) {
    $score = 0

    #Add points based on Right to Work Status
    if ($candidate.Status -eq "Eligible") {
    $score += 5
    }
    
    # Add points based on experience
    $score += $candidate.Experience

    # Add points based on skills
    if ($candidate.Skills -eq "Data Engineering" -and "Teamwork" -and "Power BI" -and "SQL" -and "PowerShell") {
    $score += $candidate.Skills.Count * 1.5
    }
    elseif ($candidate.Skills -eq "Data Engineering" -or "Teamwork" -or "Power BI" -and "SQL" -or "PowerShell" -or "Databricks") {
    $score += $candidate.Skills.Count * 1.2
    }

    # Add points based on education
    if ($candidate.Education -eq "Master's Degree") {
        $score += 3
    }
    elseif ($candidate.Education -eq "Bachelor's Degree") {
        $score += 2
    }

    # Add points based on certifications
    $score += $candidate.Certifications.Count * 0.5

    # Check if the candidate has the highest score so far
    if ($score -gt $bestScore) {
        $bestScore = $score
        $bestCandidate = $candidate
    }
}

# Print the best candidate name and score and prepare a letter for a successfull candidate
if ($bestCandidate -ne $null) {
    Write-Host "The best candidate is $($bestCandidate.Name) with a score of $bestScore." -ForegroundColor Green -BackgroundColor Black;
    Write-Output $yes |
    Out-File -FilePath C:\Letter_Yes2_$($bestCandidate.Name).txt
}
# Prepare a letter for unseccessful candidate/s
if ($candidate -ne $null) {
    ForEach ($candidate in $candidates) {If ($($candidate.Name) -notlike $($bestCandidate.Name)) { 
    Write-Output $no | 
    Out-File -FilePath C:\Letter_No2_$($candidate.name).txt}}
}
<#
All the data used in the script are for script demonstration purposes only
#>