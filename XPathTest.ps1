
$pifuContent = Get-Content .\Examples\PIFU-IMS_SAS_eksempel.xml -Encoding UTF8

[XML]$pifuDocument = $pifuContent.Replace(' xmlns="http://pifu.no/xsd/pifu-ims_sas/pifu-ims_sas-1.1"',"")


#$pifuDocument.'#comment'
$personer = $pifuDocument.enterprise.person

$pifupersonobject = @()


$skolexpath ='/enterprise/group/grouptype[scheme="pifu-ims-go-org" and typevalue[@level=2]]/ancestor::group'

$groupxpath = '/enterprise/group/relationship/sourcedid/id[.='+$s+']/ancestor::group/grouptype/typevalue[@level='+$d+']/ancestor::group'
#$xpath="/enterprise/group/grouptype[@scheme='pifu-ims-go-org' and typevalue[@level=2]]/ancestor::group";
    $xpath3="/enterprise/group/grouptype[@scheme]";



$skoler = $pifuDocument  | select-xml -xpath $skolexpath

foreach($skole in $skoler.Node) {
$skole.extension.pifu_id | where type -Like "organi*" | select type,pifu_value,pifu_name
$skoleinfo

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