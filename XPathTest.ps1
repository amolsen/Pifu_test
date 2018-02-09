
[XML]$pifuDocument = Get-Content .\Examples\PIFU-IMS_SAS_eksempel.xml -Encoding UTF8

#$pifuDocument.'#comment'
$personer = $pifuDocument.enterprise.person

$pifupersonobject = @()


$xpath2='/enterprise/group/grouptype[scheme="pifu-ims-go-org" and typevalue[@level=2]]';
    $xpath="/enterprise/group/grouptype[@scheme='pifu-ims-go-org' and typevalue[@level=2]]/ancestor::group";
    $xpath3="/enterprise/group/grouptype[@scheme]";

$pifuDocument  | select-xml -xpath $xpath3