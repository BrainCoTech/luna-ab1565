import pandas as pd

# 加载excel文件。假设 'Filename' 和 'Data' 是列的名字
df = pd.read_excel('luna_vp_table.xlsx')

# 遍历DataFrame的每一行
for index, row in df.iterrows():
    # 获取文件名和数据
    filename = row['Filename']
    filename = filename + '.txt'
    data = row['Data']

    # 创建并写入文件（如果文件已经存在，它将被覆盖）
    with open(filename, 'w') as file:
        file.write(str(data))
