library(foreach)

setwd("ToxChallenge_RNASeq")
rna_counts <- read.table("ToxChallenge_RNASeq_counts.txt", header = TRUE, row.names = 1)
rna_counts_norm <- read.table("ToxChallenge_RNASeq_counts_norm.txt", header = TRUE, row.names = 1)
rna_annot <- read.table("ToxChallenge_RNASeq_annotations.txt", header = TRUE, row.names = 1)

save.image("rna.RData")

setwd("../ToxChallenge_genotype_dosage")
chrs <- list.files(pattern = "ToxChallenge_genotype_dosage")
ind <- foreach(i=1:length(chrs), .combine = c) %do% {
  strsplit(strsplit(chrs[i], split = "_")[[1]][4], split = "\\.")[[1]][1]
}
dosage <- foreach(j = 1:length(chrs), .combine = c) %do% {
  chr <- read.table(chrs[j], header = TRUE, row.names = 1, colClasses = rep("factor", time(884)))
  chr <- na.omit(chr)
  chr
}

save.image("dosage.RData")

rm(i)
rm(j)

setwd("../ToxChallenge_genotype_map")
chrs2 <- list.files(pattern = "ToxChallenge_genotype_map")
ind2 <- foreach(i = 1:length(chrs2), .combine = c) %do% {
  strsplit(strsplit(chrs2[i], split = "_")[[1]][4], split = "\\.")[[1]][1]
}
map <- foreach(j = 1:length(chrs2), .combine = c) %do% {
  chr2 <- read.table(chrs2[j], header = TRUE, row.names = 1, colClasses = rep("factor", time(4)))
  chr2 <- na.omit(chr2)
  chr2
}

save.image("map.RData")

