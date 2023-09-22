# Intergroup_analysis_by_metaboanalys
Locally invoking MetaboAnalyst for differential analysis

Statistical Analysis (One Factor)
1. Data Submission:
Data type: peak intensities
Format: sample in columns (unpaired)
File: upload files for each comparison group
2. Filter:
Select 0% percentage to filter out
Click submit
3. Normalization:
Normalize: Normalization by sum
Scale: Pareto scaling
Click normalize
4. Analysis:
QC+A+B+C: PCA(2D scores plot: display sample names)
A+B+C: Correlations(choose a dimension: Samples), PCA(2D scores plot: display sample names), Dendrogram
A_vs_B: Fold change(FC: 1.5), T-test, Volcano plot(FC: 1.5, PC: 0.05), PCA(2D scores plot: display sample names), OPLS-DA(Permutation: 100), Dendrogram, Heatmap
5. Finish:
Click logout
Notes:
Individual groups cannot analyze QC: Correlations. Therefore, use code to draw QC correlation plots.

