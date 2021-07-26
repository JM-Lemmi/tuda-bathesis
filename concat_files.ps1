# from https://stackoverflow.com/a/43292579/9397749

Get-ChildItem "C:\Users\julian.lemmerich\OneDrive\User Data\Uni\Semester 8\Thesis\Corpora\trump 2-3\corpus\*" -include *.txt | Get-Content -encoding UTF8 | out-file -Encoding UTF8 "C:\Users\julian.lemmerich\OneDrive\User Data\Uni\Semester 8\Thesis\Corpora\trump 2-3\combined.txt"

#output has to be different than input folder, otherwise it will fall into a loop and keep addit itself to the concatenated file.
# Encoding Flags are needed for both Get-Content as well as Out-File!