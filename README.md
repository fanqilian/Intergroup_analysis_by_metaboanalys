# Intergroup_analysis_by_metaboanalyst
Locally invoking MetaboAnalyst for differential analysis in statistical Analysis (One Factor)

1. Data Submission:
Data type: peak intensities
Format: sample in columns (unpaired)
File: upload files for each comparison group

2. Filter:
Select 0% percentage to filter out

3. Normalization:
Normalize: Normalization by sum
Scale: Pareto scaling

4. Analysis of each combination group:

QC_vs_A_vs_B_vs_C: PCA(2D scores plot: display sample names)

A_vs_B_vsC: Correlations(choose a dimension: Samples), PCA(2D scores plot: display sample names), Dendrogram

A_vs_B: Fold change(FC: 1.5), T-test, Volcano plot(FC: 1.5, PC: 0.05), PCA(2D scores plot: display sample names), OPLS-DA(Permutation: 100), Dendrogram, Heatmap

metaboanalyst.sh is designed to run the metabotlas Main.py Python script.
It requires two command line arguments: 
1）the full path to the working directory (which contains the quantitative table) 
2）and the full path to the grouping table
