import json
import boto3
from pprint import pprint
import os


s3_client = boto3.client("s3")
s3_enrypted_bucket = os.environ["S3_ENCRYPTED_BUCKET"]
s3_prefix = ""
s3_file_key = "test.txt"
flag=false
def handler(event, context):
    try:
        file_content = s3_client.get_object(Bucket=s3_enrypted_bucket, Key=s3_file_key)["Body"].read()
        print("content of the encrypted file:")
        print(file_content)
        print(type(file_content)
        flag=true
    except Exception as e:
        print("Error: {}".format(e))
    if flag:
        res={**file_content,**event}
    else:
        res=event
   # print(type(event))
    
    #print(data3)
    #data = json.loads(event['body'])
    return {
        'statusCode': 200,
        'body': json.dumps(res)
    }


    body = json.loads(event['body'])
    return {
        'statusCode': 200,
        'body': json.dumps(body['data'])
    }

