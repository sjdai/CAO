.text 
.globl main
main:
la $s0, array                        # Load the base address of the array in $s0
move $t0, $s0                        # Create an address pointer ($t0) to the base address of the array
li $t1, 0                            # Initialize an input counter to be 0

loop:
li $v0 4 
la $a0, input_msg                        
syscall 
li $v0 5                             # System call: get the user input and save in $v0
syscall 

sw $v0, 0($t0)                       # Save the input number in the array
addi $t1, $t1, 1                     # Add 1 to the input counter             
addi $t0, $t0, 4                     # Move the address ponter ($t0) to the next word
slti $t2, $t1, 10                     # Set $t2 = 1 if $t1 < 3 else $t2 = 0
beq  $t2, $zero, Exit                # If $t2 == 0 go to Exit else jump to loop
j loop

Exit:                                     
slti $t2, $t1, 1                     # Set $t2 = 1 if $t1 < 1 else $t2 = 0
bne  $t2, $zero, End                 # If $t2 != 0 goto End
addi $t1, $t1, -1                    # $t1 = $t1 - 1
sll  $t4, $t1, 2                     # Calculate the byte offset for accessing values in the array
add  $t0, $s0, $t4                   # Add the byte offset to the base address
lw   $t3, 0($t0)                     # Load the value
addi  $t5, $t3, 0                    # init sum
addi  $t6, $t3, 0                    # init max
addi  $t7, $t3, 0                    # init min
compare_loop:
slti $t2, $t1, 1                     # Set $t2 = 1 if $t1 < 1 else $t2 = 0
bne  $t2, $zero, End                 # If $t2 != 0 goto End
addi $t1, $t1, -1                    # $t1 = $t1 - 1
sll  $t4, $t1, 2                     # Calculate the byte offset for accessing values in the array
add  $t0, $s0, $t4                   # Add the byte offset to the base address
lw   $t3, 0($t0)                     # Load the value
add $t5, $t5, $t3                    # sum
slt  $t2, $t3, $t6
beq $t2, $zero, Change_max
slt  $t2, $t7, $t3
beq $t2, $zero, Change_min
j compare_loop

Change_max:
addi $t6, $t3, 0
j compare_loop

Change_min:
addi $t7, $t3, 0
j compare_loop

End:
li $v0 4
la $a0, sum
syscall
li $v0 1
move $a0, $t5
syscall

li $v0 4
la $a0, max
syscall
move $a0, $t6
li $v0 1
syscall

li $v0 4
la $a0, min
syscall
move $a0, $t7
li $v0 1
syscall

li $v0, 10                           # System call: exit
syscall
	

.data 
array:     .space 512                # Allocate 512 bytes in the "array"
input_msg: .ascii  "Input :"   
space:     .asciiz " "
sum:       .asciiz "Sum : "
max:       .asciiz " Max : "
min:       .asciiz " Min : "
