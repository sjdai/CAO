.text
.globl main

main:
li $v0 4 			     # System call: print hint for user
la $a0, input_msg                        
syscall 
li $v0 5                             # System call: get the user input and save in $v0
syscall 
move $t0, $v0                         # save input number in $t0

# factorial recursive
factorial_recursive:

# factorial non-recursive
move $t1, $t0   		     # $t1 = input_number
addi $t3, $t3, 1    		     # init factor = 1  $t3:result of non-recursive method
factorial_non_recursive:
mul $t3, $t3, $t1		     # n = n*(n-1)
subi $t1, $t1, 1		     # input_number -= 1
bne $t1, 1, factorial_non_recursive  # if (input_number != 1) loop continue 

# tribonacci recursive
tribonacci_recursive:

# tribonacci non-recursive
move $t1, $t0			    # $t1 = input_number
move $t7, $t0    		    # $t7 = imput_numer (loop conunter)
addi $s0, $s0, 0		    # $s0 = 0 (T(i) ; i=0)
addi $s1, $s1, 1		    # $s1 = 1 (T(i) ; i=1)
addi $s2, $s2, 1		    # $s2 = 1 (T(i) ; i=2)
beq $t1, 0, tribo0		    # if (input_number == 0) factor = 0
beq $t1, 1, tribo1		    # if (input_number == 1) factor = 1
beq $t1, 2, tribo1		    # if (input_number == 2) factor = 2
tribonacci_non_recursive:
add $t6, $s0, $s1		    # $T(n) = T(n-1) + T(n-2) + T(n-3) where n>=3
add $t6, $s2, $t6
add $s0, $zero, $s1		    # set T(n-3) = T(n-2)
add $s1, $zero, $s2		    # set T(n-2) = T(n-1)
add $s2, $zero, $t6		    # set T(n-1) = T(n)
beq $t7, 3, cont                    # if (loop_counter == 3) loop end
addi $t7, $t7, -1		    # loop counter -= 1
j tribonacci_non_recursive

tribo0:
addi $t6, $t6, 0
j cont

tribo1:
addi $t6, $t6, 1
j cont

cont:

exit:
li $v0 4
la $a0, new_line		   # syscall : newline
syscall

li $v0 4			   # syscall : print input number
la $a0, input_result
syscall
li $v0 1
move $a0, $t0
syscall
li $v0 4
la $a0, new_line		   # syscall : newline
syscall

li $v0 4
la $a0, factorial_recursive_result # syscall : print factorial_recursive
syscall

move $a0, $t3
li $v0 1			   # syscall : print factorial_recursive result
syscall

li $v0 4
la $a0, new_line		  # syscall : newline
syscall

li $v0 4
la $a0, factorial_non_recursive_result # syscall : print factorial_non_recursive
syscall

move $a0, $t3
li $v0 1			  # syscall : print factorial non-recursive result
syscall

li $v0 4
la $a0, new_line                  # syscall : newline
syscall

li $v0 4
la $a0, tribonacci_recursive_result  # syscall : print tribonacci recursive
syscall

move $a0, $t6
li $v0 1			# syscall : print tribonacci recursive result
syscall

li $v0 4
la $a0, new_line		#syscall : newline
syscall

li $v0 4
la $a0, tribonacci_non_recursive_result  # syscall : print tribonacci non-recursive
syscall

move $a0, $t6
li $v0 1				#syscall : print tribonacci non-recursive result
syscall

li $v0 4
la $a0, new_line
syscall

li $v0, 10                           # System call: exit
syscall

.data 
array:     .space 512
input_msg: .asciiz  "Input a number: "   
input_result:     .asciiz "Your Input Number: "
factorial_non_recursive_result:       .asciiz "factorial (non-recursive) : "
factorial_recursive_result:       .asciiz "factorial (recursive) : "
tribonacci_non_recursive_result:       .asciiz "tribonacci (non-recursive) : "
tribonacci_recursive_result:	.asciiz "tribonacci (recursive) : "
new_line:	.asciiz "\n"