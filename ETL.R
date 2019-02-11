environment<-"AWS"
#environment<-"UChicago"
#environment<-"localhost"

# Relevant tutorials
### https://r-bio.github.io/intro-git-rstudio/
### https://aws.amazon.com/blogs/machine-learning/using-r-with-amazon-sagemaker/
### (not using) https://aws.amazon.com/blogs/machine-learning/use-the-built-in-amazon-sagemaker-random-cut-forest-algorithm-for-anomaly-detection/
### https://us-west-2.console.aws.amazon.com/cloudformation/home?region=us-west-2#/stack/detail?stackId=arn:aws:cloudformation:us-west-2:823476387611:stack%2Frstudio-sagemaker%2F9cc0a5f0-2cb3-11e9-b398-0a578203aa12


if(environment=="AWS") {
  # Prepare environment using guidance from https://aws.amazon.com/blogs/machine-learning/using-r-with-amazon-sagemaker/
  
  ### Let’s create an Amazon Simple Storage Service (Amazon S3) bucket for your data. You will need the IAM role that allows Amazon SageMaker to access the bucket.
  
  ### Specify the Amazon S3 bucket to store the training data, the model’s binary file, and output from the training job:
    
  library(reticulate)
  sagemaker <- import('sagemaker')
  session <- sagemaker$Session()
  bucket <- session$default_bucket()
  
  ### Note – The default_bucket function creates a unique Amazon S3 bucket with the following name: sagemaker-<aws-region-name>-<aws account number>.
  
  ### Specify the IAM role’s ARN to allow Amazon SageMaker to access the Amazon S3 bucket:
  
  role_arn <- session$expand_role('sagemaker-service-role')
  
  ### The AWS CloudFormation stack automatically created an IAM role called sagemaker-service-role with the required policies. The expand_role function retrieves the ARN for this role because Amazon SageMaker requires it.
}


# ETL

### data URL example https://s3.amazonaws.com/nyc-tlc/trip+data/yellow_tripdata_2009-01.csv

library(readr)

ncsv<-0
for(y in 2009:2016) {
  for(m in 1:12) {
    if(y<2016 | m <= 6) {
      yyyy<-as.character(y)
      mm<-sprintf("%02d",m)0
      print(paste0("starting ncsv=",ncsv,",yyyy=",yyyy,",mm=",mm))
      csv[nfile]<-read_csv(file=paste0("https://s3.amazonaws.com/nyc-tlc/trip+data/yellow_tripdata_",yyyy,"-",mm,".csv"))
      print(paste0("finished ncsv=",ncsv,",yyyy=",yyyy,",mm=",mm))
      ncsv<-ncsv+1
    }
  }
}






