from os import listdir

from sklearn.feature_extraction.text import TfidfVectorizer
#https://machinelearningmastery.com/how-to-fix-futurewarning-messages-in-scikit-learn/
#this filter is needed as the FutureWarning will spam output otherwise
from warnings import simplefilter
# ignore all future warnings
simplefilter(action='ignore', category=FutureWarning)

from yellowbrick.text import tsne

path = "C:\\Users\\julian.lemmerich\\OneDrive\\User Data\\Uni\\Semester 8\\Thesis\\Corpora\\combined - named\\corpus"
filelist = listdir(path)
docs = []
for f in filelist:
    file = open(path + "\\" + f, encoding='utf-8')
    docs.append(file.read())

x = TfidfVectorizer().fit_transform(docs, y=None)
#encoding is utf-8 by default

print("jetzt kommt x:")
print(x)

classlist = []
for f in filelist:
    classlist.append(f[0])

tsne(x, y=classlist, colors=["blue", "red"])