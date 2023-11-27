# Overview

This code will create the following objects:
1. S3 DB bucket to be used as a DB for the Jedi's information
2. S3 notification bucket that will have the updates of the new jedis by pushing the information in a JSON file to the bucket.
3. S3 bucket notification that will trigger a lambda function whenever a file is pushed to the S3 notification bucket.
4. lambda function that will check the data in the file uploaded to the S3 notification bucket, add the file information to the S3 DB bucket.
5. KMS module that will create a Customer managed key which will be used in the S3 bucket encryption.
6. terraform backend for storing the terraform state in s3 bucket and acquiring locking over a dynamo DB.
7. lambda python code that will acheive the lambda work.

# Instruction:

1. run terraform init
2. run terraform plan
3. run terraform apply.
4. you will face an error "KMSInvalidStateException" for the creation of the KMS CMK as we don't have the key here in the code.
5. you will need to follow these steps to create it <br />
     a. Go to AWS Console — Key Management Service,you have your key created, but with the status saying Pending Import. <br />
     b. in the tab Key Material we are going to download the Wrapping key and import token. <br />
     c. unzip the downloaded archive, which contains a Readme file, wrappingKey_ file which serves as a public key, and the importToken_ which is needed later for uploading. <br />
     d. generate Key material using OpenSSL, first we need to generate a random private key — this creates a file PlaintextKeyMaterial.bin <br />
        -->  openssl rand -out PlaintextKeyMaterial.bin 32 <br />
     e. run openssl pkeyutl command to generate Material Key, if it didn't work on your server then run it inside docker container <br />
        -->  openssl pkeyutl \ <br />
             -in PlaintextKeyMaterial.bin \ <br />
             -out EncryptedKeyMaterial.bin \ <br />
             -inkey NAME_OF_THE_WRAPPING_KEY_FILE \ <br />
             -keyform DER \ <br />
             -pubin \ <br />
             -encrypt \ <br />
             -pkeyopt rsa_padding_mode:oaep \ <br />
             -pkeyopt rsa_oaep_md:sha256 <br />
     f. Upload the EncryptedKeyMaterial.bin and the importToken_ to the KMS. <br />
7. run terraform apply again and everything should be fine.
8. you can now upload JSON files to the notification bucket and check the DB bucket being updated.  
   
   

