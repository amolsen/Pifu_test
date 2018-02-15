
$pifuContent = Get-Content .\Examples\PIFU-IMS_SAS_eksempel.xml -Encoding UTF8

[XML]$pifuDocument = $pifuContent.Replace(' xmlns="http://pifu.no/xsd/pifu-ims_sas/pifu-ims_sas-1.1"',"")


#$pifuDocument.'#comment'
$personer = $pifuDocument.enterprise.person
$pifupersonobject = @()


$skolexpath ='/enterprise/group/grouptype[scheme="pifu-ims-go-org" and typevalue[@level=2]]/ancestor::group'

$groupxpath = '/enterprise/group/relationship/sourcedid/id[.='+$s+']/ancestor::group/grouptype/typevalue[@level='+$d+']/ancestor::group'

#$xpath="/enterprise/group/grouptype[@scheme='pifu-ims-go-org' and typevalue[@level=2]]/ancestor::group";

    $xpath3="/enterprise/group/grouptype[@scheme]";
<#
$skoler = $pifuDocument  | select-xml -xpath $skolexpath



foreach($skole in $skoler) {

$props = @{
name = $skole.Node.description.short
orgnummer = $($skole.Node.extension.pifu_id | where type -Like organizationNumber| select pifu_value).pifu_value
domain = $($skole.Node.extension.pifu_id | where type -Like domainName| select pifu_value).pifu_value

}
$skole.Node.extension.pifu_email.'#text'

$schoolobj = New-Object -TypeName psobject -Property  $props

$schoolobj

#$skole.extension.descrption.short
#$skole | Select-Xml '//pifu_id[@type="organizationNumber"]'

#$skole.extension.pifu_id | where type -Like "organi*" | select type,pifu_value,pifu_name
#$skoleinfo

}

function skoler {

$skolerxph = '/enterprise/group/grouptype[scheme="pifu-ims-go-org" and typevalue[@level=2]]/ancestor::group'

$return = $pifuDocument | Select-Xml $skoler

return $return.Group



}
#>



foreach ($person in $personer) {
"##"
$person.name.fn
"##"
$person.comments.lang
$person.sourcedid.source
$person.sourcedid.id
$person.userid

}






function testgroup {
param([string]$s ="global_ID_org_17",
        [string]$d ="2")

        #//global_ID_org_17
        #//level = 2 

    $groupxpath = '/enterprise/group/relationship/sourcedid/id[.='+$s+']/ancestor::group/grouptype/typevalue[@level='+$d+']/ancestor::group'


        $test = $pifuDocument | Select-Xml -XPath $groupxpath

        return $test
}


testgroup -s "global_ID_org_17" -d 2