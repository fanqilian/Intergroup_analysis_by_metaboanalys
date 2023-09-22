library(MetaboAnalystR)
library(pls)
library(pheatmap)
library(data.table)
args = commandArgs(T)

## 设置参数
name = args[[2]]
dir = args[[1]]
setwd(dir)
     

## 数据导入, 过滤, 归一化
mSet<-InitDataObjects("pktable", "stat", FALSE)
mSet<-Read.TextData(mSet, name, "colu", "disc")
mSet<-SanityCheckData(mSet)
mSet<-ReplaceMin(mSet);
mSet<-SanityCheckData(mSet)
#mSet<-FilterVariable(mSet, "none", -1, "F", 25, F)
mSet<-PreparePrenormData(mSet)
mSet<-Normalization(mSet, "SumNorm", "NULL", "ParetoNorm", ratio=FALSE, ratioNum=20)
mSet<-PlotNormSummary(mSet, "norm_0_", "png", 72, width=NA)
mSet<-PlotSampleNormSummary(mSet, "snorm_0_", "png", 72, width=NA)

#Dendrogram
mSet<-PlotHCTree(mSet, "tree_0_", "png", 72, width=NA, "euclidean", "ward.D") 

## Foldchange
mSet<-FC.Anal(mSet, 1.5, 0, FALSE)
mSet<-PlotFC(mSet, "fc_0_", "png", 72, width=NA)

## t_test
mSet<-Ttests.Anal(mSet, F, 0.05, FALSE, TRUE, "fdr", FALSE)
mSet<-PlotTT(mSet, "tt_0_", "png", 72, width=NA)

##volcano_plot
mSet<-Volcano.Anal(mSet, FALSE, 1.5, 0, F, 0.05, TRUE, "raw")
mSet<-PlotVolcano(mSet, "volcano_0_",1, 0, "png", 72, width=NA)

#PCA
mSet<-PCA.Anal(mSet)
mSet<-PlotPCAPairSummary(mSet, "pca_pair_0_", "png", 72, width=NA, 5)
mSet<-PlotPCAScree(mSet, "pca_scree_0_", "png", 72, width=NA, 5)
mSet<-PlotPCA2DScore(mSet, "pca_score2d_0_", "png", 72, width=NA, 1,2,0.95,1,0)
mSet<-PlotPCALoading(mSet, "pca_loading_0_", "png", 72, width=NA, 1,2);
mSet<-PlotPCABiplot(mSet, "pca_biplot_0_", "png", 72, width=NA, 1,2)
mSet<-PlotPCA3DLoading(mSet, "pca_loading3d_0_", "json", 1,2,3)

#OPLS-DA
mSet<-OPLSR.Anal(mSet, reg=TRUE)
mSet<-PlotOPLS2DScore(mSet, "opls_score2d_0_", "png", 72, width=NA, 1,2,0.95,0,0)
mSet<-PlotOPLS.Splot(mSet, "opls_splot_0_", "all", "png", 72, width=NA);
mSet<-PlotOPLS.Imp(mSet, "opls_imp_0_", "png", 72, width=NA, "vip", "tscore", 15,FALSE)
mSet<-PlotOPLS.MDL(mSet, "opls_mdl_0_", "png", 72, width=NA)
mSet<-OPLSDA.Permut(mSet, 100)
mSet<-PlotOPLS.Permutation(mSet, "opls_perm_1_", "png", 72, width=NA)

#Dendrogram
mSet<-PlotHCTree(mSet, "tree_0_", "png", 72, width=NA, "euclidean", "ward.D")

#Heatmap

mSet<-PlotHeatMap(mSet, "heatmap_0_", "png", 72, width=NA, "norm", "row", "euclidean", "ward.D","bwm", 8, "overview", T, T, NULL, T, F, T, T, T)

mSet<-SaveTransformedData(mSet)