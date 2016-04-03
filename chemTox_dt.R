setwd("~/Desktop/Toxicogenetics")

sirms <- read.table("ToxChallenge_ChemicalAttributes/ToxChallenge_ChemicalAttributes_SiRMS.txt", header = TRUE, row.names = 1)
tox_tr <- read.table("ToxChallenge_training_data/ToxChallenge_CytotoxicityData_Train.txt", header=TRUE, row.names = 1)
tox_tr_stat <- read.table("ToxChallenge_training_data/ToxChallenge_CytotoxicitySummaryStatistics_Train_Subchal2.txt", header = TRUE, row.names = 1)

sirms_tr <- sirms[colnames(tox_tr),]
sirms_te_ind <- setdiff(rownames(sirms), colnames(tox_tr))
sirms_te <- sirms[sirms_te_ind,]

save.image("raw.RData")