# README

SmartLock API endpoint

Request Path:
POST '/upload'

Request Configuration:
  Headers: Pass the server codename and access_token (provided during initialization) 
  For example:
  Codename: key = X-Server-CodeName value = {Your server codename}
  AccessToken: key = X-Server-AccessToken value = {Your server access_token}

Body: Pass the csv file containing the report under "data" as the key name.
  For example: 
  key = data value = {the csv file you wish to upload}

Once you send the HTTP request, our app will translate and store the data on our database for you to access at anytime. 

