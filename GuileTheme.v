module lab4(signalout,sw, clk);
	input clk;
	input [1:0] sw;
	output signalout;
	reg signalout;
	reg [31:0] mycounter1, mycounter2, myonesecond, countlow, counthigh;
	reg [31:0] progress, lastnote;

	initial begin
		mycounter1 = 0;
		mycounter2 = 0;
		signalout = 0;
		myonesecond = 50000000;
		progress = 4'b0001;
	end

	always @(posedge clk) begin
		case(progress)
			default: begin

			end
			4'b0000: begin
				mycounter1 = mycounter1 + 1'b1;
				mycounter2 = mycounter2 + 1'b1;

				if(mycounter1 < countlow) begin
					signalout = 0;
				end

				if((mycounter1 >= countlow) && (mycounter1 < counthigh)) begin
					signalout = 1;
				end

				if(mycounter1 >= counthigh) begin
					signalout = 0;
					mycounter1 = 0;

					if(mycounter2 >= myonesecond) begin
						progress = lastnote;
						mycounter2 = 0;
					end
				end
			end
			4'b0001: begin //C5
				countlow = 47778;
				counthigh = 95556;
				progress = 0;
				lastnote = 4'b0010;
			end
			4'b0010: begin //D5
				countlow = 42565;
				counthigh = 85131;
				progress = 0;
				lastnote = 4'b0011;
			end
			4'b0011: begin //E5
				countlow = 37921;
				counthigh = 75843;
				progress = 0;
				lastnote = 4'b0100;
			end
			4'b0100: begin //F5
				countlow = 35793;
				counthigh = 71586;
				progress = 0;
				lastnote = 4'b0101;
			end
			4'b0101: begin //G5
				countlow = 31888;
				counthigh = 63776;
				progress = 0;
				lastnote = 4'b0110;
			end
			4'b0110: begin //A6
				countlow = 28409;
				counthigh = 56818;
				progress = 0;
				lastnote = 4'b0111;
			end
			4'b0111: begin //B6
				countlow = 25309;
				counthigh = 50619;
				progress = 0;
				lastnote = 4'b1000;
			end
			4'b1000: begin //C6
				countlow = 23889;
				counthigh = 47778;
				progress = 0;
				lastnote = 4'b1001;
			end
			4'b1001: begin //D6
				countlow = 21293;
				counthigh = 42587;
				progress = 0;
				lastnote = 4'b1010;
			end
			4'b1010: begin //E6
				countlow = 18960;
				counthigh = 37921;
				progress = 0;
				lastnote = 4'b1011;
			end
			4'b1011: begin //F6
				countlow = 17896;
				counthigh = 35793;
				progress = 0;
				lastnote = 4'b1100;
			end
			4'b1100: begin //G6
				countlow = 15944;
				counthigh = 31888;
				progress = 0;
				lastnote = 4'b0001;
			end
		endcase
	end
endmodule
