#Create Inventory from CSV
#Written By: Sean Ryan
#Description: Takes a CSV file from a given location $list and interates through the list uploading items to shopify storefront


#build auth headers for shop
$uri = "https://dlcplus.myshopify.com/admin/products.json"
$apikey = ""
$password = ""
$headers = @{"Authorization"  = "Basic " + [System.Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($apikey+":"+$password))}

#set the location for the csv file
$list = import-csv "C:\Users\Sean\Desktop\test.csv"

#loop through each item in list and parse together JSON and upload to site.
ForEach($list in $list){
$title = $list.title
$body_html=$list.body_html
$price = $list.price 
$inventory=$list.inventory
$image = $list.image 
$imageconvert = [Convert]::ToBase64String([IO.File]::ReadAllBytes($image))
$hash = [ordered]@{product = [ordered]@{title = $title ; body_html = $body_html; images =@(@{attachment=$imageconvert}); variants =@(@{inventory_management = 'shopify' ; inventory_quantity = $inventory ; price = $price })}} | ConvertTo-Json -Depth 3
$newproduct = Invoke-RestMethod -Uri $uri -ContentType 'application/json'  -Method Post -Headers $headers -Body $hash
echo $newproduct.product | Format-Table -Property title , id 
}