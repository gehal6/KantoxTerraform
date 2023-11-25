import json
import boto3
from pprint import pprint
import os


s3_client = boto3.client("s3")
s3_enrypted_bucket = os.environ["S3_ENCRYPTED_BUCKET"]
s3_prefix = ""
s3_file_key = "jedi.json"
def handler(event, context):
    flag1=False
    flag2=False
    data_response_dict = serialize_event_data(event)
    print(data_response_dict)
    #data_response_dict = json.loads(data_response)
# get the data from the created file    
    try:
        file_content_s3_caller = s3_client.get_object(Bucket=data_response_dict["bucket_name"], Key=data_response_dict["object_key"])["Body"].read()
        file_content_s3_caller_dict = json.loads(file_content_s3_caller)
        print("content of the encrypted file:")
        print(file_content_s3_caller)
        print(type(file_content_s3_caller))
        flag1=True
    except Exception as e:
        print("Error: {}".format(e))
# get the data from our s3 DB     
    try:
        file_content = s3_client.get_object(Bucket=s3_enrypted_bucket, Key=s3_file_key)["Body"].read()
        file_content_dict = json.loads(file_content)
        print("content of the encrypted file:")
        print(file_content)
        print(type(file_content))
        flag2=True
    except Exception as e:
        print("Error: {}".format(e))
    if flag1 and flag2:
        res={**file_content_dict,**file_content_s3_caller_dict}
    elif flag1:
        res=file_content_s3_caller_dict
    elif flag2:
        res=file_content_dict
    else:
        res={}
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




def serialize_event_data(json_data):
    """
    Extract data from s3 event
    Args:
        json_data ([type]): Event JSON Data
    """
    bucket = json_data["Records"][0]["s3"]["bucket"]["name"]
    s3_key = json_data["Records"][0]["s3"]["object"]["key"]
    event_type = json_data["Records"][0]["eventName"]
 
    
    return_json_data = {
        "bucket_name": bucket,
        "object_key": s3_key,
        "event_type": event_type
    }

    return return_json_data
