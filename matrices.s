##include <iostream>
#int main(void) {
#	const int nrows = 4, ncols = 3;
#	int matrix[nrows][ncols] = {{11,12,13},{21,22,23},{31,32,33},{41,42,43}};
#	
#	std::cout << "Practica 4. Trabajando con Matrices\n";
#	int selection;
#	do {
#		int i,j;
#		for (i = 0; i < nrows ; i++) {
#			for (j = 0; j < ncols ; j++)
#				std::cout << matrix[i][j] << " ";
#			std::cout << std::endl;
#		}
#		
#		do {
#			std::cout << "Elija opcion <0> Salir, <1> invertir fila, <2> invertir columna: ";
#			std::cin >> selection;
#		} while (selection < 0 || selection > 2);
#		
#		if (selection != 0) {
#			if (selection == 1) {
#				int f,aux;
#				do {
#					std::cout << "Seleccione fila [" << 1 << "," << nrows << "]: ";
#					std::cin >> f;
#				} while (f < 1 || f > nrows);
#				f--;
#				for (j = 0; j <= (ncols-1) / 2; j++) {
#					aux = matrix[f][j];
#					matrix[f][j] = matrix[f][ncols-1-j];
#					matrix[f][ncols-1-j] = aux;
#				}				
#			} else {  // selection es 2
#				int c,aux;
#				do {
#					std::cout << "Seleccione columna [" << 1 << "," << ncols << "]: ";
#					std::cin >> c;
#				} while ( c < 1 || c > ncols);
#				c--;
#				for (i = 0; i <= (nrows-1) / 2; i++) {
#					aux = matrix[i][c];
#					matrix[i][c] = matrix[nrows-1-i][c];
#					matrix[nrows-1-i][c] = aux;
#				}	
#			}
#		}		
#	} while (selection != 0);
#	return(0);
#}
# selection : $s0
# i         : $s1
# j         : $s2
# f         : $s3
# aux       : $s4
# c         : $s5
# nrows     ; $s6
# ncols     : $s7
 





size = 4 # bytes que ocupa cada elemento 

	.data
matrix: .word  11, 12, 13
	.word  21, 22, 23
	.word  31, 32, 33
	.word  41, 42, 43


nrows:  .word   4 #filas
ncols:  .word   3 #columnas

titulo: 	.asciiz	"Practica 4. Trabajando con Matrices\n"
seleccionar: 	.asciiz	"Elija opcion <0> Salir, <1> invertir fila, <2> invertir columna:\n"
selfil:		.asciiz	"Seleccione fila [1,4]:\n"
selcol: 	.asciiz	"Seleccione columna [1,3]:\n"
salto_de_linea: 	.asciiz	"\n"
espacio:	.asciiz " "


	.text		# directiva que indica la zona de codigo

main:

#int main(void) {
#	const int nrows = 4, ncols = 3;


 li	$s6,4	# nrows 

 li	$s7,3	# ncols

    #int matrix[nrows][ncols] = {{11,12,13},{21,22,23},{31,32,33},{41,42,43}};



              #std::cout << "Practica 4. Trabajando con Matrices\n";
			
			la $a0,titulo
			li $v0,4
			syscall


#do {

#int i,j;
	
#for (i = 0; i < nrows ; i++) {	    		


move $s1,$zero  # i=0
						
	    		

	la $s0,matrix # Cargo matrix

			
for:	beq 	$s1,$s6,fior        #i == nrows 

		
		addi $s1,$s1,1   #i = i + 1	





			#for (j = 0; j < ncols ; j++)

		


			   move $s2,$zero  # j=0
						
					
for2:					beq 	$s2,$s7,for  #j == ncols 

					
	
				 	lw $a0,0($s0) #dirección de memoria de la matriz
				 	li $v0,1
				 	syscall


					la $a0,espacio
					li $v0,4
					syscall
	
beq $s2,2,Parrafo


						addi $s0,$s0,4   # 0($S0) + 4
						
						addi $s2,$s2,1   #j = j + 1			

							b	for2 #Salta a for2:


Parrafo:


									la $a0,salto_de_linea
									li $v0,4
									syscall 


											addi $s0,$s0,4   # 0($S0) + 4

											addi $s2,$s2,1   #j = j + 1



                                                                             			b	for #Salta a for:





fior:


    															 #std::cout << "Elija opcion <0> Salir, <1> invertir fila, <2> invertir columna: ";

																	la $a0,seleccionar
																	li $v0,4
																	syscall


															#std::cin >> selection;

																li	$v0,5
																syscall
																move	$s0,$v0		


												#} while (selection < 0 || selection > 2);

										
													bgt $s0,2,fior #si $s0 > 2

													blt $s0,0,fior #si $s0 < 0

													beq $s0,0,finPrograma # Apaga el programa

											
													#if (selection != 0) {
										
												#if (selection == 1) {

											#int f,aux;

										
#--------------------------------------------------------------------------Cambio de FILAS------------------------------------------------------------------------------



filas:
									


									#do {


							#std::cout << "Seleccione fila [" << 1 << "," << nrows << "]: ";

						
								la $a0,selfil
								li $v0,4
								syscall


						#std::cin >> f;

                                                    li	$v0,5
						    syscall
				        	    move	$s3,$v0

		
                                  
					#while (f < 1 || f > nrows);


				bgt $s3,4,filas #si $s0 > 4 nrows

				blt $s3,1,filas #si $s0 < 1


				#f--;
				
				sub $3,$s3,1

				#for (j = 0; j <= (ncols-1) / 2; j++) {
					#aux = matrix[f][j];
		

      la $s0,matrix # Cargo matrix	
	
#for (j = 0; j <= (ncols-1) / 2; j++) {

	 move $s2,$zero  # j=0

move $s1,$zero  # i=0
	

filor:    bgt	$s2,1,finfilor # j > 10

			
			lw $a0,0($s0) #dirección de memoria de la matriz
			
			sw $s4, 0($s0) # Memoria[$s4 + 100] = $s4

			syscall






			addi $s3,$s3,1   # j++

				b	filor

			


filor2:					beq 	$s1,$s7,for  #j == ncols 

					
	
				 	lw $a0,0($s0) #dirección de memoria de la matriz
				 	li $v0,1
				 	syscall


					la $a0,espacio
					li $v0,4
					syscall
	
					beq $s2,2,Parrafito


						addi $s0,$s0,4   # 0($S0) + 4
						
						addi $s2,$s2,1   #j = j + 1			

							b	filor #Salta a for2:

Parrafito:


									la $a0,salto_de_linea
							greggffdsç4
							a
							ssf
							saf
							sadfsdft
							ew		syscall 


											addi $s0,$s0,4   # 0($S0) + 4

											addi $s2,$s2,1   #j = j + 1



                                                                             			b	filor #Salta a for:



















finfilor:















	



finPrograma:

	# las siguientes dos instrucciones finalizan el programa

	li $v0,10
	syscall




