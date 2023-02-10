
[CmdletBinding ()]
Param
(
    [string]$name,
    [string]$enclosuregroup,
    [object]$enclosure,
    [string]$ebipaXL
)

$current_enclosure  = ""


$devices            = @{}
$ebipa              = @{}

# Sample of $ebipa              = @{
#    Enclosure0 = @{
#        Device0 = @{
#            IPv4Address = "N/A"
#           }
#        }
#    }



# ----- Read/format Excel file
$_list              = import-excel -path $ebipaXL  -dataonly


foreach ($_el in $_list)
{
    $enc            = $_el.Enclosure
    $device         = $_el.Device
    $ipV4           = $_el.ipV4

    if ([string]::IsNullOrEmpty($current_enclosure))
        {   
            $current_enclosure  = $enc 
            $ebipa              += @{$enc = @{} }
        }
    if ($current_enclosure -ne $enc) 
    {
        if ($devices.Keys.Count -gt 1)
        {
            $ebipa.$current_enclosure   += $devices
            $devices                    = @{}
        }
        $current_enclosure              = $enc 
        $ebipa                          += @{$enc = @{} }
    }

   

    if ($enc -eq $current_enclosure)
    {
        $devices += @{ $device  = @{IPV4Address=$ipV4}}
    }

}

# Last element
$ebipa.$current_enclosure   += $devices

# ----------------- Logical Enclosure

$eg                                 = Get-OVEnclosureGroup -Name $enclosuregroup
$enclosures                         = $enclosure | % { Get-OVenclosure -Name $_ }
New-OVLogicalEnclosure -Name $name -Enclosure ($enclosures | Select -First 1) -EnclosureGroup $eg -Ebipa $ebipa
