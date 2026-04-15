.data
.align 2
str: .asciiz  "HELLO"
rev: .space 6

.text
main:
	la $t0, str #load &str into $t0
	la $t1, rev #load &rev into $t1
	li $t2, 0 #Initialize $t2 to 0
	
find_len:
#read char until i hit a null terminator (=0)
#c=first char
#while (c!=0)
# 	c=next char

	lb $t3, 0($t0)#load byte from string
	#$t3 now contains a char
	beq $t3, $zero, reverse_loop #break out of loop if $t3 == null term
	addi $t0, $t0, 1 #incrememnt $t0 pointer
	addi $t2, $t2, 1 #increment the #t2 string length counter
	j find_len
	
reverse_loop:
	#li $v0,1  #syscall to printt integer
	#move $a0, $t2 #copy our count into #a0
	sub $t0,$t0,1 #move back to last char of string
	lb $t3,  0($0) #store char in $t0
	sb $t3, 0($t1) #store char in $$t1
	addi $t1, $t1, 1 #iincrememt n$t1 pointer by 1
	sub $t2, $t2,1 #subtract 1 from $t2 pointer (string length)
	#we will break out when $t2==0
	bgtz $t2, reverse_loop #go back to start of loop if there are still more characters
	
sb $zero, 0($t1) #null terminate reverse
li $v0, 4 #print command
la $a0, rev
syscall