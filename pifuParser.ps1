<#

 Test to parse pifu, an get somthing usefull out of it.



#>

[XML]$pifuDocument = Get-Content .\Examples\PIFU-IMS_SAS_eksempel.xml -Encoding UTF8

#$pifuDocument.'#comment'
$personer = $pifuDocument.enterprise.person

foreach ($person in $personer) {

$displayName,$gienvName,$surnam,$lang,$sourcedidsource,$sourcedid,$personnr,$sisID,$birthday = $null
$studen,$employee = $false



##Firstly FEIDE INFO

#$person.ChildNodes

$displayName = $person.name.fn
$gienvName   =  $person.name.N.given
$surname     = $person.name.N.family
$lang        = $person.comments.Attributes

$sourcedidsource   = $person.sourcedid.source
$sourcedidid   = $person.sourcedid.id

if($person.Item("demographics") -ne $null ){
$gender =  $person.demographics.gender
$birthday = get-date $person.demographics.bday
} else {$birthday = $null}

    foreach ($thing in $person.userid) {
    
        if($thing.useridtype -eq "personNIN") {$personnr = $thing.'#text'}
        if($thing.useridtype -eq "sisID") {$sisID = $thing.'#text'; $student = $true}
        if($thing.useridtype -eq "workforceID") {$workforceID = $thing.'#text'; $employee = $true}

    
    }

$email = $person.email

if($person.adr -ne $null) {

$adresse = $person.adr.extadd,$person.adr.street,$person.adr.locality

} else {$adresse = $null}



    Write-Host $displayName,$gienvName,$surnam,$lang,$sourcedidsource,$sourcedid,$personnr,$sisID,"studenr:",$student,"Employee:",$employee,$birthday,$gender,$email,$adresse
    "--"
}





