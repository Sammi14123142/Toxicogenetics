load("raw.RData")

library(randomForest)

pred <- list()

y_tr <- as.data.frame(cbind(tox_tr_stat[,1], tox_tr_stat[,3]-tox_tr_stat[,2]))
names(y_tr) <- c("MedianEC10", "Interquartile_Distance")
y_te <- read.table("ToxChallenge_Subchall2_Test_Data.txt", header=TRUE, row.names=1)


# Use cytotoxicity stat -----------------------------------------------------------------

for(i in 1:2){
  result <- rfcv(trainx = sirms_tr, trainy = y_tr[,i], cv.fold=5, scale="log", step=0.9, mtry=function(m) max(1, floor(sqrt(m))), recursive=FALSE)
  imp <- order(importance(randomForest(x=sirms_tr, y = y_tr[,i])), decreasing=TRUE)
  subFeat_tr <- sirms_tr[, imp[1:result$n.var[which.min(result$error.cv)]]]
  subFeat_te <- sirms_te[, names(subFeat_tr)]
  
  rf <- tuneRF(x=subFeat_tr, y=y_tr[,i], stepFactor=2, trace=TRUE, plot=TRUE, doBest=TRUE)
  pred[[i]] <- matrix(predict(rf, subFeat_te), ncol=1, dimnames=list(rownames(subFeat_te), names(y_tr[,i])))
}

prediction <- list()
prediction <- do.call("cbind", pred)

write.table(prediction, "chemTox_rf.txt",quote = FALSE,sep = "\t",row.names=TRUE,col.names=TRUE) 

