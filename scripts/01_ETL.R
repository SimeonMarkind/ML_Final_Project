sink(file=paste0("~/ML_Final_Project/logs/01_ETL",format(Sys.time(),"%Y_%m_%d_%H_%M_%S"),".log"))

#environment<-"AWS"
environment<-"UChicago"
#environment<-"localhost"
environment

# Relevant tutorials
### AWS: https://aws.amazon.com/blogs/machine-learning/using-r-with-amazon-sagemaker/



# ETL

### data URL example https://s3.amazonaws.com/nyc-tlc/trip+data/yellow_tripdata_2009-01.csv

library(readr)

ncsv<-0
csv<-list()
for(y in 2009:2016) {
  for(m in 1:12) {
    if(y<2016 | m <= 6) {
      ncsv<-ncsv+1
      if(ncsv != 14) {
        yyyy<-sprintf("%04d",y)
        mm<-sprintf("%02d",m)
        print(paste0("starting ncsv=",ncsv,",yyyy=",yyyy,",mm=",mm))
        csv[[ncsv]]<-read_csv(file=paste0("https://s3.amazonaws.com/nyc-tlc/trip+data/yellow_tripdata_",yyyy,"-",mm,".csv"))
        print(paste0("finished ncsv=",ncsv,",yyyy=",yyyy,",mm=",mm))
      }
      else {
        print(paste0("skipping ncsv=",ncsv,",yyyy=",yyyy,",mm=",mm))
      }
    }
  }
}
ncsvs<-ncsv

print(paste0("successfully read in ",ncsvs," csv files"))

sink()

