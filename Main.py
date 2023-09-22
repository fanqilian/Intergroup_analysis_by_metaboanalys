import sys
def generate_csv_and_run_r_script(workplace, group_path):
    import pandas as pd
    import subprocess
    import os
    from itertools import combinations

    # Read files
    df = pd.read_excel(workplace + '/POS_v6_Clean.xlsx')
    group_df = pd.read_csv(group_path, sep='\t')

    # Get all combinations
    groups = group_df['Group'].unique()
    all_combinations = list(combinations(groups, 2))

    # Add an extra combination containing all groups except 'QC'
    specified_groups = [group for group in groups if group != 'QC']
    all_combinations.append(tuple(specified_groups))

    # Add a combination containing all groups
    all_combinations.append(tuple(groups))

    for specified_groups in all_combinations:

        # Create new output folder for each combination
        folder_name = 'vs_'.join(specified_groups)
        output_folder = os.path.join(workplace, folder_name)
        os.makedirs(output_folder, exist_ok=True)

        # Extract specified group columns
        specified_columns = group_df[group_df['Group'].isin(specified_groups)]['ID']
        new_df = df[['No.'] + specified_columns.tolist()]

        # Add group info to the second row
        group_info = [''] * len(new_df.columns)
        for col in specified_columns:
            group_info[new_df.columns.get_loc(col)] = group_df[group_df['ID'] == col]['Group'].values[0]

        new_df.loc[-1] = group_info  # adding a row
        new_df.index = new_df.index + 1  # shifting index
        new_df = new_df.sort_index()  # sorting by index

        # Write to new file
        output_filename = os.path.join(output_folder, folder_name + '.csv')
        new_df.to_csv(output_filename, index=False)
        
        # Run different R script depending on the combination
        if len(specified_groups) == 2:
            run_cmd = f'/usr/bin/Rscript /home/qilianfan/metabotlas/RScriptA.R {output_folder} {output_filename}'
            subprocess.run(run_cmd, shell=True)
        elif len(specified_groups) > 2 and 'QC' in specified_groups:
            run_cmd = f'/usr/bin/Rscript /home/qilianfan/metabotlas/RScriptB.R {output_folder} {output_filename}'
            subprocess.run(run_cmd, shell=True)
        elif len(specified_groups) == 3 : 
            run_cmd = f'/usr/bin/Rscript /home/qilianfan/metabotlas/RScriptC.R {output_folder} {output_filename}'
            subprocess.run(run_cmd, shell=True)


#workplace = '/home/qilianfan/metabotlas/test/'
#group_path = '/home/qilianfan/metabotlas/Group_info_POS.txt'

workplace = sys.argv[1]
group_path = sys.argv[2]
generate_csv_and_run_r_script(workplace, group_path)

