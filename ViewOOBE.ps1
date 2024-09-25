New-HTML -TitleText 'OOBE' -Online -FilePath $PSScriptRoot\OOBE.html {
    New-HTMLPanel {
        New-HTMLDiagram -Height '2000px' -Width '3000px' {
            New-DiagramOptionsInteraction -Hover $true
            New-DiagramOptionsPhysics -Enabled $true
            New-DiagramOptionsLayout -RandomSeed 0
            New-DiagramOptionsLinks -ArrowsToEnabled $true -Color BlueViolet -ArrowsToType arrow -ArrowsFromEnabled $false
            New-DiagramOptionsNodes -BorderWidth 1 -FontColor Black -Size 16 -FontMulti true
            $file = "C:\Windows\SystemApps\Microsoft.Windows.CloudExperienceHost_cw5n1h2txyewy\data\prod\navigation.json"
            $nav = Get-Content $file | ConvertFrom-Json -Depth 999 -AsHashtable
            $nav.FRXINCLUSIVE.Keys | ? { $nav.FRXINCLUSIVE.$_.count -gt 1} | % {
                Write-Host "$_ :"
                New-DiagramNode -Label "$_" -IconSolid desktop -Title "$_"
                if ($null -ne $nav.FRXINCLUSIVE.$_.successID) {
                    Write-Host " linked to $($nav.FRXINCLUSIVE.$_.successID)"
                    New-DiagramLink -From "$_" -To "$($nav.FRXINCLUSIVE.$_.successID)"
                }
            }
        }
    }
} -ShowHTML