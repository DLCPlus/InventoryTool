#exportinventoryitems: take all itms from shopify shop and output ID and price and quantity of stock(including variants).


#build auth headers for shop
$uri = "https://dlcplus.myshopify.com/admin/products.json"
$apikey = ""
$password = ""
$headers = @{"Authorization"  = "Basic " + [System.Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($apikey+":"+$password))}


#make request for information from shopify 
$products = Invoke-RestMethod -Uri $uri -contentType 'application/json' -Method Get -Headers $headers 

#create variables to hold parts of json as we flatten it out
$imagescount = $products.products.images.Count
$optionscount = $products.products.options.Count

   

#First for loop , we're going to go through each product and parse out the arrays in variants and options and images
For($u=0 ; $u -le ($products.products.Count-1) ; $u++){

$mainobject = $products.products[$u]
$subvar = $products.products[$u].variants 
$mainobject | Select-Object @{l="product_id";e={$_.id}} ,@{l="variant_id";e={$subvar[$i].id}},  price , inventory_quantity

For($i=0;$i -le ($products.products.variants.Count-1) ; $i ++){
 
if($products.products[$u].id -eq $subvar[$i].product_id){


$subvar[$i] 



}
else
{

}



}

}












