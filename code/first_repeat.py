from collections import Counter

with open("lfsr.out","r") as f:
	a = f.readlines()

dict = Counter(a)

for key in a:
	if dict[key]>1:
		print(key)
		exit(1)