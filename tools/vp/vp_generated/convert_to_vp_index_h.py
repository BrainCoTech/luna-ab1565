import pandas as pd
import os

# delete file if exists
if os.path.exists("vp_index.h"):
    os.remove("vp_index.h")

# read the excel file
df = pd.read_excel('luna_vp_table.xlsx')

# open the file in append mode
file = open("vp_index.h", "a")

# iterate through the first column
for index, row in df.iterrows():
    index_name = 'VP_INDEX_' + str(row[0]) + ",\n"
    file.write(index_name)

# close the file
file.close()
