DataStream Python Producer and Consumer
=======================================
1. pip install boto3
2. create user profile to aws cli
aws configure --profile littlefish123

setx AWS_PROFILE littlefish123 
check user environment variable set correctly : echo %AWS_PROFILE%

3. git clone https://github.com/awslabs/aws-python-sample.git
4. cd aws-python-sample
   python s3_sample.py
   
5. 
aws kinesis create-stream --stream-name ExampleInputStream --shard-count 1 --region us-east-2
aws kinesis create-stream --stream-name ExampleOutputStream --shard-count 1 --region us-east-2   

6. create stock.py and execute "python stock.py"
 
import json
import boto3
import random
import datetime

kinesis = boto3.client('kinesis')
def getReferrer():
    data = {}
    now = datetime.datetime.now()
    str_now = now.isoformat()
    data['EVENT_TIME'] = str_now
    data['TICKER'] = random.choice(['AAPL', 'AMZN', 'MSFT', 'INTC', 'TBV'])
    price = random.random() * 100
    data['PRICE'] = round(price, 2)
    return data

while True:
        data = json.dumps(getReferrer())
        print(data)
        kinesis.put_record(
                StreamName="ExampleInputStream",
                Data=data,
                PartitionKey="partitionkey")


7. git clone https://github.com/aws-samples/amazon-kinesis-data-analytics-java-examples.git

8. Navigate to the GettingStarted directory. The application code is located in the CustomSinkStreamingJob.java and CloudWatchLogSink.java files.
   Compile with Eclipse.
   
9. Create S3 budket ka-app-code-<username>. Upload JAR file created from point 8) to this bucket.

10. Create Kinesis Application "MyApplication". 
https://docs.aws.amazon.com/streams/latest/dev/get-started-exercise.html

11. Create IAM Policy kinesis-analytics-service-MyApplication-us-east-2 and attach to <username>.

12. Configure Kinesis Application - setup logging, Configure properties, S3 locatin, 

13. Run the application and monitor by Application Graph. Check the CloudWatch.



DataStream Java Producer and Consumer
=====================================
1. Create DataStream "stockTradeStream" with shard count=1
2. Create IAM Policy with DataStream, Dynamo and CloudWatch Access Policy
2. Attach IAM Policy to appropriate users
3 . git clone  https://github.com/aws-samples/amazon-kinesis-learning to amazon-kinesis-learning folder
4. Eclipse install "AWS Toolkit" plugin
5. Implement producer and run with parameter "StockTradeStream us-east-2"
6. Implement consumer and run with parameter "StockTradesProcessor StockTradeStream us-east-2"


