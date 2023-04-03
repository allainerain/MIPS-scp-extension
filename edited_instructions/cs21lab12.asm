
.text

#lui	$1, 0xBBAA		#writes 0xBBAA0000 to register 1
#addi	$2, $0, 0xB0		#writes 176 to register 2
#ori	$3, $2, 0x0000B000	#writes the sum of $2 and 45046 to $3
#add	$4, $1, $3		#writes the sum of $1 and $3 to $4
#addi	$5, $0, 0x10		#writes 16 to $5
#sw	$4, 0($5)		#store value of $4 to location pointed to by $5

#writes 0xBBAA0000 to register 1
addi	$1, $0, 0xbbaa
addu	$1, $1, $1
addu	$1, $1, $1
addu	$1, $1, $1
addu	$1, $1, $1
addu	$1, $1, $1
addu	$1, $1, $1
addu	$1, $1, $1
addu	$1, $1, $1
addu	$1, $1, $1
addu	$1, $1, $1
addu	$1, $1, $1
addu	$1, $1, $1
addu	$1, $1, $1
addu	$1, $1, $1
addu	$1, $1, $1
addu	$1, $1, $1

#writes 176 to register 2
addi	$2, $0, 0xB0		

#writes the sum of $2 and 45046 to $3 = 0x0000B0B0
add 	$3, $0, $2
add 	$3, $3, $3
add 	$3, $3, $3
add 	$3, $3, $3
add 	$3, $3, $3
add 	$3, $3, $3
add 	$3, $3, $3
add 	$3, $3, $3
add 	$3, $3, $3
add 	$3, $3, $2

#writes the sum of $1 and $3 to $4 = BBAAB0B0
add	$4, $1, $3		

#writes 16 to $5
addi	$5, $0, 0x10		

#store value of $4 to location pointed to by $5
sw	$4, 0($5)		

li $v0, 10
syscall
end:
	
.data
