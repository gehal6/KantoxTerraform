import json
import boto3
from pprint import pprint
import os


s3_client = boto3.client("s3")
s3_encrypted_bucket = os.environ["S3_ENCRYPTED_BUCKET"]
s3_prefix = ""
s3_file_key = "jedi.json"
flag=False
def handler(event, context):
    try:
        file_content = s3_client.get_object(Bucket=s3_encrypted_bucket, Key=s3_file_key)["Body"].read()
        file_content_dict = json.loads(file_content)
        print("content of the encrypted file:")
        print(file_content)
        print(type(file_content))
        flag=True
    except Exception as e:
        print("Error: {}".format(e))
    if flag:
        res={**file_content_dict,**event}
    else:
        res=event
    res_json = json.dumps(res)
    try:
         s3_client.put_object(Body=res_json,Bucket=s3_enrypted_bucket,Key=s3_file_key)
    except Exception as e:
        print("Error: {}".format(e))     
   # print(type(event))
    
    #print(data3)
    #data = json.loads(event['body'])
    return {
        'statusCode': 200,
        'body': res_json
    }
