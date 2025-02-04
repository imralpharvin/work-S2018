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

#create distance matrix
dm<-dist.ml(mammals_phyDat)

#run model test
#mt<-modelTest(mammals_phyDat)

#Create environemnt 
#env<-attr(mt,"env")
#find parameters 
#fit<-eval(get("HKY+G+I",env),env)

mammals_NJ  <- NJ(dm)
fit <- pml(mammals_NJ, mammals_phyDat,k=4,inv=0.2)
fitHKY <- optim.pml(fit, model = "HKY",  rearrangement = "stochastic", optInv=TRUE, optGamma=TRUE)


#Write Tree
write.tree(fitHKY$tree, file="bootstrap_example.tree")

