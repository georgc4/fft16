import math
 
# This function receives an integer n , and prints
# all the nth roots of unity
def printRoots(n):
 
    # theta = 2*pi/n
    theta = math.pi * 2 / n
    
    # print all nth roots with 6 significant digits
    for k in range(0, n>>1):
 
        # calculate the real and imaginary part of root
        real = math.cos(k * theta)
        img = -math.sin(k * theta)
 
        # Print real and imaginary parts
        print(real, end=" ")
        if(img >= 0):
            print(" + i ", end=" ")
        else:
            print(" - i ", end=" ")
        print(abs(img))
 
 
# Driver function to check the program
if __name__=='__main__':
    #printRoots(1)
    printRoots(16)
    #printRoots(3)
    