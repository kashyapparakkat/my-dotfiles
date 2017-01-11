import numpy as np
from pandas import DataFrame as df

from pandas_summary import DataFrameSummary
import pandas
pandas.set_option('display.max_columns', 500)
from scipy.stats import trim_mean, kurtosis
from scipy.stats.mstats import mode, gmean, hmean


xl = pandas.ExcelFile("excel.xlsx")
# xl.sheet_names
df = xl.parse("Sheet1")
dfs = DataFrameSummary(df)
print(dfs.columns_stats)
with open('summary.txt','w') as fout:
    fout.write(str(dfs.columns_stats))
print(df.head(n=10))
print("\n\nDESCRIBE")
print(df.describe())


print("\nCOLUMNS")
for name, values in df.iteritems():
    print ('{name}: {value}'.format(name=name, value=values[0]))
    # print (df.col.unique())
    
headers = df.dtypes.index
print(headers)
for i,col in enumerate(headers):
    print("\n\nCOL ANALYSIS : #" + str(i) +" column")
    try:
        print("n= {}".format(len(df[col])))
        print("blanks= {}".format(sum(pandas.isnull(df[col]))))
        print("min: {}".format(df[col].min()))
        print("max: {}".format(df[col].max()))
        print("sum: {}".format(df[col].sum()))
        print("-ves: {}".format(sum(n < 0 for n in  df[col].tolist())))
        print("zeroes: {}".format(sum(n == 0 for n in  df[col].tolist())))
        print("+ves: {}".format(sum(n > 0 for n in  df[col].tolist())))
    except:
        print("error")
    print("uniques: ",)
    uniques=len(df[col].unique())
    print (uniques) 
    n = uniques if uniques<5 else 3
    print(df[col].unique()[:n])

    
# print("\nCROSSTAB")
# print(pandas.crosstab([df[headers[0]], df[headers[1]]], df[headers[2]],  margins=True))