$uri = "https://dlcplus.myshopify.com/admin/products.json"
$apikey = ""
$password = "d"
$headers = @{"Authorization"  = "Basic " + [System.Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($apikey+":"+$password))}
$products = Invoke-RestMethod -Uri $uri -contentType 'application/json' -Method Get -Headers $headers
$count = $products.products.Count 
#$products.products | ForEach-Object -Process {if ($_.title.Contains("Player")) {echo 'Title:'$_.title ; echo 'Description'$_.body_html; }}
$products.products | Format-Table -Wrap -AutoSize -Property title ,@{Name="Inventory"; Expression={$_.variants.inventory_quantity}}  , body_html 
