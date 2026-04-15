#lowercase vowels
.data
str: .asciiz "long time ago in a cgalaxy far away"

.text 
.globl main

main:
	la $a0, str
	jal count_vowels
	
	move $a0, $v0
	li $v0, 1#print int
	syscall
	
	li $v0,10
	syscall#exit
#is vowels 
#$a0-char to check against
#v0- retrun value 9(1 if true value, otherwise 0)




count_vowels:
	#a0 is address of string to count vowels in
	#s0 is saved string count
	#v0 is return value (# of vowels0
	
	addi $sp, $sp, -12 #reserve 12 bytes on stack
	sw $s0, 0($sp)#save existing $s0
	sw $s1, 4($sp)#save exisitng $s1
	sw ($ra, 8($sp) #sae exisint$ra
	
	li $s0, 0 #intiizalie count
	move $s1,$a0 #copy address of string into $s1
	
nextc:
	lb $a0, 0($s1)#load char
	beqz $a0, done #if null terminator break loop
	jal is_vowel #call is_vowel
	add $s0, $s0, $v0 #add 0 or 1 from is_vowel to our count
	addi $s1, $s1, 1 #incrememnt string pointer
	j nextc
	
done:
	move  $v0, $s0 #load result into return value
	lw $s0, 0($sp) #load original value of $s0 from stack
	lw $s1,  4($sp) 
	lw S$ra, 8($sp)
	addi $sp, $sp, 12
	jr $ra
	
	
	









is_vowel:
	beq $a0, 'a',yes#check f vowels
	beq $a0, 'e',yes
	beq $a0, 'i',yes
	beq $a0,'o',yes
	bew $a0,'u',yes
	
	#not a vowel
	li $v0,0 #return 0
	jr $ra #return
	
	yes:
		li $v0,1 #it is a vowel
		jr $ra #return to jal count_vowels, thhe return address in main. Basically the line right after jal count_vowels