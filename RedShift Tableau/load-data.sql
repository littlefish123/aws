COPY dim_airports
FROM 's3://aws-tc-largeobjects/spl-114/data/airports'
IAM_ROLE 'resdhift_role_arn'
REGION 'us-west-2'
GZIP;

COPY dim_carriers
FROM 's3://aws-tc-largeobjects/spl-114/data/carriers'
IAM_ROLE 'resdhift_role_arn'
REGION 'us-west-2'
GZIP;

COPY fact_flights
FROM 's3://aws-tc-largeobjects/spl-114/data/flights'
IAM_ROLE 'resdhift_role_arn'
REGION 'us-west-2'
GZIP;