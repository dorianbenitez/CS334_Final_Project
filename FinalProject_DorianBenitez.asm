# Dorian Benitez
# CS 3340.003
# April 8, 2018
# Final Project Code


.data

array1: .space	80	# Allows array creation of maximum 20 elements 

array2: .space	80	# Allows array creation of maximum 20 elements

msg1: .asciiz	"Please enter the size of the 1st array: "

msg2: .asciiz	"Enter an element: "

msg3: .asciiz 	"First sorted list: \n"

msg4: .asciiz 	"Please enter the size of the 2nd array: "

msg6: .asciiz 	"Second sorted list: \n" 

endl: .asciiz 	"\n"

space: .asciiz " "

size: .asciiz	"Size of merged array: "

sum: .asciiz	"Sum of merged array elements: "

mean: .asciiz	"Average (mean) of the merged array: "

 
 
.text

addi $t9, $zero, 2	# Register made to keep track between creation of first and second array


main1:			# Initial output for the first array

la $t0, array1		# $t0 holds the array input for the first array

la $a0, msg1		# Prompts the user to enter the size of the first array to be created 
li $v0, 4
syscall


li $v0, 5 		# Saves user input for size of array 
syscall

move $s0, $v0           # Saves the input size of the array into $s0

add $s5, $s0, $zero	# Copies the array size into $s5

move $t1, $v0		# Size of array1 is saved under $t1

beqz $t1, exit1		# If the array size is zero, the program exits


move $t2, $t1 		# $t1, $t2, and $t3 will all hold the value for the size of the first array
move $t3, $t1
	
j loop			# Jumps to the loop for the first array to be further developed




main2: 			# Initial output for the second array 

la $t0, array2 		# t0 holds the array input for the second array

la $a0, msg4		# Prompts user to enter size of the second array to be created 
li $v0, 4
syscall


li $v0, 5 		# Saves user input for size of the array
syscall

move $s1, $v0           # Saves the input size of the array into $s1

add $s6, $s1, $zero	# Copies the array size into $s6


move $t1, $v0		# The size of the second array is saved into $t1

beqz $t1, exit2		# If the size of the second array is set to 0, program jumps to the exit


move $t2, $t1 		# $t1, $t2, and $t3 will all hold the value for the size of second array
move $t3, $t1	

j loop5			# Jumps to the loop for the second array to be further developed, skips "loop" 




loop:			# Loop for first array to be further developed

la $a0, msg2		# outputs message 2, asking for first array elements 
li $v0, 4
syscall 

li $v0, 5		# Reads user input
syscall

add $s3, $s3, $v0   	# Calculates total sum of first array

sw $v0, ($t0)		# The user input is saved into $t0

move $s4, $t0

add $t0, $t0, 4		# Adds the next input element of the array


add $t1, $t1, -1	# count = count - 1

bnez $t1, loop 		# Keeps allowing user input until size of the array is reached, then stops looping



move $t1, $t2 		# Sets $t1 back to orignal size of the array

la $t0, array1 		# makes a copy of the first array into $t0

la $t4, array1		# makes a second copy of the first array into $t4

la $s4, array1

move $t6, $t4 		# $t6 is initiated with the first element of the array

la $a0, endl		# Displays an empty line of space to the user
li $v0, 4
syscall

j sort 			# Jumps to sort loop to skip loop5




loop5:			# Loop for second array to be further developed

la $a0, msg2		# Outputs message 2, asking for first array elements 
li $v0, 4
syscall 

li $v0, 5		# Reads each user input
syscall

add $s3, $s3, $v0   	# Calculates total sum of second array

sw $v0, ($t0)		# The array is saved to $v0

add $t0, $t0, 4		# Adds the next input element of the array
	
add $t1, $t1, -1 	# count = count - 1

bnez $t1, loop5 	# Keeps allowing user input until size of the array is reached, then stops looping


move $t1, $t2 		# Sets $t1 back to orignal size of the array

la $t0, array2 		# Makes a copy of the second array into $t0

la $t4, array2		# makes a second copy of the first array into $t4

move $t6, $t4 		# $t6 is initiated with the first element of the array

la $a0, endl		# Displays an empty line of space to the user
li $v0, 4
syscall



sort:			# Function to sort the given array

add $t2, $t2, -1 	# loops until every element in the array is accounted for

beqz $t2, loop1 	# When the array is completely sorted in descending order, jumps to the loop to reverse it

