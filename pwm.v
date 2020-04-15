module PWM(
    input clk,
	 input conf,
    input [15:0] mode,
    input [15:0] pwm,
    input ce,
    input reset,
    output out
);
reg [8:0] cntr;
reg [15:0] mode_conf;
reg [15:0] pwm_conf;

always @(posedge clk or posedge reset)
begin
	if(reset)
	begin
		cntr <= 0;
		pwm_conf <=0;
		mode_conf <=0;
	end
	else if(ce)
	begin
			if(mode_conf[0] ==0)
				cntr <= cntr +1;
			else if(mode_conf[0]==1)  
				cntr<= cntr +2;
			if(conf) 
			begin
				mode_conf <= mode;
				pwm_conf <= pwm;
			end
	end
end
assign out = (cntr < pwm_conf) ? 1:0; 
endmodule 



