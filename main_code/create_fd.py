#!/usr/bin/env python
import numpy as np
import os
import sys
from math import *

def fd_name(R0, S0, T0, P0):
		R0 = float(R0)
		S0 = float(S0)
		T0 = float(T0)
		P0 = float(P0)

		Ri = str(R0).split('.')[0]			# integer part
		Rd = str(R0).split('.')[1]			# decimal part
		Si = str(S0).split('.')[0]			# integer part
		Sd = str(S0).split('.')[1]			# decimal part
		Ti = str(T0).split('.')[0]			# integer part
		Td = str(T0).split('.')[1]			# decimal part
		Pi = str(P0).split('.')[0]			# integer part
		Pd = str(P0).split('.')[1]			# decimal part

		fd_n = "A0_"

		if Rd == "0":
			fd_n = fd_n+"R"+Ri
		else:
			fd_n = fd_n+"R"+Ri+"d"+Rd
		if Sd == "0":
			fd_n = fd_n+"S"+Si
		else:
			fd_n = fd_n+"S"+Si+"d"+Sd
		if Td == "0":
			fd_n = fd_n+"T"+Ti
		else:
			fd_n = fd_n+"T"+Ti+"d"+Td
		if Pd == "0":
			fd_n = fd_n+"P"+Pi
		else:
			fd_n = fd_n+"R"+Pi+"d"+Pd

		return fd_n

def copy_fd(R0, S0, T0, P0):
		fd_n = fd_name(R0, S0, T0, P0)
		os.system("mkdir "+fd_n)
		os.system("cp *.c "+fd_n)
		os.system("cp *.h "+fd_n)
		os.system("touch "+fd_n+"/input.dat")

		# create input.dat according to A0 file
		f_input = open(fd_n+"/input.dat","w") 
		f_input.write("0.3 0.7 1 0.5 2 "+str(R0)+" "+ str(S0)+" "+str(T0)+" "+str(P0)+" 3 0 5 1 100 5000 0.05")
		f_input.write("\n")
		f_input.write("#x0 n0 D epsilon theta R0 S0 T0 P0 R1 S1 T1 P1 L Tf dt")
		f_input.close()

		# print input.dat for double check
		os.system("more "+fd_n+"/input.dat")

		f_list = open("fd_list.dat","w+")
		f_list.write(fd_n+"\n")
		f_list.close()



# 1st quadrant
print("1st quadrant")
T0 = 1
P0 = 1
D_SP = 0.5
for D_RT in [0.5, 1, 1.5]:
	R0 = T0 + D_RT
	S0 = P0 + D_SP
	fd_n = fd_name(R0, S0, T0, P0)
	if not os.path.isdir(fd_n):
		print(fd_n)
		copy_fd(R0, S0, T0, P0)

# 2nd quadrant
print("2nd quadrant")
T0 = 1
P0 = 6
D_SP = -0.5
for D_RT in [0.5, 1.5]:
	R0 = T0 + D_RT
	S0 = P0 + D_SP
	fd_n = fd_name(R0, S0, T0, P0)
	if not os.path.isdir(fd_n):
		print(fd_n)
		copy_fd(R0, S0, T0, P0)

# 3rd quadrant
print("3rd quadrant")
T0 = 6
P0 = 6
D_SP = -0.5
D_RT = -1.0
R0 = T0 + D_RT
S0 = P0 + D_SP
fd_n = fd_name(R0, S0, T0, P0)
if not os.path.isdir(fd_n):
	print(fd_n)
	copy_fd(R0, S0, T0, P0)

# 4th quadrant
print("4th quadrant")
T0 = 6
P0 = 1
D_SP = 0.5
for D_RT in [-0.5, -1.5]:
	R0 = T0 + D_RT
	S0 = P0 + D_SP
	fd_n = fd_name(R0, S0, T0, P0)
	if not os.path.isdir(fd_n):
		print(fd_n)
		copy_fd(R0, S0, T0, P0)

