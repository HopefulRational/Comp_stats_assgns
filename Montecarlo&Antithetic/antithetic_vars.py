from numpy.random import uniform
from numpy import array, std
from math import exp , pow, pi

def calc(x):
	res = 0.0
	m = 10000
	u_s = uniform(0,1,m/2)
	for u in u_s:
		res += ( x*exp(-pow(u*x,2)/2) + x*exp(-pow((1-u)*x,2)/2) ) / 2
	res = res/(m/2)
	res = 0.5 + res/pow(2*pi,0.5)
	return res

def std_dev(x,y):
	vals = []
	if y == 0:
		for i in range(1000):
			vals.append(calc(x))
	else:
		for i in range(1000):
			vals.append(1-calc(-x))
	return std(array(vals))

try:
	x = input("Enter x value: ")
	print("Result:")
	if x >= 0:
		print(calc(x))
		print("Standard Deviation:")
		print(std_dev(x,0))
	else:
		print(1-calc(-x))
		print("Standard Deviation:")
		print(std_dev(x,1))
except:
	print("Incorrect input. Aborting...")
