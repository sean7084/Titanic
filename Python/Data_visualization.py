import numpy as np
import pandas as pd
from pandas_profiling import ProfileReport

# cmd for pandas_profiling installation
pip install ydata-profiling

df = pd.read_csv('~/Documents/Code/Titanic/train.csv')
df

profile = ProfileReport(df, title = 'pro', html={'style':{'full_width':True}})
profile
profile.to_file("titanic_report.html")