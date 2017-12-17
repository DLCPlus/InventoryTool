#exportinventoryitems: take all itms from shopify shop and sort through them for further processing.


#build auth headers for shop
$uri = "https://dlcplus.myshopify.com/admin/products.json"
$apikey = ""
$password = ""
$headers = @{"Authorization"  = "Basic " + [System.Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($apikey+":"+$password))}


#make request for information from shopify 
$products = Invoke-RestMethod -Uri $uri -contentType 'application/json' -Method Get -Headers $headers 


    $mainobject = $products.products
    $variants = $products.products.variants
    $options = $products.products.options
    $images = $products.products.images 

For($u=0 ; $u -le ($products.products.Count-1) ; $u++){
    
    $mainobject = $products.products[$u]
    $vararray=@() 
    $oparray=@()
    $imgarray=@()

    For($r=0; $r -le ($products.products.variants.Count-1) ; $r++){
    
        if($products.products[$u].id -eq $variants[$r].product_id){
         $vararray += $variants[$r] 

        }
        else{
        

        }

    }

    For($q=0; $q -le ($products.products.options.Count-1) ; $q++){
        
        if($products.products[$u].id -eq $options[$q].product_id){
        $oparray += $options[$q]
                 
        }
        else{
        
        
        }}

    For($i=0; $i -le ($products.products.images.Count-1) ; $i++){
    
        if($products.products[$u].id -eq $images[$i].product_id){
        $imgarray += $images[$i]
        
        }
        else{}
    
    }
    

  
  $mainobject , $vararray , $oparray, $imgarray | Format-Table @{label='id';e={$mainobject.id}} , price , updated_at , inventory_quantity , values , src 

}

