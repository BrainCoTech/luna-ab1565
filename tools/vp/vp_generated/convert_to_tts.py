import pandas as pd
import pyttsx3
from pydub import AudioSegment

# 获取excel表的数据
df = pd.read_excel('luna_vp_table.xlsx')  # 更改为你的Excel表位置

# 因为aspeak在Windows上有些问题，我们使用pyttsx3来替代它
engine = pyttsx3.init()

# 处理每一行数据
for index, row in df.iterrows():
    filename = row[0]
    text = row[1]
    
    # 使用pyttsx3把字符转为wav文件
    engine.save_to_file(text, filename + ".wav")
    engine.runAndWait()

    # 把wav文件转为mp3文件
    sound = AudioSegment.from_wav(filename + ".wav")
    sound = sound.set_channels(1)
    sound = sound.set_frame_rate(48000)
    sound.export(filename + ".mp3", format="mp3")
