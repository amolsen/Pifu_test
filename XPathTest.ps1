
[XML]$pifuDocument = Get-Content .\Examples\PIFU-IMS_SAS_eksempel.xml -Encoding UTF8

#$pifuDocument.'#comment'
$personer = $pifuDocument.enterprise.person

$pifupersonobject = @()


    $xpath='/enterprise/group/grouptype[scheme="pifu-ims-go-org" and typevalue[@level=2]]/ancestor::group';

$pifuDocument  | select-xml -xpath $xpath