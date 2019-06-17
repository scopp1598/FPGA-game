module Lab4(signalout,sw, clk);
	input clk;
	input [1:0] sw;
	output signalout;
	reg signalout;
	reg [31:0] mycounter1, mycounter2, myonesecond, countlow, counthigh;
	reg [31:0] progress, lastnote;
	
	wire clk2;
	assign clk2 = clk/2;
	
	initial begin
		mycounter1 = 0;
		mycounter2 = 0;
		signalout = 0;
		myonesecond = 50000000/8;
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
			4'b0001: begin //E5
				countlow = 37921;
				counthigh = 75843;
				progress = 0;
				lastnote = 2;
			end
			2: begin //E5 
				countlow = 37921;
				counthigh = 75843;
				progress = 0;
				lastnote = 3;
			end
			3: begin //D5 
				countlow = 42565;
				counthigh = 85131;
				progress = 0;
				lastnote = 4;
			end
			4: begin//STALL
				countlow = 0;
				counthigh = 0;
				progress = 0;
				lastnote = 5;				
			end
			5: begin //D5 
				countlow = 42565;
				counthigh = 85131;
				progress = 0;
				lastnote = 6;
			end			
			6: begin //E5
				countlow = 37921;
				counthigh = 75843;
				progress = 0;
				lastnote = 7;
			end			
			7: begin //E5
				countlow = 37921;
				counthigh = 75843;
				progress = 0;
				lastnote = 8;
			end	
			8: begin //D5 
				countlow = 42565;
				counthigh = 85131;
				progress = 0;
				lastnote = 9;
			end
		
	
			9: begin //E5
				countlow = 37921;
				counthigh = 75843;
				progress = 0;
				lastnote = 10;
			end
			10: begin //E5 
				countlow = 37921;
				counthigh = 75843;
				progress = 0;
				lastnote = 11;
			end
			11: begin //D5 
				countlow = 42565;
				counthigh = 85131;
				progress = 0;
				lastnote = 12;
			end
			12: begin//STALL
				countlow = 0;
				counthigh = 0;
				progress = 0;
				lastnote = 13;				
			end
			13: begin //D5 
				countlow = 42565;
				counthigh = 85131;
				progress = 0;
				lastnote = 14;
			end			
			14: begin //E5
				countlow = 37921;
				counthigh = 75843;
				progress = 0;
				lastnote = 15;
			end			
			15: begin //E5
				countlow = 37921;
				counthigh = 75843;
				progress = 0;
				lastnote = 16;
			end	
			16: begin //D5 
				countlow = 42565;
				counthigh = 85131;
				progress = 0;
				lastnote = 17;
			end

	
			17: begin //E5
				countlow = 37921;
				counthigh = 75843;
				progress = 0;
				lastnote = 18;
			end
			18: begin //D5 
				countlow = 42565;
				counthigh = 85131;
				progress = 0;
				lastnote = 19;
			end
			19: begin //E5
				countlow = 37921;
				counthigh = 75843;
				progress = 0;
				lastnote = 20;
			end
			20: begin//STALL
				countlow = 0;
				counthigh = 0;
				progress = 0;
				lastnote = 21;
			end
			21: begin //D5 
				countlow = 42565;
				counthigh = 85131;
				progress = 0;
				lastnote = 22;
			end	
			22: begin //F6
				countlow = 17896;
				counthigh = 35793;
				progress = 0;
				lastnote = 23;
			end
			23: begin//STALL
				countlow = 0;
				counthigh = 0;
				progress = 0;
				lastnote = 24;
			end
			24: begin //F6
				countlow = 17896;
				counthigh = 35793;
				progress = 0;
				lastnote = 25;
			end
			25: begin //E5
				countlow = 37921;
				counthigh = 75843;
				progress = 0;
				lastnote = 26;
			end
			26: begin //D5 
				countlow = 42565;
				counthigh = 85131;
				progress = 0;
				lastnote = 27;
			end	
			27: begin //C6
				countlow = 23889;
				counthigh = 47778;
				progress = 0;
				lastnote = 28;
			end
			
			28: begin //E5
				countlow = 37921;
				counthigh = 75843;
				progress = 0;
				lastnote = 29;
			end
			29: begin //E5 
				countlow = 37921;
				counthigh = 75843;
				progress = 0;
				lastnote = 30;
			end
			30: begin //D5 
				countlow = 42565;
				counthigh = 85131;
				progress = 0;
				lastnote = 31;
			end
			31: begin//STALL
				countlow = 0;
				counthigh = 0;
				progress = 0;
				lastnote = 32;				
			end
			32: begin //D5 
				countlow = 42565;
				counthigh = 85131;
				progress = 0;
				lastnote = 33;
			end			
			33: begin //E5
				countlow = 37921;
				counthigh = 75843;
				progress = 0;
				lastnote = 34;
			end			
			34: begin //E5
				countlow = 37921;
				counthigh = 75843;
				progress = 0;
				lastnote = 35;
			end	
			35: begin //D5 
				countlow = 42565;
				counthigh = 85131;
				progress = 0;
				lastnote = 40;
			end
			
			40: begin //E5
				countlow = 37921;
				counthigh = 75843;
				progress = 0;
				lastnote = 41;
			end
			41: begin //E5 
				countlow = 37921;
				counthigh = 75843;
				progress = 0;
				lastnote = 42;
			end
			42: begin //D5 
				countlow = 42565;
				counthigh = 85131;
				progress = 0;
				lastnote = 43;
			end
			43: begin//STALL
				countlow = 0;
				counthigh = 0;
				progress = 0;
				lastnote = 44;				
			end
			44: begin //D5 
				countlow = 42565;
				counthigh = 85131;
				progress = 0;
				lastnote = 45;
			end			
			45: begin //E5
				countlow = 37921;
				counthigh = 75843;
				progress = 0;
				lastnote = 46;
			end			
			46: begin //E5
				countlow = 37921;
				counthigh = 75843;
				progress = 0;
				lastnote = 47;
			end	
			47: begin //D5 
				countlow = 42565;
				counthigh = 85131;
				progress = 0;
				lastnote = 48;
			end
			
			48: begin //E5
				countlow = 37921;
				counthigh = 75843;
				progress = 0;
				lastnote = 49;
			end
			49: begin //D5 
				countlow = 42565;
				counthigh = 85131;
				progress = 0;
				lastnote = 51;
			end
			51: begin //E5
				countlow = 37921;
				counthigh = 75843;
				progress = 0;
				lastnote = 52;
			end
			52: begin//STALL
				countlow = 0;
				counthigh = 0;
				progress = 0;
				lastnote = 53;
			end
			53: begin //D5 
				countlow = 42565;
				counthigh = 85131;
				progress = 0;
				lastnote = 54;
			end	
			54: begin //F6
				countlow = 17896;
				counthigh = 35793;
				progress = 0;
				lastnote = 55;
			end
			55: begin//STALL
				countlow = 0;
				counthigh = 0;
				progress = 0;
				lastnote = 56;
			end
			56: begin //F6
				countlow = 17896;
				counthigh = 35793;
				progress = 0;
				lastnote = 57;
			end
			57: begin //E5
				countlow = 37921;
				counthigh = 75843;
				progress = 0;
				lastnote = 58;
			end
			58: begin //D5 
				countlow = 42565;
				counthigh = 85131;
				progress = 0;
				lastnote = 59;
			end	
			59: begin //C6
				countlow = 23889;
				counthigh = 47778;
				progress = 0;
				lastnote = 60;
			end
			60: begin //C6
				countlow = 23889;
				counthigh = 47778;
				progress = 0;
				lastnote = 61;
			end
			61: begin //C6
				countlow = 23889;
				counthigh = 47778;
				progress = 0;
				lastnote = 62;
			end
			62: begin //E5
				countlow = 37921;
				counthigh = 75843;
				progress = 0;
				lastnote = 63;
			end			
			63: begin //D5 
				countlow = 42565;
				counthigh = 85131;
				progress = 0;
				lastnote = 64;
			end	
			64: begin //F6
				countlow = 17896;
				counthigh = 35793;
				progress = 0;
				lastnote = 65;
			end
			65: begin //G5
				countlow = 31888;
				counthigh = 63776;
				progress = 0;
				lastnote = 66;
			end
			66: begin //G5
				countlow = 31888;
				counthigh = 63776;
				progress = 0;
				lastnote = 67;
			end
			67: begin //F6
				countlow = 17896;
				counthigh = 35793;
				progress = 0;
				lastnote = 68;
			end			
			68: begin //B5
				countlow = 25309;
				counthigh = 50619;
				progress = 0;
				lastnote = 69;
			end
			69: begin //B5
				countlow = 25309;
				counthigh = 50619;
				progress = 0;
				lastnote = 70;
			end			
			70: begin //A6
				countlow = 28409;
				counthigh = 56818;
				progress = 0;
				lastnote = 71;
			end			
			71: begin //G5
				countlow = 31888;
				counthigh = 63776;
				progress = 0;
				lastnote = 72;
			end
			72: begin //A6
				countlow = 28409;
				counthigh = 56818;
				progress = 0;
				lastnote = 73;
			end
			73: begin //D5 
				countlow = 42565;
				counthigh = 85131;
				progress = 0;
				lastnote = 74;
			end
			74: begin //E5
				countlow = 37921;
				counthigh = 75843;
				progress = 0;
				lastnote = 75;
			end
			75: begin //F6
				countlow = 17896;
				counthigh = 35793;
				progress = 0;
				lastnote = 76;
			end			
			76: begin //C6
				countlow = 23889;
				counthigh = 47778;
				progress = 0;
				lastnote = 77;
			end	
			77: begin //D5 
				countlow = 42565;
				counthigh = 85131;
				progress = 0;
				lastnote = 78;
			end
			78: begin //F6
				countlow = 17896;
				counthigh = 35793;
				progress = 0;
				lastnote = 79;
			end			
			79: begin //A6
				countlow = 28409;
				counthigh = 56818;
				progress = 0;
				lastnote = 80;
			end			
			80: begin //B6
				countlow = 25309;
				counthigh = 50619;
				progress = 0;
				lastnote =81;
			end
			81: begin //C6
				countlow = 23889;
				counthigh = 47778;
				progress = 0;
				lastnote = 82;
			end
			82: begin //G5
				countlow = 31888;
				counthigh = 63776;
				progress = 0;
				lastnote = 83;
			end
			83: begin//STALL
				countlow = 0;
				counthigh = 0;
				progress = 0;
				lastnote = 84;
			end			
			84: begin //C5
				countlow = 47778;
				counthigh = 95556;
				progress = 0;
				lastnote = 85;
			end			
			85: begin //D5 
				countlow = 42565;
				counthigh = 85131;
				progress = 0;
				lastnote = 86;
			end	
			86: begin //F6
				countlow = 17896;
				counthigh = 35793;
				progress = 0;
				lastnote = 87;
			end
			87: begin //A6
				countlow = 28409;
				counthigh = 56818;
				progress = 0;
				lastnote = 88;
			end		
			88: begin //G5
				countlow = 31888;
				counthigh = 63776;
				progress = 0;
				lastnote = 89;
			end
			89: begin//STALL
				countlow = 0;
				counthigh = 0;
				progress = 0;
				lastnote = 90;
			end
			90: begin //G5
				countlow = 31888;
				counthigh = 63776;
				progress = 0;
				lastnote = 91;
			end
			91: begin //F6
				countlow = 17896;
				counthigh = 35793;
				progress = 0;
				lastnote = 92;
			end
			92: begin //D5 
				countlow = 42565;
				counthigh = 85131;
				progress = 0;
				lastnote = 1;
			end
			
			
		endcase	
	end
endmodule