import pandas as pd
import os
import subprocess

# 获取excel表的数据
df = pd.read_excel('luna_vp_table.xlsx')  # 更改为你的Excel表位置

# 处理每一行数据
for index, row in df.iterrows():
    filename = row[0]
    text = row[1]


    # create the command
    command = f'./aspeak text "{text}" -o {filename}.mp3 -c mp3 -q=2 -v zh-CN-XiaoxiaoNeural'

    # execute the command
    subprocess.call(command, shell=True)