addi $t0, $t0, 4 	# Set to go through each element within the array

lw $s1, ($t0)		# Each element is loaded into $s1

lw $s0, ($t6)		# The first element of the array is stored into $s0

blt $s1, $s0, sort 	# Compares $t6 to each other element in the array

move $t6, $t0 		# If the other element is larger than $t6, $t6 is stored with the greater value

bnez $t2, sort 		# Continues to re-iterate the loop until every element is tested and the array is sorted




loop1:

add $t1, $t1, -1 	# Keeps track of the number of loops being made

move $t2, $t1		# Copies value of $t1 into $t2

beqz $t2, done		# When the max number of loops are made, jumps to the "done" function to finish up



lw $t7, ($t4)		# Loads the descending order sorted array into $t7 

lw $t8, ($t6)		# Loads the largest element in the array into $t8

sw $t7, ($t6)		# Moves the largest element in the array to be the first element in the array

sw $t8, ($t4)		



add $t4, $t4, 4 	# Moves on to the next element in the array

move $t0, $t4		# Stores next read element into $t0

move $t6, $t4 		# The last element viewed is now set as the maximum element in the array

bnez $t2, sort		# The loop re-iterates until every element in the array has been accounted for




done:

beq $t9, 1, done2	# If the function is meant for the second array, jumps to second "done" method instead

la $a0, msg3		# Prompts the user that the first array is sorted and is about to be displayed
li $v0, 4
syscall

move $t7, $t4 		# Last index of the sorted array is copied into $t7

beqz $t3, exit1




done2: 
bne $t9, 1, print	# If the function is meant for the first array, jumps to "print" method instead

la $a0, msg6		# Prompts the user that the second array is sorted and is about to be displayed
li $v0, 4
syscall

move $t7, $t4 		# Last index of the sorted array is copied into $t7

beqz $t3, exit1

j print			# jumps to the print method 



sizeloop:		# Method to find the size of both arrays when merged

add $s7, $s5, $s6	# Finds size of both arrays merged

la $a0, size		# Displays prompt for merged size to be displayed
li $v0, 4
syscall

move $a0, $s7		# Displays the size of both arrays merged
li $v0, 1
syscall

mtc1 $s7, $f2		# Converts the merged array size to a float value 
cvt.s.w $f2, $f2	# Converts word float value to a single-precision float value

la $a0, endl		# Prints out a blank space 
li $v0, 4
syscall

jal total		# Jumps and links to next loop 



total:			# Method to find the total sum of each element from both given arrays

la $a0, sum		# Prompts the user that the sum of both arrays is about to be displayed 
li $v0, 4
syscall

li $v0,1        	# Prints the total sum of both arrays merged
move $a0, $s3
syscall

la $a0, endl		# Prints a blank space 
li $v0, 4
syscall

mtc1 $s3, $f3		# Converts the total sum value to a floating point register
cvt.s.w $f3, $f3	# Converts sum floating point register to a single precision float register

jal average		# Jumps and links to 'average' method



average:

div.s $f0, $f3, $f2	# Divides the sum of both arrays merged by the total number of elements in both arrays
	
la $a0, mean		# Prompts the user that the average is about to be displayed
li $v0, 4
syscall

li $v0, 2		# Displays the average (mean) value acquired 
mov.s $f12, $f0   	# Move contents of register $f0 to register $f12
syscall


j final			# jumps to 'final' function



print: 			# Function to print the desired array in reverse order, since it is currently in descending order

lw $a0, ($t4)		# The last index of the array is loaded into $a0

add $t4, $t4, -4	# Moves to read the previous element in the array 

li $v0, 1		# Displays each element of the array in reverse order 
syscall

la $a0, space		# Displays a space to the user between each array element 
li $v0, 4
syscall

add $t3, $t3, -1 	# Count set to monitor the numebr of elements being printed 

bnez $t3, print

la $a0, endl		# Displays an empty line of space to the user
li $v0, 4
syscall

la $a0, endl		# Displays an empty line of space to the user
li $v0, 4
syscall


exit1:
subi $t9, $t9, 1	# After first array is complete and made, subtracts 1 from $t9 
beqz $t9, exit2		# After second array is complete and made, jumps to next exit method
j main2			# If the first array is complete, but not the second, jumps to main2 method to create second array


exit2: 
j sizeloop		# After second array is complete, jumps to "sizeloop"


final:
li      $v0,10          # Exits the program 
syscall
