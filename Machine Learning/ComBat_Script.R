BiocManager::install("sva")

if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install("bladderbatch")

new_data <- read.csv("Combat_Sample_Data.txt", header=TRUE, sep="\t", row.names='Gene')
new_info <- read.csv("Combat_Sample_Info.txt", header=TRUE, sep="\t")
new_batch = new_info$Batch
new_combat_data = ComBat(dat=new_data, batch=new_batch, mod=NULL, par.prior=TRUE, prior.plots = FALSE)
write.csv(new_combat_data, "Post_ComBat_Human_Mouse_Gene_Expression.csv", row.names=TRUE)
