all:
	yosys -l cpu.yslog -q cpu.ys

test:
	iverilog -D T1 -f cpu.f
	vvp ./a.out
	iverilog -D T2 -f cpu.f
	vvp ./a.out
	iverilog -D T3 -f cpu.f
	vvp ./a.out
	iverilog -D T4 -f cpu.f
	vvp ./a.out
	iverilog -D T5 -f cpu.f
	vvp ./a.out
	iverilog -D T6 -f cpu.f
	vvp ./a.out
	iverilog -D T7 -f cpu.f
	vvp ./a.out
	iverilog -D T8 -f cpu.f
	vvp ./a.out
	iverilog -D T9 -f cpu.f
	vvp ./a.out
	iverilog -D T10 -f cpu.f
	vvp ./a.out

time:
	cat cpu.yslog | grep WireLoad 

clean:
	rm -f cpu.yslog cpu.edif cpu.constr

