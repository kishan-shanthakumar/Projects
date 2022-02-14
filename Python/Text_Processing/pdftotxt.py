from os import listdir, getcwd
from os.path import isfile, join
from tika import parser
import numpy as np

cwd=getcwd()
onlyfiles = [f for f in listdir('./pdf') if isfile(join('./pdf', f))]
onlyfiles=sorted(onlyfiles)

def tp(i):
	text=""
	raw = parser.from_file(cwd+'/pdf/'+i)
	raw=str(raw)
	safe_text = raw.encode('utf-8', errors='ignore')
	safe_text = str(safe_text).replace("\n", "").replace("\\", "")
	text+=safe_text
	return(text)

fun=np.vectorize(tp)
slf=fun(onlyfiles)
f=open("text.txt",'w')
for i in slf:
	f.write(str(i))
f.close()
