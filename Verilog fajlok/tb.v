`timescale 1ns / 10ps
module pwm_tst;
// Inputs
    reg clk;
    reg [15:0]mode;
    reg [15:0]pwm;
    reg [15:0]ce;
	 reg [15:0]conf;
    reg reset;
// Outputs
    wire [15:0]out;
// Instantiate the Unit Under Test (UUT)
PWM pmw0 (
.clk(clk),
.conf(conf[0]),
.mode(mode),
.pwm(pwm),
.ce(ce[0]),
.reset(reset),
.out(out[0])
);

PWM pmw1 (
.clk(clk),
.conf(conf[1]),
.mode(mode),
.pwm(pwm),
.ce(ce[1]),
.reset(reset),
.out(out[1])
);
PWM pmw2 (
.clk(clk),
.conf(conf[2]),
.mode(mode),
.pwm(pwm),
.ce(ce[2]),
.reset(reset),
.out(out[2])
);

PWM pmw3 (
.clk(clk),
.conf(conf[3]),
.mode(mode),
.pwm(pwm),
.ce(ce[3]),
.reset(reset),
.out(out[3])
);

PWM pmw4 (
.clk(clk),
.conf(conf[4]),
.mode(mode),
.pwm(pwm),
.ce(ce[4]),
.reset(reset),
.out(out[4])
);

PWM pmw5 (
.clk(clk),
.conf(conf[5]),
.mode(mode),
.pwm(pwm),
.ce(ce[5]),
.reset(reset),
.out(out[5])
);

PWM pmw6 (
.clk(clk),
.conf(conf[6]),
.mode(mode),
.pwm(pwm),
.ce(ce[6]),
.reset(reset),
.out(out[6])
);
PWM pmw7 (
.clk(clk),
.conf(conf[7]),
.mode(mode),
.pwm(pwm),
.ce(ce[7]),
.reset(reset),
.out(out[7])
);

PWM pmw8 (
.clk(clk),
.conf(conf[8]),
.mode(mode),
.pwm(pwm),
.ce(ce[8]),
.reset(reset),
.out(out[8])
);

PWM pmw9 (
.clk(clk),
.conf(conf[9]),
.mode(mode),
.pwm(pwm),
.ce(ce[9]),
.reset(reset),
.out(out[9])
);
PWM pmw10 (
.clk(clk),
.conf(conf[10]),
.mode(mode),
.pwm(pwm),
.ce(ce[10]),
.reset(reset),
.out(out[10])
);

PWM pmw11 (
.clk(clk),
.conf(conf[11]),
.mode(mode),
.pwm(pwm),
.ce(ce[11]),
.reset(reset),
.out(out[11])
);

PWM pmw12 (
.clk(clk),
.conf(conf[12]),
.mode(mode),
.pwm(pwm),
.ce(ce[12]),
.reset(reset),
.out(out[12])
);

PWM pmw13 (
.clk(clk),
.conf(conf[13]),
.mode(mode),
.pwm(pwm),
.ce(ce[13]),
.reset(reset),
.out(out[13])
);

PWM pmw14 (
.clk(clk),
.conf(conf[14]),
.mode(mode),
.pwm(pwm),
.ce(ce[14]),
.reset(reset),
.out(out[14])
);

PWM pmw15 (
.clk(clk),
.conf(conf[15]),
.mode(mode),
.pwm(pwm),
.ce(ce[15]),
.reset(reset),
.out(out[15])
);
initial begin
// Initialize Inputs
clk = 1;
reset= 1; 
ce=0;
conf=0;
// Wait 100 ns for global reset to finish
#100; 
reset=0;
ce=16'b0000000000000011;
conf=16'b0000000000000011;
mode=0;
pwm=256;
#5000;
conf=16'b0000000000000001;
pwm=128;
#5000;
ce=16'b0000000000000101;
conf=16'b0000000000000100;
mode=0;
pwm=64;
#5000;
ce=16'b0000000000000111;
conf=16'b0000000000000110;
pwm=256;
#5000;
reset=1;
end
// órajel generálása 
always #1 clk = ~clk;
endmodule
