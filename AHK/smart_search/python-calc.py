# print('ad')
import time
import sys
input_text = 'adfadfhelkiad'
input_text = str(sys.argv[2])
mapping = {
'a':'1',
's':'2',
'd':'3',
'f':'4',
'g':'5',
'h':'6',
'j':'7',
'k':'8',
'l':'9',
';':'0',
'e':'*',
'r':'/',
'i':'+',
'o':'-'
# '':'',
}  
 
for i in input_text:
    if i in mapping:
        print(i)
        input_text = str.replace(input_text,i,mapping[i])
        # input_text = input_text.replace(i,mapping[i])

# print(input_text)
# sys.exit(0)
#time.sleep(5)
file = open(r"C:/cbn_gits/AHK/smart_search/" + sys.argv[1],'w')
file.write(str(input_text))
file.close()
