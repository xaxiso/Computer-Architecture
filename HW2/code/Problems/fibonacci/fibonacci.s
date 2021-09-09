.global fibonacci
.type fibonacci, %function

.align 2
# unsigned long long int fibonacci(int n);
fibonacci:  
    # insert code here
    # Green card here: https://www.cl.cam.ac.uk/teaching/1617/ECAD+Arch/files/docs/RISCVGreenCardv8-20151013.pdf
	add a0, a0, '1'

	ret    
