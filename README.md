## Create Logical Enclosure with EBIPA setting 

The PowerShell script creates a Logical Enclosure in Synergy with EBIPA settings. It is used in a scenario when administrator wants to assign static IP addresses for Device Bays and Interconnect modules.

The script reads IP addresses from an Excel spreadsheet and generates a hash table to be used in the new-OVLogicalEnclosure command.

**Note**: IP addresses listed in the Excel file are for demo purposes only

## Prerequisites
* HPE ONeView PowerShell library : ```` install-module -name HPEOneView.800 ````
* Import-Excel module: ````install-module -name ImportExcel ````

## To run the script
````
Connect-OVMgmt -hostname <OV-IP> -credential <OV-credential>
.\newLogicalEnclosure.ps1 -name <le-name> -enclosuregroup <eg-name> -enclosure <list-of-enclosures> -ebipaXL EBIPA.xlsx
````

Enjoy!



