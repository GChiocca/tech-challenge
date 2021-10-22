$object01 = @{
    "a"= @{
        "b" = @{"c" = "d"}
    }
}

$object02 = @{
    "x"= @{
        "y" = @{"z" = "a"}
    }
}

$users = @{
    "john"= @{
        "age" = "30"
    }
    "meg"= @{
        "age" = "25"
    }    
}

$wines = @{
    italy = @{
        "name" = "Borolo"
        "colour" = "red"
    }
    france = @{
        "name" = "Bordeaux"
        "colour" = "red"
    }
    spain = @{
        "name" = "Rioja"
        "colour" = "white"
    }
}

function Get-HashValue {
    Param
    (
        [Parameter(Mandatory=$true)]$object,
        [Parameter(Mandatory=$true)]$key
    )
    if( $Object.GetType().Name -ne "Hashtable" ){
        Write-Error "$Object should be a hash table"
    }
    Else{
        # gathering all keys in object 
        $keys = $object.Keys
        foreach($k in $keys){
            # return if matches
            if($k -eq $key){
                return $object[$key]
                break
            }
        }
    }
}
Get-HashValue -Object $object01 -Key "a"
Get-HashValue -Object $object02 -Key "x"
Get-HashValue -Object $object02 -Key "y"
Get-HashValue -Object $users -Key "john"
Get-HashValue -Object $users -Key "meg"
Get-HashValue -Object $wines -Key "spain"
