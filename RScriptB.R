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

#PCA
mSet<-PCA.Anal(mSet)
mSet<-PlotPCAPairSummary(mSet, "pca_pair_0_", "png", 72, width=NA, 5)
mSet<-PlotPCAScree(mSet, "pca_scree_0_", "png", 72, width=NA, 5)
mSet<-PlotPCA2DScore(mSet, "pca_score2d_0_", "png", 72, width=NA, 1,2,0.95,1,0)
mSet<-PlotPCALoading(mSet, "pca_loading_0_", "png", 72, width=NA, 1,2);
mSet<-PlotPCABiplot(mSet, "pca_biplot_0_", "png", 72, width=NA, 1,2)
mSet<-PlotPCA3DLoading(mSet, "pca_loading3d_0_", "json", 1,2,3)




mSet<-SaveTransformedData(mSet)