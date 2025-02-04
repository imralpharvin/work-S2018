setwd("C:/Users/RalphArvin/Desktop/work-s2018/mammalsb/rscripts")


#install.packages("ape")
#install.packages("phangorn")
#install.packages("seqinr")
#source("https://bioconductor.org/biocLite.R")
#biocLite("Biostrings")

library(ape)
library(phangorn)
library(seqinr)
library(Biostrings)

#Converting data table to DNAStringSet object
mammalDSA <- DNAStringSet(dfCentroidSeqsNO$nucleotides)

#Write dna file for dna string set
write.dna(mammalDSA, "mammals.DNA")

#Read  dna file
mammals <- read.dna("mammals.dna", format="interleaved")

#DNA to phyDAT format
mammals_phyDat <- phyDat(mammals, type = "DNA", levels = NULL)

#Compute pairwise distance
dm <- dist.ml(mammals_phyDat, model="JC69")

#NJ tree estimation
mammals_NJ  <- NJ(dm)

#Plot NJ tree
plot(mammals_NJ, main = "Neighbor Joining")

#Write Tree
write.tree(mammals_NJ, file="bootstrap_example.tree")

