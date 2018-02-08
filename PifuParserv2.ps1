<#

 Test to parse pifu, an get somthing usefull out of it.



#>

[XML]$pifuDocument = Get-Content .\Examples\PIFU-IMS_SAS_eksempel.xml -Encoding UTF8

#$pifuDocument.'#comment'
$personer = $pifuDocument.enterprise.person

$pifupersonobject = @()

foreach ($person in $personer) {
$pifuobject = New-Object System.Object
$person.name.fn


$displayName,$gienvName,$surnam,$lang,$sourcedidsource,$sourcedid,$personnr,$sisID,$birthday = $null
$studen,$employee = $false



##Firstly FEIDE INFO

#$person.ChildNodes

#$displayName = $person.name.fn
$pifuobject | Add-Member -type NoteProperty -Name "FullName" -Value $person.name.fn
#$gienvName   =  $person.name.N.given
$pifuobject | Add-Member -type NoteProperty -Name "GivenName" -Value $person.name.given
#$surname     = $person.name.N.family
$pifuobject | Add-Member -type NoteProperty -Name "Surname" -Value $person.N.family
#$lang        = $person.comments.Attributes
$sourcedidsource   = $person.sourcedid.source
$pifuobject | Add-Member -type NoteProperty -Name "sidsource" -Value $person.sourcedid.source
$sourcedidid   = $person.sourcedid.id
$pifuobject | Add-Member -type NoteProperty -Name "sourceid" -Value $person.sourcedid.id


if($person.Item("demographics") -ne $null ){
$gender =  $person.demographics.gender
$pifuobject | Add-Member -type NoteProperty -Name "gender" -Value $person.demographics.gender
$birthday = get-date $person.demographics.bday
$pifuobject | Add-Member -type NoteProperty -Name "bday" -Value $person.demographics.bday
} else {$birthday = $null}

    foreach ($thing in $person.userid) {
    
        if($thing.useridtype -eq "personNIN") {$pifuobject | Add-Member -type NoteProperty -Name "PersonNIN" -Value $thing.'#text'}
        if($thing.useridtype -eq "sisID") {$pifuobject | Add-Member -type NoteProperty -Name "sisID" -Value $thing.'#text'; $student = $true}
        if($thing.useridtype -eq "workforceID") {$pifuobject | Add-Member -type NoteProperty -Name "workForceID" -Value $thing.'#text'; $employee = $true}

    
    }

$pifuobject | Add-Member -type NoteProperty -Name "mail" -Value $person.email

if($person.adr -ne $null) {

$pifuobject | Add-Member -type NoteProperty -Name "Address" -Value "$($person.adr.extadd,$person.adr.street,$person.adr.locality)"

} else {$adresse = $null}


$pifupersonobject += $pifuobject

    #Write-Host $displayName,$gienvName,$surnam,$lang,$sourcedidsource,$sourcedid,$personnr,$sisID,"studenr:",$student,"Employee:",$employee,$birthday,$gender,$email,$adresse
    #"--"
}


$pifupersonobject






$Grupper = $pifuDocument.enterprise.group
$Grupper | Select-Xml 

foreach ($gruppe in $Grupper) {
"################################"
#$gruppe.'#comment'
<#$gruppe.extension.pifu_id
$gruppe.extension.pifu_id
$gruppe.Name
$gruppe.sourcedid.id
#>
#$grupper[1]
#$gruppe.grouptype[1]
$gruppe.grouptype.typevalue
$gruppe.timeframe.adminperiod
$gruppe.url

}

$members = $pifuDocument.enterprise.membership

foreach ($member in $members) {

$member.'#comment'
$member.member.idtype
$membes.member.role
$membes.member.sourceid

$member.sourcedid.source
$member.sourcedid.'#comment'


}

