#inventory levels
#created by: Sean Ryan
#query the shopify storefront for all inventory and post all items below 99 available inventory.


$uri = "https://dlcplus.myshopify.com/admin/products.json"
$apikey = ""
$password = ""
$headers = @{"Authorization"  = "Basic " + [System.Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($apikey+":"+$password))}
$products = Invoke-RestMethod -Uri $uri -contentType 'application/json' -Method Get -Headers $headers
$count = $products.products.Count 
$products.products | ForEach-Object -Process {if ($_.variants.inventory_quantity -lt 99) {  $_.title , $_.variants.inventory_quantity | Format-Table } } 
