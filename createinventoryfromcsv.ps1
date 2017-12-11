#Create Inventory from CSV
#Written By: Sean Ryan
#Description: Takes a CSV file from a given location $list and interates through the list uploading items to shopify storefront
#it will then output a csv file with the information from the input file and append a new field with the shopify ID 


#build auth headers for shop
$uri = "https://dlcplus.myshopify.com/admin/products.json"
$apikey = "73570d7b028bd149b66f4b29b356b4d9"
$password = "d7237220f5541176bf4dfadb4b786f19"
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
$newlist = $list | Select-Object -Property *, @{label = 'ID';expression={$newproduct.product.id}} | Export-Csv "C:\Users\Sean\Desktop\finished.csv" -NoTypeInformation -Append
}
 

