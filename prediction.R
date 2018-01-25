



prediction_hg19 <- function(up,down){
  
  setwd("/var/shiny-server/www/xiaofei/Alu_app")
  up2 <-  unlist(strsplit(gsub(" ", "", up, fixed = TRUE),"\n|:|-"))
  up2 <-  as.data.frame(matrix(up2, ncol =3, byrow = T))
  up2[,2]<- as.numeric(as.character(up2[,2]))-1
  up2[,4] <- 1:nrow(up2)
  down2 <- unlist(strsplit(gsub(" ", "", down, fixed = TRUE),"\n|:|-"))
  down2 <-  as.data.frame(matrix(down2, ncol =3, byrow = T))
  down2[,2]<- as.numeric(as.character(down2[,2]))-1
  down2[,4] <- 1:nrow(down2)
  write.table(up2, "data/test_up", col.names = F,row.names = F, quote = F, sep = "\t")
  write.table(down2, "data/test_down", col.names = F,row.names = F, quote = F, sep = "\t")
  
  command <- c("intersectBed -wa -wb -a data/predictedTRUE_up -b data/test_up|cut -f4,8 > data/PredictedAlupair")
  try(system(command))
  
  command <- c("intersectBed -wa -wb -a data/predictedTRUE_down -b data/test_down|cut -f4,8 >> data/PredictedAlupair")
  try(system(command))
  
  command <- c("cat data/PredictedAlupair|sort |uniq -c|grep  '^ *2 ' >data/PredictInPair")
  try(system(command))
  
  if(file.info("data/PredictInPair")$size>0){
  pre_rslt <- read.table("data/PredictInPair", sep = "\t",header = F)
  
  pre_rslt[,1] <- gsub(".*\\s","",pre_rslt[,1])
  write.table(pre_rslt,"data/temp", quote = F,col.names = F,row.names = F,sep = "\t")
  
  command <- c("sort -n -k1 data/temp >data/temp6 ")
  try(system(command))
  command <- c("awk 'NR==FNR {h[$1]; next} $4 in h' data/temp data/predictedTRUE_up |sort -n -k4>data/temp2")
  try(system(command))
  
  command <- c("awk 'NR==FNR {h[$1]; next} $4 in h' data/temp data/predictedTRUE_down |sort -n -k4>data/temp3")
  try(system(command))
  
  command <- c("join -1 1 -2 4 -a 1 data/temp6 data/temp2 >data/temp4")
  try(system(command))
  
  command <- c('join -1 1 -2 4 -a 1 data/temp4 data/temp3 >data/temp5')
  try(system(command))
  
  df <- read.table("data/temp5", header=F, sep = " " )
  df2 <- data.frame(matrix(NA, nrow = nrow(df), ncol = 2))
  df2[,1]<- as.data.frame(df[,2])
  df2[,2] <- as.data.frame(paste(df[,3],":",df[,4]+1,"-",df[,5], " | ", df[,6],":",df[,7]+1,"-",df[,8],sep=""))
 
  colnames(df2) <- c("No.","Predicted_Alu_pair")
  df3 <- data.frame(up2[,4],as.data.frame(paste(up2[,1],":",up2[,2]+1,"-",up2[,3], sep="")),
                    as.data.frame(paste(down2[,1],":",down2[,2]+1,"-",down2[,3], sep="")) )
  colnames(df3) <-c("No.","5'_Genomic_Interval","3'_Genomic_Interval")
  df4 <- merge(df3,df2, all = T)
  
  
  command <- c("rm data/temp* data/test* data/Predict*")
  try(system(command))
  
  return(df4)
  }else{
          df3 <- data.frame(up2[,4],as.data.frame(paste(up2[,1],":",up2[,2]+1,"-",up2[,3], sep="")),
                            as.data.frame(paste(down2[,1],":",down2[,2]+1,"-",down2[,3], sep="")), NA )
          colnames(df3) <-c("No.","5'_Genomic_Interval","3'_Genomic_Interval", "Predicted_Alu_pair")
          command <- c("rm data/test* data/Predict*")
          
          try(system(command))
          return(df3)
  }
  
  
  
}





