import os
import boto3
import logging

# define a logger using logging library. If LOG_LEVEL is not set, default to INFO.
# otherwise use value of LOG_LEVEL
logger = logging.getLogger()
logger.setLevel(os.getenv('LOG_LEVEL', 'INFO'))


# define a lambda_handler function that takes in an event and a context
def lambda_handler(event, context):
    logger.info("Hello from Lambda!")

    # create a new boto3 client for the service 's3'
    s3 = boto3.client('s3')
    # generate a list of all the buckets in the account
    response = s3.list_buckets()
    # log the response
    for bucket in response['Buckets']:
        logger.info(f'Bucket: {bucket["Name"]}')
