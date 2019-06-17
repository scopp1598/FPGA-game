module gagala (
	//input
	clk, key, debugLED, sw, gamepad, musicOut,
	//output
	VGA_CLK, VGA_HS, VGA_VS, VGA_BLANK_N, VGA_SYNC_N, VGA_R, VGA_G, VGA_B,
	);
	
	input clk;
	input [3:0] key;
	input [9:0] sw;
	input [2:0] gamepad;
	///////// VGA /////////
	output VGA_CLK, VGA_HS, VGA_VS, VGA_BLANK_N, VGA_SYNC_N;
	output [ 7: 0] VGA_R, VGA_G, VGA_B;
	output reg [9:0] debugLED;
	
	
	//	For VGA Controller
	reg	[9:0]	mRed;
	reg	[9:0]	mGreen;
	reg	[9:0]	mBlue;
	wire	[10:0]	VGA_X;
	wire	[10:0]	VGA_Y;
	wire			VGA_Read;	//	VGA data request
	wire			DLY2;

	//	VGA Controller
	wire [9:0] vga_r10;
	wire [9:0] vga_g10;
	wire [9:0] vga_b10;
	assign VGA_R = vga_r10[9:2];
	assign VGA_G = vga_g10[9:2];
	assign VGA_B = vga_b10[9:2];
	
	///MUSIC\\\
	output musicOut;
	
	///Ship Variable Initialization///
	//alive//
	reg ship_alive;
	//For convenience//
	integer xmid;
	integer ymid;
	//position//
	integer ship_x;
	integer ship_y;
	//tanks//
	integer ship_fin_left;		//rear ship component left
	integer ship_fin_right;	//rear ship component right
	//Hull//
	integer ship_hull_x1;		//ship main component top left
	integer ship_hull_x2;		//ship main component top right
	integer ship_hull_y1;		//ship main component bottom left
	integer ship_hull_y2;		//ship main component bottom right
	//Cockpit//
	integer ship_cockpit;		//top component of ship
	//ship_color//
	reg [9:0] ship_red;			//ship red value
	reg [9:0] ship_green;		//ship green value
	reg [9:0] ship_blue;			//ship blue value
	
	///Enemy Variable Initialization///
	//Enemy 1//
	//alive//
	reg alive;
	//hull//
	integer en_hull_x1;			//enemy top left
	integer en_hull_x2;			//enemy top right
	integer en_hull_y1;			//enemy bottom left
	integer en_hull_y2;			//enemy bottom right
	//Enemy Color//
	reg [9:0] en_red;				//enemy red value
	reg [9:0] en_green;			//enemy green value
	reg [9:0] en_blue;			//enemy blue value
	//Enemy Shot//
	reg en_shot;
	integer en_shot_x1, en_shot_x2;
	integer en_shot_y1, en_shot_y2;
	//enemy movement variables
	integer eox, eoy; //enemy offset x and enemy offset y
	integer xFlag, yFlag;
	integer bt1x, bt2x;// the b in y=mx + b for triangle 1 left triangle 
	integer bt1y, bt2y;
	
	//Enemy 2//
	//alive//
	reg alive2;
	//hull//
	integer en_hull2_x1;
	integer en_hull2_x2;
	integer en_hull2_y1;
	integer en_hull2_y2;
	//color//
	reg [9:0] en2_red;
	reg [9:0] en2_green;
	reg [9:0] en2_blue;
	//Enemy Shot//
	reg en_shot2;
	integer en_shot2_x1, en_shot2_x2;
	integer en_shot2_y1, en_shot2_y2;
	//movement//                               This might not be necessary
	
	//Enemy 3//
	//alive//
	reg alive3;
	//hull//
	integer en_hull3_x1;
	integer en_hull3_x2;
	integer en_hull3_y1;
	integer en_hull3_y2;
	//color//
	reg [9:0] en3_red;
	reg [9:0] en3_green;
	reg [9:0] en3_blue;
	//Enemy Shot//
	reg en_shot3;
	integer en_shot3_x1, en_shot3_x2;
	integer en_shot3_y1, en_shot3_y2;
	
	//Enemy 4//
	//alive//
	reg alive4;
	//hull//
	integer en_hull4_x1;			//enemy top left
	integer en_hull4_x2;			//enemy top right
	integer en_hull4_y1;			//enemy bottom left
	integer en_hull4_y2;			//enemy bottom right
	//Enemy Color//
	reg [9:0] en4_red;				//enemy red value
	reg [9:0] en4_green;			//enemy green value
	reg [9:0] en4_blue;			//enemy blue value
	//Enemy Shot//
	reg en_shot4;
	integer en_shot4_x1, en_shot4_x2;
	integer en_shot4_y1, en_shot4_y2;
	
	//Enemy 5//
	//alive//
	reg alive5;
	//hull//
	integer en_hull5_x1;			//enemy top left
	integer en_hull5_x2;			//enemy top right
	integer en_hull5_y1;			//enemy bottom left
	integer en_hull5_y2;			//enemy bottom right
	//Enemy Color//
	reg [9:0] en5_red;				//enemy red value
	reg [9:0] en5_green;			//enemy green value
	reg [9:0] en5_blue;			//enemy blue value
	//Enemy Shot//
	reg en_shot5;
	integer en_shot5_x1, en_shot5_x2;
	integer en_shot5_y1, en_shot5_y2;
	
	//Enemy 6//
	//alive//
	reg alive6;
	//hull//
	integer en_hull6_x1;			//enemy top left
	integer en_hull6_x2;			//enemy top right
	integer en_hull6_y1;			//enemy bottom left
	integer en_hull6_y2;			//enemy bottom right
	//Enemy Color//
	reg [9:0] en6_red;				//enemy red value
	reg [9:0] en6_green;			//enemy green value
	reg [9:0] en6_blue;			//enemy blue value
	//Enemy Shot//
	reg en_shot6;
	integer en_shot6_x1, en_shot6_x2;
	integer en_shot6_y1, en_shot6_y2;
	
	//Enemy 7//
	//alive//
	reg alive7;
	//hull//
	integer en_hull7_x1;			//enemy top left
	integer en_hull7_x2;			//enemy top right
	integer en_hull7_y1;			//enemy bottom left
	integer en_hull7_y2;			//enemy bottom right
	//Enemy Color//
	reg [9:0] en7_red;				//enemy red value
	reg [9:0] en7_green;			//enemy green value
	reg [9:0] en7_blue;			//enemy blue value
	//Enemy Shot//
	reg en_shot7;
	integer en_shot7_x1, en_shot7_x2;
	integer en_shot7_y1, en_shot7_y2;
	
	//Enemy 8//
	//alive//
	reg alive8;
	//hull//
	integer en_hull8_x1;			//enemy top left
	integer en_hull8_x2;			//enemy top right
	integer en_hull8_y1;			//enemy bottom left
	integer en_hull8_y2;			//enemy bottom right
	//Enemy Color//
	reg [9:0] en8_red;				//enemy red value
	reg [9:0] en8_green;			//enemy green value
	reg [9:0] en8_blue;			//enemy blue value
	//Enemy Shot//
	reg en_shot8;
	integer en_shot8_x1, en_shot8_x2;
	integer en_shot8_y1, en_shot8_y2;
	
	//Enemy 9//
	//alive//
	reg alive9;
	//hull//
	integer en_hull9_x1;
	integer en_hull9_x2;
	integer en_hull9_y1;
	integer en_hull9_y2;
	//color//
	reg [9:0] en9_red;
	reg [9:0] en9_green;
	reg [9:0] en9_blue;
	//Enemy Shot//
	reg en_shot9;
	integer en_shot9_x1, en_shot9_x2;
	integer en_shot9_y1, en_shot9_y2;

	//Enemy 10//
	//alive//
	reg alive10;
	//hull//
	integer en_hull10_x1;
	integer en_hull10_x2;
	integer en_hull10_y1;
	integer en_hull10_y2;
	//color//
	reg [9:0] en10_red;
	reg [9:0] en10_green;
	reg [9:0] en10_blue;
	//Enemy Shot//
	reg en_shot10;
	integer en_shot10_x1, en_shot10_x2;
	integer en_shot10_y1, en_shot10_y2;
	
	//Enemy 11//
	//alive//
	reg alive11;
	//hull//
	integer en_hull11_x1;
	integer en_hull11_x2;
	integer en_hull11_y1;
	integer en_hull11_y2;
	//color//
	reg [9:0] en11_red;
	reg [9:0] en11_green;
	reg [9:0] en11_blue;
	//Enemy Shot//
	reg en_shot11;
	integer en_shot11_x1, en_shot11_x2;
	integer en_shot11_y1, en_shot11_y2;
	
	//Enemy 12//
	//alive//
	reg alive12;
	//hull//
	integer en_hull12_x1;
	integer en_hull12_x2;
	integer en_hull12_y1;
	integer en_hull12_y2;
	//color//
	reg [9:0] en12_red;
	reg [9:0] en12_green;
	reg [9:0] en12_blue;
	//Enemy Shot//
	reg en_shot12;
	integer en_shot12_x1, en_shot12_x2;
	integer en_shot12_y1, en_shot12_y2;
	
	//Enemy 13//
	//alive//
	reg alive13;
	//hull//
	integer en_hull13_x1;
	integer en_hull13_x2;
	integer en_hull13_y1;
	integer en_hull13_y2;
	//color//
	reg [9:0] en13_red;
	reg [9:0] en13_green;
	reg [9:0] en13_blue;
	//Enemy Shot//
	reg en_shot13;
	integer en_shot13_x1, en_shot13_x2;
	integer en_shot13_y1, en_shot13_y2;
	
	//Enemy 14//
	//alive//
	reg alive14;
	//hull//
	integer en_hull14_x1;
	integer en_hull14_x2;
	integer en_hull14_y1;
	integer en_hull14_y2;
	//color//
	reg [9:0] en14_red;
	reg [9:0] en14_green;
	reg [9:0] en14_blue;
	//Enemy Shot//
	reg en_shot14;
	integer en_shot14_x1, en_shot14_x2;
	integer en_shot14_y1, en_shot14_y2;
	
	//Enemy 15//
	//alive//
	reg alive15;
	//hull//
	integer en_hull15_x1;
	integer en_hull15_x2;
	integer en_hull15_y1;
	integer en_hull15_y2;
	//color//
	reg [9:0] en15_red;
	reg [9:0] en15_green;
	reg [9:0] en15_blue;
	//Enemy Shot//
	reg en_shot15;
	integer en_shot15_x1, en_shot15_x2;
	integer en_shot15_y1, en_shot15_y2;
	
	//Enemy 16//
	//alive//
	reg alive16;
	//hull//
	integer en_hull16_x1;
	integer en_hull16_x2;
	integer en_hull16_y1;
	integer en_hull16_y2;
	//color//
	reg [9:0] en16_red;
	reg [9:0] en16_green;
	reg [9:0] en16_blue;
	//Enemy Shot//
	reg en_shot16;
	integer en_shot16_x1, en_shot16_x2;
	integer en_shot16_y1, en_shot16_y2;
	
	//Enemy 17//
	//alive//
	reg alive17;
	//hull//
	integer en_hull17_x1;
	integer en_hull17_x2;
	integer en_hull17_y1;
	integer en_hull17_y2;
	//color//
	reg [9:0] en17_red;
	reg [9:0] en17_green;
	reg [9:0] en17_blue;
	//Enemy Shot//
	reg en_shot17;
	integer en_shot17_x1, en_shot17_x2;
	integer en_shot17_y1, en_shot17_y2;
	
	//Enemy 18//
	//alive//
	reg alive18;
	//hull//
	integer en_hull18_x1;
	integer en_hull18_x2;
	integer en_hull18_y1;
	integer en_hull18_y2;
	//color//
	reg [9:0] en18_red;
	reg [9:0] en18_green;
	reg [9:0] en18_blue;
	//Enemy Shot//
	reg en_shot18;
	integer en_shot18_x1, en_shot18_x2;
	integer en_shot18_y1, en_shot18_y2;
	
	//Enemy 19//
	//alive//
	reg alive19;
	//hull//
	integer en_hull19_x1;
	integer en_hull19_x2;
	integer en_hull19_y1;
	integer en_hull19_y2;
	//color//
	reg [9:0] en19_red;
	reg [9:0] en19_green;
	reg [9:0] en19_blue;
	//Enemy Shot//
	reg en_shot19;
	integer en_shot19_x1, en_shot19_x2;
	integer en_shot19_y1, en_shot19_y2;
	
	//Enemy 20//
	//alive//
	reg alive20;
	//hull//
	integer en_hull20_x1;
	integer en_hull20_x2;
	integer en_hull20_y1;
	integer en_hull20_y2;
	//color//
	reg [9:0] en20_red;
	reg [9:0] en20_green;
	reg [9:0] en20_blue;
	//Enemy Shot//
	reg en_shot20;
	integer en_shot20_x1, en_shot20_x2;
	integer en_shot20_y1, en_shot20_y2;
	
	//Enemy 21//
	//alive//
	reg alive21;
	//hull//
	integer en_hull21_x1;
	integer en_hull21_x2;
	integer en_hull21_y1;
	integer en_hull21_y2;
	//color//
	reg [9:0] en21_red;
	reg [9:0] en21_green;
	reg [9:0] en21_blue;
	//Enemy Shot//
	reg en_shot21;
	integer en_shot21_x1, en_shot21_x2;
	integer en_shot21_y1, en_shot21_y2;
	
	//Enemy 22//
	//alive//
	reg alive22;
	//hull//
	integer en_hull22_x1;
	integer en_hull22_x2;
	integer en_hull22_y1;
	integer en_hull22_y2;
	//color//
	reg [9:0] en22_red;
	reg [9:0] en22_green;
	reg [9:0] en22_blue;
	//Enemy Shot//
	reg en_shot22;
	integer en_shot22_x1, en_shot22_x2;
	integer en_shot22_y1, en_shot22_y2;
	
	//Enemy 23//
	//alive//
	reg alive23;
	//hull//
	integer en_hull23_x1;
	integer en_hull23_x2;
	integer en_hull23_y1;
	integer en_hull23_y2;
	//color//
	reg [9:0] en23_red;
	reg [9:0] en23_green;
	reg [9:0] en23_blue;
	//Enemy Shot//
	reg en_shot23;
	integer en_shot23_x1, en_shot23_x2;
	integer en_shot23_y1, en_shot23_y2;
	
	//Enemy 24//
	//alive//
	reg alive24;
	//hull//
	integer en_hull24_x1;
	integer en_hull24_x2;
	integer en_hull24_y1;
	integer en_hull24_y2;
	//color//
	reg [9:0] en24_red;
	reg [9:0] en24_green;
	reg [9:0] en24_blue;
	//Enemy Shot//
	reg en_shot24;
	integer en_shot24_x1, en_shot24_x2;
	integer en_shot24_y1, en_shot24_y2;
	//====================\\
	
	//used for the movement
	integer en_high_x1;
	integer en_high_x2;
	integer en_mid_x1;
	integer en_mid_x2;
	integer en_low_x1;
	integer en_low_x2;
	integer quarter, offset, moveCounter;//used for movement
	integer direction, direction_low, direction_high;//either forwards or backwards 1 / 0
	integer increment;
	
	//Shot Stuff//
	reg shot_act;
	integer shotx1;
	integer shotx2;
	integer shoty1;
	integer shoty2;
	integer shottest; initial shottest = 0;
	
	//enemy shot stuff//
	reg high_shot, mid_shot, low_shot;
	integer high_shot_x1, mid_shot_x1, low_shot_x1;
	integer high_shot_x2, mid_shot_x2, low_shot_x2;
	integer high_shot_y1, mid_shot_y1, low_shot_y1;
	integer high_shot_y2, mid_shot_y2, low_shot_y2;
	
	//Explosion variables//
	reg exp_live;
	integer exp_x1;
	integer exp_y1;
	integer exp_radius;
	reg [9:0] exp_red;
	reg [9:0] exp_green; 
	reg [9:0] exp_blue;
	
	
	initial begin
		dir = 1;
		increment = 1;
		bt1x = 526;
		bt2x = 390;
		alive = 1'b1;
		debugLED = 10'h000;
		
		//Enemy Shot intialization
		high_shot = 1'b0;
		mid_shot = 1'b0;
		low_shot = 1'b0;
		
		///Ship Vars///
		//alive//
		ship_alive = 1'b1;
		//convenience//
		xmid = (ship_hull_x2- ship_hull_x1) - ((ship_hull_x2-ship_hull_x1)/2);
		ymid = (ship_hull_y2 -ship_hull_y1) - ((ship_hull_y2-ship_hull_y1)/2);
		//Ship Position//
		ship_x = 0;
		ship_y = 0;
		//Hull//
		ship_hull_x1 = 62;	//62
		ship_hull_x2 = 74;	//74
		ship_hull_y1 = 452;	//452
		ship_hull_y2 = 476;	//476
		//ship_color//
		ship_red = 10'hFFF;		//Should Truncate
		ship_green = 10'h000;	//Should TRuncate
		ship_blue = 10'hFFF;		//Should truncate
		
		///Explosions///
		//consider having multiple concentric circles after finishing this one
		exp_live = 1'b0;	//This there an explosion or not
		exp_x1 = 0;			//This needs to be the x value in the center of an enemy
		exp_y1 = 0;			//This needs to be the y value in the center of an enemy
		//Next line describes a circle that should appear in the center of an enemy as its alive state
		//goes from 1 to 0, then the circle grows to a point then disappears
		exp_radius = 36;
		//This should be an orange red value
		exp_red = 10'hFFF;
		exp_green = 10'h880;
		exp_blue = 10'h000;
		
		///Enemy///
		//alive
		alive = 1'b1;
		//hull//
		en_hull_x1 = 1;
		en_hull_x2 = 25;
		en_hull_y1 = 100;
		en_hull_y2 = 125;
		//Enemy Color//
		en_red = 10'hFFF;
		en_green = 10'hFFF;
		en_blue = 10'hFFF;
		//Enemy Shot//
		en_shot = 1'b0;
		
		//Enemy 2//
		//alive//
		alive2 = 1'b1;
		//hull//
		en_hull2_x1 = en_hull_x1 + 50;
		en_hull2_x2 = en_hull_x2 + 50;
		en_hull2_y1 = en_hull_y1;
		en_hull2_y2 = en_hull_y2;
		//color//
		en2_red = 10'hFFF;
		en2_green = 10'hFFF;
		en2_blue = 10'hFFF;
		//Enemy Shot//
		en_shot2 = 1'b0;
		
		///Enemy 3///
		//alive
		alive3 = 1'b1;
		//hull//
		en_hull3_x1 = en_hull2_x1 + 50;
		en_hull3_x2 = en_hull2_x2 + 50;
		en_hull3_y1 = en_hull_y1;
		en_hull3_y2 = en_hull_y2;
		//Enemy Color//
		en3_red = 10'hFFF;
		en3_green = 10'hFFF;
		en3_blue = 10'hFFF;
		//Enemy Shot//
		en_shot3 = 1'b0;
		
		///Enemy 4///
		//alive
		alive4 = 1'b1;
		//hull//
		en_hull4_x1 = en_hull3_x1 + 50;
		en_hull4_x2 = en_hull3_x2 + 50;
		en_hull4_y1 = en_hull_y1;
		en_hull4_y2 = en_hull_y2;
		//Enemy Color//
		en4_red = 10'hFFF;
		en4_green = 10'hFFF;
		en4_blue = 10'hFFF;
		//Enemy Shot//
		en_shot4 = 1'b0;
		
		///Enemy 5///
		//alive
		alive5 = 1'b1;
		//hull//
		en_hull5_x1 = en_hull4_x1 + 50;
		en_hull5_x2 = en_hull4_x2 + 50;
		en_hull5_y1 = en_hull_y1;
		en_hull5_y2 = en_hull_y2;
		//Enemy Color//
		en5_red = 10'hFFF;
		en5_green = 10'hFFF;
		en5_blue = 10'hFFF;
		//Enemy Shot//
		en_shot5 = 1'b0;
		
		///Enemy 6///
		//alive
		alive6 = 1'b1;
		//hull//
		en_hull6_x1 = en_hull5_x1 + 50;
		en_hull6_x2 = en_hull5_x2 + 50;
		en_hull6_y1 = en_hull_y1;
		en_hull6_y2 = en_hull_y2;
		//Enemy Color//
		en6_red = 10'hFFF;
		en6_green = 10'hFFF;
		en6_blue = 10'hFFF;
		//Enemy Shot//
		en_shot6 = 1'b0;
		
		///Enemy 7///
		//alive
		alive7 = 1'b1;
		//hull//
		en_hull7_x1 = en_hull6_x1 + 50;
		en_hull7_x2 = en_hull6_x2 + 50;
		en_hull7_y1 = en_hull_y1;
		en_hull7_y2 = en_hull_y2;
		//Enemy Color//
		en7_red = 10'hFFF;
		en7_green = 10'hFFF;
		en7_blue = 10'hFFF;
		//Enemy Shot//
		en_shot7 = 1'b0;
		
		///Enemy 8///
		//alive
		alive8 = 1'b1;
		//hull//
		en_hull8_x1 = en_hull7_x1 + 50;
		en_hull8_x2 = en_hull7_x2 + 50;
		en_hull8_y1 = en_hull_y1;
		en_hull8_y2 = en_hull_y2;
		//Enemy Color//
		en8_red = 10'hFFF;
		en8_green = 10'hFFF;
		en8_blue = 10'hFFF;
		//Enemy Shot//
		en_shot8 = 1'b0;
		
		///Enemy 9///
		//alive
		alive9 = 1'b1;
		//hull//
		en_hull9_x1 = 25;
		en_hull9_x2 = en_hull9_x1 + 25;
		en_hull9_y1 = en_hull_y1 + 100;
		en_hull9_y2 = en_hull_y2 + 100;
		//Enemy Color//
		en9_red = 10'h000;
		en9_green = 10'h000;
		en9_blue = 10'hFFF;
		//Enemy Shot//
		en_shot9 = 1'b0;
		
		///Enemy 10///
		//alive
		alive10 = 1'b1;
		//hull//
		en_hull10_x1 = en_hull9_x1 + 50;
		en_hull10_x2 = en_hull10_x1 + 25;
		en_hull10_y1 = en_hull_y1 + 100;
		en_hull10_y2 = en_hull_y2 + 100;
		//Enemy Color//
		en10_red = 10'h000;
		en10_green = 10'h000;
		en10_blue = 10'hFFF;
		//Enemy Shot//
		en_shot10 = 1'b0;
		
		///Enemy 11///
		//alive
		alive11 = 1'b1;
		//hull//
		en_hull11_x1 = en_hull10_x1 + 50;
		en_hull11_x2 = en_hull11_x1 + 25;
		en_hull11_y1 = en_hull_y1 + 100;
		en_hull11_y2 = en_hull_y2 + 100;
		//Enemy Color//
		en11_red = 10'h000;
		en11_green = 10'h000;
		en11_blue = 10'hFFF;
		//Enemy Shot//
		en_shot11 = 1'b0;
		
		///Enemy 12///
		//alive
		alive12 = 1'b1;
		//hull//
		en_hull12_x1 = en_hull11_x1 + 50;
		en_hull12_x2 = en_hull12_x1 + 25;
		en_hull12_y1 = en_hull_y1 + 100;
		en_hull12_y2 = en_hull_y2 + 100;
		//Enemy Color//
		en12_red = 10'h000;
		en12_green = 10'h000;
		en12_blue = 10'hFFF;
		//Enemy Shot//
		en_shot12 = 1'b0;
		
		///Enemy 13///
		//alive
		alive13 = 1'b1;
		//hull//
		en_hull13_x1 = en_hull12_x1 + 50;
		en_hull13_x2 = en_hull13_x1 + 25;
		en_hull13_y1 = en_hull_y1 + 100;
		en_hull13_y2 = en_hull_y2 + 100;
		//Enemy Color//
		en13_red = 10'h000;
		en13_green = 10'h000;
		en13_blue = 10'hFFF;
		//Enemy Shot//
		en_shot13 = 1'b0;
		
		///Enemy 14///
		//alive
		alive14 = 1'b1;
		//hull//
		en_hull14_x1 = en_hull13_x1 + 50;
		en_hull14_x2 = en_hull14_x1 + 25;
		en_hull14_y1 = en_hull_y1 + 100;
		en_hull14_y2 = en_hull_y2 + 100;
		//Enemy Color//
		en14_red = 10'h000;
		en14_green = 10'h000;
		en14_blue = 10'hFFF;
		//Enemy Shot//
		en_shot14 = 1'b0;
		
		///Enemy 15///
		//alive
		alive15 = 1'b1;
		//hull//
		en_hull15_x1 = en_hull14_x1 + 50;
		en_hull15_x2 = en_hull15_x1 + 25;
		en_hull15_y1 = en_hull_y1 + 100;
		en_hull15_y2 = en_hull_y2 + 100;
		//Enemy Color//
		en15_red = 10'h000;
		en15_green = 10'h000;
		en15_blue = 10'hFFF;
		//Enemy Shot//
		en_shot15 = 1'b0;
		
		///Enemy 16///
		//alive
		alive16 = 1'b1;
		//hull//
		en_hull16_x1 = en_hull15_x1 + 50;
		en_hull16_x2 = en_hull16_x1 + 25;
		en_hull16_y1 = en_hull_y1 + 100;
		en_hull16_y2 = en_hull_y2 + 100;
		//Enemy Color//
		en16_red = 10'h000;
		en16_green = 10'h000;
		en16_blue = 10'hFFF;
		//Enemy Shot//
		en_shot16 = 1'b0;
		
		///Enemy 17///
		//alive
		alive17 = 1'b1;
		//hull//
		en_hull17_x1 = en_hull_x1 + 50;
		en_hull17_x2 = en_hull17_x1 + 25;
		en_hull17_y1 = en_hull_y1 - 100;
		en_hull17_y2 = en_hull_y2 - 100;
		//Enemy Color//
		en17_red = 10'h000;
		en17_green = 10'hFFF;
		en17_blue = 10'h000;
		//Enemy Shot//
		en_shot17 = 1'b0;
		
		///Enemy 18///
		//alive
		alive18 = 1'b1;
		//hull//
		en_hull18_x1 = en_hull17_x1 + 50;
		en_hull18_x2 = en_hull18_x1 + 25;
		en_hull18_y1 = en_hull_y1 - 100;
		en_hull18_y2 = en_hull_y2 - 100;
		//Enemy Color//
		en18_red = 10'h000;
		en18_green = 10'hFFF;
		en18_blue = 10'h000;
		//Enemy Shot//
		en_shot18 = 1'b0;
		
		///Enemy 19///
		//alive
		alive19 = 1'b1;
		//hull//
		en_hull19_x1 = en_hull18_x1 + 50;
		en_hull19_x2 = en_hull19_x1 + 25;
		en_hull19_y1 = en_hull_y1 - 100;
		en_hull19_y2 = en_hull_y2 - 100;
		//Enemy Color//
		en19_red = 10'h000;
		en19_green = 10'hFFF;
		en19_blue = 10'h000;
		//Enemy Shot//
		en_shot19 = 1'b0;
		
		///Enemy 20///
		//alive
		alive20 = 1'b1;
		//hull//
		en_hull20_x1 = en_hull19_x1 + 50;
		en_hull20_x2 = en_hull20_x1 + 25;
		en_hull20_y1 = en_hull_y1 - 100;
		en_hull20_y2 = en_hull_y2 - 100;
		//Enemy Color//
		en20_red = 10'h000;
		en20_green = 10'hFFF;
		en20_blue = 10'h000;
		//Enemy Shot//
		en_shot20 = 1'b0;
		
		///Enemy 21///
		//alive
		alive21 = 1'b1;
		//hull//
		en_hull21_x1 = en_hull20_x1 + 50;
		en_hull21_x2 = en_hull21_x1 + 25;
		en_hull21_y1 = en_hull_y1 - 100;
		en_hull21_y2 = en_hull_y2 - 100;
		//Enemy Color//
		en21_red = 10'h000;
		en21_green = 10'hFFF;
		en21_blue = 10'h000;
		//Enemy Shot//
		en_shot21 = 1'b0;
		
		///Enemy 22///
		//alive
		alive22 = 1'b1;
		//hull//
		en_hull22_x1 = en_hull21_x1 + 50;
		en_hull22_x2 = en_hull22_x1 + 25;
		en_hull22_y1 = en_hull_y1 - 100;
		en_hull22_y2 = en_hull_y2 - 100;
		//Enemy Color//
		en22_red = 10'h000;
		en22_green = 10'hFFF;
		en22_blue = 10'h000;
		//Enemy Shot//
		en_shot22 = 1'b0;
		
		///Enemy 23///
		//alive
		alive23 = 1'b1;
		//hull//
		en_hull23_x1 = en_hull22_x1 + 50;
		en_hull23_x2 = en_hull23_x1 + 25;
		en_hull23_y1 = en_hull_y1 - 100;
		en_hull23_y2 = en_hull_y2 - 100;
		//Enemy Color//
		en23_red = 10'h000;
		en23_green = 10'hFFF;
		en23_blue = 10'h000;
		//Enemy Shot//
		en_shot23 = 1'b0;
		
		///Enemy 24///
		//alive
		alive24 = 1'b1;
		//hull//
		en_hull24_x1 = en_hull23_x1 + 50;
		en_hull24_x2 = en_hull24_x1 + 25;
		en_hull24_y1 = en_hull_y1 - 100;
		en_hull24_y2 = en_hull_y2 - 100;
		//Enemy Color//
		en24_red = 10'h000;
		en24_green = 10'hFFF;
		en24_blue = 10'h000;
		//Enemy Shot//
		en_shot24 = 1'b0;
		
		//movement
		en_high_x1 = en_hull17_x1;
		en_high_x2 = en_hull24_x2;
		en_mid_x1 = en_hull_x1;
		en_mid_x2 = en_hull8_x2;
		en_low_x1 = en_hull9_x1;
		en_low_x2 = en_hull16_x2;
		offset = 32'h00000000;
		moveCounter = 32'h00000000; 
		direction_high = 1;
		direction = 1;
		direction_low = 1;
	end
	
	integer y1, y2, timer, count, dir, arr_r, arr_l, i1, i2, arr_b1, arr_x;
	reg clk25;
	
	always @( posedge clk ) begin
		
		clk25 = !clk25;
		timer = timer + 1;
		
		///Background///
		//This if statement should add start every 32nd pixel 
		//counting from left to right
		i1 = i1 + 120;
		i2 = i2 + 1;
		if (i1 >= 640) begin i1 = i1 - 640; end
		if (i2 >= 480) begin i2 = 0; end
		mRed = (VGA_X >= i1 - 1) && (VGA_X <= i1 + 1) && (VGA_Y >= i2 - 1) && (VGA_Y <= i2 + 1) ? 10'hFFF : 10'b0000000000;
		mGreen = (VGA_X >= i1 - 1) && (VGA_X <= i1 + 1) && (VGA_Y >= i2 - 1) && (VGA_Y <= i2 + 1) ? 10'hFFF : 10'b0000000000;
		mBlue = (VGA_X >= i1 - 1) && (VGA_X <= i1 + 1) && (VGA_Y >= i2 - 1) && (VGA_Y <= i2 + 1) ? 10'hFFF : 10'b0000000000;//(VGA_X == i1) && (VGA_Y == i2)
		
		
		//updating the ship location
		ship_hull_x1 = 62+ship_x;	
		ship_hull_x2 = 74+ship_x;	
		ship_hull_y1 = 452+ship_y;	
		ship_hull_y2 = 476+ship_y;	
				
		
		if ( timer >= 1250000/2) begin
			timer = 0;
			
			//=== Enemy Movement ===\\
			
			//if ( en_hull8_x2 >= 640 || en_hull_x1 <= 0) begin //The bound should probably be their own variable
			if ( en_mid_x2 >= 640 || en_mid_x1 <= 0) begin
				direction = -direction;
			end
			en_hull_x1 = en_hull_x1 + direction;
			en_hull_x2 = en_hull_x2 + direction;
			en_hull2_x1 = en_hull2_x1 + direction;
			en_hull2_x2 = en_hull2_x2 + direction;
			en_hull3_x1 = en_hull3_x1 + direction;
			en_hull3_x2 = en_hull3_x2 + direction;
			en_hull4_x1 = en_hull4_x1 + direction;
			en_hull4_x2 = en_hull4_x2 + direction;
			en_hull5_x1 = en_hull5_x1 + direction;
			en_hull5_x2 = en_hull5_x2 + direction;
			en_hull6_x1 = en_hull6_x1 + direction;
			en_hull6_x2 = en_hull6_x2 + direction;
			en_hull7_x1 = en_hull7_x1 + direction;
			en_hull7_x2 = en_hull7_x2 + direction;
			en_hull8_x1 = en_hull8_x1 + direction;
			en_hull8_x2 = en_hull8_x2 + direction;
			
			if ( en_low_x2 >= 640 || en_low_x1 <= 0) begin
				direction_low = -direction_low;
			end
			en_hull9_x1 = en_hull9_x1 - direction_low;
			en_hull9_x2 = en_hull9_x2 - direction_low;
			en_hull10_x1 = en_hull10_x1 - direction_low;
			en_hull10_x2 = en_hull10_x2 - direction_low;
			en_hull11_x1 = en_hull11_x1 - direction_low;
			en_hull11_x2 = en_hull11_x2 - direction_low;
			en_hull12_x1 = en_hull12_x1 - direction_low;
			en_hull12_x2 = en_hull12_x2 - direction_low;
			en_hull13_x1 = en_hull13_x1 - direction_low;
			en_hull13_x2 = en_hull13_x2 - direction_low;
			en_hull14_x1 = en_hull14_x1 - direction_low;
			en_hull14_x2 = en_hull14_x2 - direction_low;
			en_hull15_x1 = en_hull15_x1 - direction_low;
			en_hull15_x2 = en_hull15_x2 - direction_low;
			en_hull16_x1 = en_hull16_x1 - direction_low;
			en_hull16_x2 = en_hull16_x2 - direction_low;
			
			if ( en_high_x2 >= 640 || en_high_x1 <= 0) begin
				direction_high = -direction_high;
			end
			en_hull17_x1 = en_hull17_x1 - direction_high;
			en_hull17_x2 = en_hull17_x2 - direction_high;
			en_hull18_x1 = en_hull18_x1 - direction_high;
			en_hull18_x2 = en_hull18_x2 - direction_high;
			en_hull19_x1 = en_hull19_x1 - direction_high;
			en_hull19_x2 = en_hull19_x2 - direction_high;
			en_hull20_x1 = en_hull20_x1 - direction_high;
			en_hull20_x2 = en_hull20_x2 - direction_high;
			en_hull21_x1 = en_hull21_x1 - direction_high;
			en_hull21_x2 = en_hull21_x2 - direction_high;
			en_hull22_x1 = en_hull22_x1 - direction_high;
			en_hull22_x2 = en_hull22_x2 - direction_high;
			en_hull23_x1 = en_hull23_x1 - direction_high;
			en_hull23_x2 = en_hull23_x2 - direction_high;
			en_hull24_x1 = en_hull24_x1 - direction_high;
			en_hull24_x2 = en_hull24_x2 - direction_high;

			en_high_x1 = 	alive17	? en_hull17_x1 : 	//if enemy 1 is alive dont let it go off screen to the left
								alive18	? en_hull18_x1 : 	//if enemy 2 is alive dont let it go off screen to the left
								alive19	? en_hull19_x1 :	//if enemy 3 is alive dont let it go off screen to the left
								alive20	? en_hull20_x1 : 	//if enemy 4 is alive dont let it go off screen to the left
								alive21	? en_hull21_x1 :	//if enemy 5 is alive dont let it go off screen to the left
								alive22	? en_hull22_x1 :	//if enemy 6 is alive dont let it go off screen to the left
								alive23	? en_hull23_x1 : 	//if enemy 7 is alive dont let it go off screen to the left
								alive24	? en_hull24_x1 :	//if enemy 8 is alive dont let it go off screen
								0;									//I dont really know what this should be
			en_high_x2 = 	alive24	? en_hull24_x2 : 	//If enemy 8 is alive dont let it go off screen to the right
								alive23	? en_hull23_x2 :	//If enemy 7 is alive dont let it go off screen to the right
								alive22	? en_hull22_x2 :	//If enemy 6 is alive dont let it go off screen to the right
								alive21	? en_hull21_x2 :	//If enemy 5 is alive dont let it go off screen to the right
								alive20	? en_hull20_x2 :	//If enemy 4 is alive dont let it go off screen to the right
								alive19	? en_hull19_x2 :	//If enemy 3 is alive dont let it go off screen to the right
								alive18	? en_hull18_x2 :	//If enemy 2 is alive dont let it go off screen to the right
								alive17	? en_hull17_x2  :	//If enemy 1 is alive dont let it go off screen to the right
								0;									//I dont really know what to make this value either
			en_mid_x1 = 	alive		? en_hull_x1 : 	//if enemy 1 is alive dont let it go off screen to the left
								alive2	? en_hull2_x1 : 	//if enemy 2 is alive dont let it go off screen to the left
								alive3	? en_hull3_x1 :	//if enemy 3 is alive dont let it go off screen to the left
								alive4	? en_hull4_x1 : 	//if enemy 4 is alive dont let it go off screen to the left
								alive5	? en_hull5_x1 :	//if enemy 5 is alive dont let it go off screen to the left
								alive6 	? en_hull6_x1 :	//if enemy 6 is alive dont let it go off screen to the left
								alive7	? en_hull7_x1 : 	//if enemy 7 is alive dont let it go off screen to the left
								alive8	? en_hull8_x1 :	//if enemy 8 is alive dont let it go off screen
								0;									//I dont really know what this should be
			en_mid_x2 = 	alive8	? en_hull8_x2 : 	//If enemy 8 is alive dont let it go off screen to the right
								alive7	? en_hull7_x2 :	//If enemy 7 is alive dont let it go off screen to the right
								alive6	? en_hull6_x2 :	//If enemy 6 is alive dont let it go off screen to the right
								alive5	? en_hull5_x2 :	//If enemy 5 is alive dont let it go off screen to the right
								alive4	? en_hull4_x2 :	//If enemy 4 is alive dont let it go off screen to the right
								alive3	? en_hull3_x2 :	//If enemy 3 is alive dont let it go off screen to the right
								alive2	? en_hull2_x2 :	//If enemy 2 is alive dont let it go off screen to the right
								alive		? en_hull_x2  :	//If enemy 1 is alive dont let it go off screen to the right
								0;									//I dont really know what to make this value either
			en_low_x1 = 	alive9	? en_hull9_x1 : 	//if enemy 9 is alive dont let it go off screen to the left
								alive10	? en_hull10_x1: 	//if enemy 10 is alive dont let it go off screen to the left
								alive11	? en_hull11_x1:	//if enemy 11 is alive dont let it go off screen to the left
								alive12	? en_hull12_x1: 	//if enemy 12 is alive dont let it go off screen to the left
								alive13	? en_hull13_x1:	//if enemy 13 is alive dont let it go off screen to the left
								alive14 	? en_hull14_x1:	//if enemy 14 is alive dont let it go off screen to the left
								alive15	? en_hull15_x1: 	//if enemy 15 is alive dont let it go off screen to the left
								alive16	? en_hull16_x1:	//if enemy 16 is alive dont let it go off screen
								0;									//I dont really know what this should be
			en_low_x2 = 	alive16	? en_hull16_x2:	//if enemy 16 is alive dont let it go off screen
								alive15	? en_hull15_x2: 	//if enemy 15 is alive dont let it go off screen to the left
								alive14 	? en_hull14_x2:	//if enemy 14 is alive dont let it go off screen to the left
								alive13	? en_hull13_x2:	//if enemy 13 is alive dont let it go off screen to the left
								alive12	? en_hull12_x2: 	//if enemy 12 is alive dont let it go off screen to the left
								alive11	? en_hull11_x2:	//if enemy 11 is alive dont let it go off screen to the left
								alive10	? en_hull10_x2: 	//if enemy 10 is alive dont let it go off screen to the left
								alive9	? en_hull9_x2: 	//if enemy 9 is alive dont let it go off screen to the left
								0;									//I dont really know what this should be

			
			
			if(!key[0] || !gamepad[1])begin
				//right
				//xFlag = 1;
				if ( ship_hull_x2 + 12 == 640) begin
					//Do nothing
				end else begin
					ship_x = ship_x + 2;
					//eox = eox + 1;
					bt1x = bt1x + 2;
					bt2x = bt2x - 2;
				end
			end
			if(!key[1] || !gamepad[0])begin
				//left
				if (ship_hull_x1 - 12 == 0) begin
					//Do nothing
				end else begin
					ship_x = ship_x - 2;
					//eox = eox - 1;
					bt1x = bt1x - 2;
					bt2x = bt2x + 2;
				end
			end
			if(!key[2] || !gamepad[2])begin
				//down
//				eoy = eoy + 1;
//				bt1y = bt1y + 1;
//				bt2y = bt1y - 1;
				if (!shot_act) begin
					shot_act = 1;
					shotx1 = ship_hull_x1 + 5;
					shotx2 = ship_hull_x1 + 6;
					shoty1 = ship_hull_y1 - 2;
					shoty2 = ship_hull_y1 + 3;
				end
			end
			if(!key[3])begin
				//up
//				eoy = eoy - 1;
//				bt1y = bt1y - 1;
//				bt2y = bt2y + 1;
			end
			if ( exp_live ) begin
				exp_radius = exp_radius + 10;
			end
		end
		
		if ( (!sw[9]) && (!sw[8]) && (!sw[7]) && (sw[6]) && (!sw[5]) && (!sw[4]) && (!sw[3]) && (sw[2]) && (!sw[1]) && (sw[0]) ) begin
			///Draw Cocket Ship///
			//hull//
			if ( (VGA_X >= ship_hull_x1) && (VGA_X <= ship_hull_x2) && (VGA_Y >= ship_hull_y1) && (VGA_Y <= ship_hull_y2) && (ship_alive) ) begin
				mRed = ship_red;
				mGreen = ship_green;
				mBlue = ship_blue;
			end
			//MIKES SIR-CLE//
			if ( ((VGA_X - (ship_hull_x1+12/2))**2 + (VGA_Y - ship_hull_y1)**2 <= (12/2)**2) && ship_alive ) begin
				mRed = ship_red;
				mGreen = ship_green;
				mBlue = ship_blue;
			end
			//Spherical Fuel Tank Left//
			if ( ((VGA_X - (ship_hull_x1))**2 + (VGA_Y - ship_hull_y2)**2 <= (12/2)**2) && ship_alive ) begin
				mRed = ship_red;
				mGreen = ship_green;
				mBlue = ship_blue;
			end
			//Spherical Fuel Tank Right//
			if ( ((VGA_X - (ship_hull_x2))**2 + (VGA_Y - ship_hull_y2)**2 <= (12/2)**2) && ship_alive ) begin
				mRed = ship_red;
				mGreen = ship_green;
				mBlue = ship_blue;
			end
		end else begin
			///Draw Ship///
			//hull//
			if ( ((VGA_X >= ship_hull_x1) && (VGA_X <= ship_hull_x2) && (VGA_Y >= ship_hull_y1) && (VGA_Y <= ship_hull_y2)) && ship_alive ) begin
				mRed = ship_red;
				mGreen = ship_green;
				mBlue = ship_blue;
			end
			
			///MIKES TRIANGLE LEFT///
			if ( ((VGA_X >= ship_hull_x1 - 12) && (VGA_X <= ship_hull_x1) && (VGA_Y >= -VGA_X + bt1x + bt1y) && (VGA_Y <= ship_hull_y2)) && ship_alive ) begin
				mRed = 10'h0000;
				mGreen = 10'hFFFF;
				mBlue = 10'h000;
			end
			
			//MIKES TRIANGLE RIGHT//
			if ( ((VGA_X >= ship_hull_x2) && (VGA_X <= ship_hull_x2 + 12) && (VGA_Y >=  VGA_X + bt2x + bt2y) && (VGA_Y <= ship_hull_y2)) && ship_alive )begin
				mRed = 10'h0000;
				mGreen = 10'hFFFF;
				mBlue = 10'h000;
			end
			
			//MIKES SIR-CLE//
			if ( ((VGA_X - (ship_hull_x1+12/2))**2 + (VGA_Y - ship_hull_y1)**2 <= (12/2)**2) && ship_alive ) begin
				mRed = ship_red;
				mGreen = ship_green;
				mBlue = ship_blue;
			end
		end
		

		///Shot///
		if ( ((VGA_X >= shotx1) && (VGA_X <= shotx2) && (VGA_Y >= shoty1) && (VGA_Y <= shoty2)) && (shot_act) ) begin
			mRed = 10'hFFF;
			mGreen = 10'hFFF;
			mBlue = 10'hFFF;
			if ((shoty1 >= en_hull_y1) && (shoty1 <= en_hull_y2) && (shotx1 >= en_hull_x1) && (shotx2 <= en_hull_x2)) begin
				if (!exp_live) begin
					exp_x1 = en_hull_x1 + ((en_hull_x2 - en_hull_x1)/2);
					exp_y1 = en_hull_y2;
					exp_live = 1'b1;
				end
				alive = 1'b0;
				en_hull_x1 = 0;
				en_hull_x2 = 0;
				en_hull_y1 = 0;
				en_hull_y2 = 0;
				en_red = 10'h000;
				en_green = 10'h000;
				en_blue = 10'h000;
				shot_act = 0;
			end else if ((shoty1 >= en_hull2_y1) && (shoty1 <= en_hull2_y2) && (shotx1 >= en_hull2_x1) && (shotx2 <= en_hull2_x2)) begin
				if (!exp_live) begin
					exp_x1 = en_hull2_x1 + ((en_hull2_x2 - en_hull2_x1)/2);
					exp_y1 = en_hull2_y2;
					exp_live = 1'b1;
				end
				alive2 = 1'b0;
				en_hull2_x1 = 0;
				en_hull2_x2 = 0;
				en_hull2_y1 = 0;
				en_hull2_y2 = 0;
				en2_red = 10'h000;
				en2_green = 10'h000;
				en2_blue = 10'h000;
				shot_act = 0;
			end else if ((shoty1 >= en_hull3_y1) && (shoty1 <= en_hull3_y2) && (shotx1 >= en_hull3_x1) && (shotx2 <= en_hull3_x2)) begin
				if (!exp_live) begin
					exp_x1 = en_hull3_x1 + ((en_hull3_x2 - en_hull3_x1)/2);
					exp_y1 = en_hull3_y2;
					exp_live = 1'b1;
				end
				alive3 = 1'b0;
				en_hull3_x1 = 0;
				en_hull3_x2 = 0;
				en_hull3_y1 = 0;
				en_hull3_y2 = 0;
				en3_red = 10'h000;
				en3_green = 10'h000;
				en3_blue = 10'h000;
				shot_act = 0;
			end else if ((shoty1 >= en_hull4_y1) && (shoty1 <= en_hull4_y2) && (shotx1 >= en_hull4_x1) && (shotx2 <= en_hull4_x2)) begin
				if (!exp_live) begin
					exp_x1 = en_hull4_x1 + ((en_hull4_x2 - en_hull4_x1)/2);
					exp_y1 = en_hull4_y2;
					exp_live = 1'b1;
				end
				alive4 = 1'b0;
				en_hull4_x1 = 0;
				en_hull4_x2 = 0;
				en_hull4_y1 = 0;
				en_hull4_y2 = 0;
				en4_red = 10'h000;
				en4_green = 10'h000;
				en4_blue = 10'h000;
				shot_act = 0;
			end else if ((shoty1 >= en_hull5_y1) && (shoty1 <= en_hull5_y2) && (shotx1 >= en_hull5_x1) && (shotx2 <= en_hull5_x2)) begin
				if (!exp_live) begin
					exp_x1 = en_hull5_x1 + ((en_hull5_x2 - en_hull5_x1)/2);
					exp_y1 = en_hull5_y2;
					exp_live = 1'b1;
				end
				alive5 = 1'b0;
				en_hull5_x1 = 0;
				en_hull5_x2 = 0;
				en_hull5_y1 = 0;
				en_hull5_y2 = 0;
				en5_red = 10'h000;
				en5_green = 10'h000;
				en5_blue = 10'h000;
				shot_act = 0;
			end else if ((shoty1 >= en_hull6_y1) && (shoty1 <= en_hull6_y2) && (shotx1 >= en_hull6_x1) && (shotx2 <= en_hull6_x2)) begin
				if (!exp_live) begin
					exp_x1 = en_hull6_x1 + ((en_hull6_x2 - en_hull6_x1)/2);
					exp_y1 = en_hull6_y2;
					exp_live = 1'b1;
				end
				alive6 = 1'b0;
				en_hull6_x1 = 0;
				en_hull6_x2 = 0;
				en_hull6_y1 = 0;
				en_hull6_y2 = 0;
				en6_red = 10'h000;
				en6_green = 10'h000;
				en6_blue = 10'h000;
				shot_act = 0;	
			end else if ((shoty1 >= en_hull7_y1) && (shoty1 <= en_hull7_y2) && (shotx1 >= en_hull7_x1) && (shotx2 <= en_hull7_x2)) begin
				if (!exp_live) begin
					exp_x1 = en_hull7_x1 + ((en_hull7_x2 - en_hull7_x1)/2);
					exp_y1 = en_hull7_y2;
					exp_live = 1'b1;
				end
				alive7 = 1'b0;
				en_hull7_x1 = 0;
				en_hull7_x2 = 0;
				en_hull7_y1 = 0;
				en_hull7_y2 = 0;
				en7_red = 10'h000;
				en7_green = 10'h000;
				en7_blue = 10'h000;
				shot_act = 0;
			end else if ((shoty1 >= en_hull8_y1) && (shoty1 <= en_hull8_y2) && (shotx1 >= en_hull8_x1) && (shotx2 <= en_hull8_x2)) begin
				if (!exp_live) begin
					exp_x1 = en_hull8_x1 + ((en_hull8_x2 - en_hull8_x1)/2);
					exp_y1 = en_hull8_y2;
					exp_live = 1'b1;
				end
				alive8 = 1'b0;
				en_hull8_x1 = 0;
				en_hull8_x2 = 0;
				en_hull8_y1 = 0;
				en_hull8_y2 = 0;
				en8_red = 10'h000;
				en8_green = 10'h000;
				en8_blue = 10'h000;
				shot_act = 0;
			end else if ((shoty1 >= en_hull9_y1) && (shoty1 <= en_hull9_y2) && (shotx1 >= en_hull9_x1) && (shotx2 <= en_hull9_x2)) begin
				if (!exp_live) begin
					exp_x1 = en_hull9_x1 + ((en_hull9_x2 - en_hull9_x1)/2);
					exp_y1 = en_hull9_y2;
					exp_live = 1'b1;
				end
				alive9 = 1'b0;
				en_hull9_x1 = 0;
				en_hull9_x2 = 0;
				en_hull9_y1 = 0;
				en_hull9_y2 = 0;
				en9_red = 10'h000;
				en9_green = 10'h000;
				en9_blue = 10'h000;
				shot_act = 0;
			end else if ((shoty1 >= en_hull10_y1) && (shoty1 <= en_hull10_y2) && (shotx1 >= en_hull10_x1) && (shotx2 <= en_hull10_x2)) begin
				if (!exp_live) begin
					exp_x1 = en_hull10_x1 + ((en_hull10_x2 - en_hull10_x1)/2);
					exp_y1 = en_hull10_y2;
					exp_live = 1'b1;
				end
				alive10 = 1'b0;
				en_hull10_x1 = 0;
				en_hull10_x2 = 0;
				en_hull10_y1 = 0;
				en_hull10_y2 = 0;
				en10_red = 10'h000;
				en10_green = 10'h000;
				en10_blue = 10'h000;
				shot_act = 0;
			end else if ((shoty1 >= en_hull11_y1) && (shoty1 <= en_hull11_y2) && (shotx1 >= en_hull11_x1) && (shotx2 <= en_hull11_x2)) begin
				if (!exp_live) begin
					exp_x1 = en_hull11_x1 + ((en_hull11_x2 - en_hull11_x1)/2);
					exp_y1 = en_hull11_y2;
					exp_live = 1'b1;
				end
				alive11 = 1'b0;
				en_hull11_x1 = 0;
				en_hull11_x2 = 0;
				en_hull11_y1 = 0;
				en_hull11_y2 = 0;
				en11_red = 10'h000;
				en11_green = 10'h000;
				en11_blue = 10'h000;
				shot_act = 0;
			end else if ((shoty1 >= en_hull12_y1) && (shoty1 <= en_hull12_y2) && (shotx1 >= en_hull12_x1) && (shotx2 <= en_hull12_x2)) begin
				if (!exp_live) begin
					exp_x1 = en_hull12_x1 + ((en_hull12_x2 - en_hull12_x1)/2);
					exp_y1 = en_hull12_y2;
					exp_live = 1'b1;
				end
				alive12 = 1'b0;
				en_hull12_x1 = 0;
				en_hull12_x2 = 0;
				en_hull12_y1 = 0;
				en_hull12_y2 = 0;
				en12_red = 10'h000;
				en12_green = 10'h000;
				en12_blue = 10'h000;
				shot_act = 0;
			end else if ((shoty1 >= en_hull13_y1) && (shoty1 <= en_hull13_y2) && (shotx1 >= en_hull13_x1) && (shotx2 <= en_hull13_x2)) begin
				if (!exp_live) begin
					exp_x1 = en_hull13_x1 + ((en_hull13_x2 - en_hull13_x1)/2);
					exp_y1 = en_hull13_y2;
					exp_live = 1'b1;
				end
				alive13 = 1'b0;
				en_hull13_x1 = 0;
				en_hull13_x2 = 0;
				en_hull13_y1 = 0;
				en_hull13_y2 = 0;
				en13_red = 10'h000;
				en13_green = 10'h000;
				en13_blue = 10'h000;
				shot_act = 0;
			end else if ((shoty1 >= en_hull14_y1) && (shoty1 <= en_hull14_y2) && (shotx1 >= en_hull14_x1) && (shotx2 <= en_hull14_x2)) begin
				if (!exp_live) begin
					exp_x1 = en_hull14_x1 + ((en_hull14_x2 - en_hull14_x1)/2);
					exp_y1 = en_hull14_y2;
					exp_live = 1'b1;
				end
				alive14 = 1'b0;
				en_hull14_x1 = 0;
				en_hull14_x2 = 0;
				en_hull14_y1 = 0;
				en_hull14_y2 = 0;
				en14_red = 10'h000;
				en14_green = 10'h000;
				en14_blue = 10'h000;
				shot_act = 0;
			end else if ((shoty1 >= en_hull15_y1) && (shoty1 <= en_hull15_y2) && (shotx1 >= en_hull15_x1) && (shotx2 <= en_hull15_x2)) begin
				if (!exp_live) begin
					exp_x1 = en_hull15_x1 + ((en_hull15_x2 - en_hull15_x1)/2);
					exp_y1 = en_hull15_y2;
					exp_live = 1'b1;
				end
				alive15 = 1'b0;
				en_hull15_x1 = 0;
				en_hull15_x2 = 0;
				en_hull15_y1 = 0;
				en_hull15_y2 = 0;
				en15_red = 10'h000;
				en15_green = 10'h000;
				en15_blue = 10'h000;
				shot_act = 0;
			end else if ((shoty1 >= en_hull16_y1) && (shoty1 <= en_hull16_y2) && (shotx1 >= en_hull16_x1) && (shotx2 <= en_hull16_x2)) begin
				if (!exp_live) begin
					exp_x1 = en_hull16_x1 + ((en_hull16_x2 - en_hull16_x1)/2);
					exp_y1 = en_hull16_y2;
					exp_live = 1'b1;
				end
				alive16 = 1'b0;
				en_hull16_x1 = 0;
				en_hull16_x2 = 0;
				en_hull16_y1 = 0;
				en_hull16_y2 = 0;
				en16_red = 10'h000;
				en16_green = 10'h000;
				en16_blue = 10'h000;
				shot_act = 0;
			end else if ((shoty1 >= en_hull17_y1) && (shoty1 <= en_hull17_y2) && (shotx1 >= en_hull17_x1) && (shotx2 <= en_hull17_x2)) begin
				if (!exp_live) begin
					exp_x1 = en_hull17_x1 + ((en_hull17_x2 - en_hull17_x1)/2);
					exp_y1 = en_hull17_y2;
					exp_live = 1'b1;
				end
				alive17 = 1'b0;
				en_hull17_x1 = 0;
				en_hull17_x2 = 0;
				en_hull17_y1 = 0;
				en_hull17_y2 = 0;
				en17_red = 10'h000;
				en17_green = 10'h000;
				en17_blue = 10'h000;
				shot_act = 0;
			end else if ((shoty1 >= en_hull18_y1) && (shoty1 <= en_hull18_y2) && (shotx1 >= en_hull18_x1) && (shotx2 <= en_hull18_x2)) begin
				if (!exp_live) begin
					exp_x1 = en_hull18_x1 + ((en_hull18_x2 - en_hull18_x1)/2);
					exp_y1 = en_hull18_y2;
					exp_live = 1'b1;
				end
				alive18 = 1'b0;
				en_hull18_x1 = 0;
				en_hull18_x2 = 0;
				en_hull18_y1 = 0;
				en_hull18_y2 = 0;
				en18_red = 10'h000;
				en18_green = 10'h000;
				en18_blue = 10'h000;
				shot_act = 0;
			end else if ((shoty1 >= en_hull19_y1) && (shoty1 <= en_hull19_y2) && (shotx1 >= en_hull19_x1) && (shotx2 <= en_hull19_x2)) begin
				if (!exp_live) begin
					exp_x1 = en_hull19_x1 + ((en_hull19_x2 - en_hull19_x1)/2);
					exp_y1 = en_hull19_y2;
					exp_live = 1'b1;
				end
				alive19 = 1'b0;
				en_hull19_x1 = 0;
				en_hull19_x2 = 0;
				en_hull19_y1 = 0;
				en_hull19_y2 = 0;
				en19_red = 10'h000;
				en19_green = 10'h000;
				en19_blue = 10'h000;
				shot_act = 0;
			end else if ((shoty1 >= en_hull20_y1) && (shoty1 <= en_hull20_y2) && (shotx1 >= en_hull20_x1) && (shotx2 <= en_hull20_x2)) begin
				if (!exp_live) begin
					exp_x1 = en_hull20_x1 + ((en_hull20_x2 - en_hull20_x1)/2);
					exp_y1 = en_hull20_y2;
					exp_live = 1'b1;
				end
				alive20 = 1'b0;
				en_hull20_x1 = 0;
				en_hull20_x2 = 0;
				en_hull20_y1 = 0;
				en_hull20_y2 = 0;
				en20_red = 10'h000;
				en20_green = 10'h000;
				en20_blue = 10'h000;
				shot_act = 0;
			end else if ((shoty1 >= en_hull21_y1) && (shoty1 <= en_hull21_y2) && (shotx1 >= en_hull21_x1) && (shotx2 <= en_hull21_x2)) begin
				if (!exp_live) begin
					exp_x1 = en_hull21_x1 + ((en_hull21_x2 - en_hull21_x1)/2);
					exp_y1 = en_hull21_y2;
					exp_live = 1'b1;
				end
				alive21 = 1'b0;
				en_hull21_x1 = 0;
				en_hull21_x2 = 0;
				en_hull21_y1 = 0;
				en_hull21_y2 = 0;
				en21_red = 10'h000;
				en21_green = 10'h000;
				en21_blue = 10'h000;
				shot_act = 0;
			end else if ((shoty1 >= en_hull22_y1) && (shoty1 <= en_hull22_y2) && (shotx1 >= en_hull22_x1) && (shotx2 <= en_hull22_x2)) begin
				if (!exp_live) begin
					exp_x1 = en_hull22_x1 + ((en_hull22_x2 - en_hull22_x1)/2);
					exp_y1 = en_hull22_y2;
					exp_live = 1'b1;
				end
				alive22 = 1'b0;
				en_hull22_x1 = 0;
				en_hull22_x2 = 0;
				en_hull22_y1 = 0;
				en_hull22_y2 = 0;
				en22_red = 10'h000;
				en22_green = 10'h000;
				en22_blue = 10'h000;
				shot_act = 0;
			end else if ((shoty1 >= en_hull23_y1) && (shoty1 <= en_hull23_y2) && (shotx1 >= en_hull23_x1) && (shotx2 <= en_hull23_x2)) begin
				if (!exp_live) begin
					exp_x1 = en_hull23_x1 + ((en_hull23_x2 - en_hull23_x1)/2);
					exp_y1 = en_hull23_y2;
					exp_live = 1'b1;
				end
				alive23 = 1'b0;
				en_hull23_x1 = 0;
				en_hull23_x2 = 0;
				en_hull23_y1 = 0;
				en_hull23_y2 = 0;
				en23_red = 10'h000;
				en23_green = 10'h000;
				en23_blue = 10'h000;
				shot_act = 0;
			end else if ((shoty1 >= en_hull24_y1) && (shoty1 <= en_hull24_y2) && (shotx1 >= en_hull24_x1) && (shotx2 <= en_hull24_x2)) begin
				if (!exp_live) begin
					exp_x1 = en_hull24_x1 + ((en_hull24_x2 - en_hull24_x1)/2);
					exp_y1 = en_hull24_y2;
					exp_live = 1'b1;
				end
				alive24 = 1'b0;
				en_hull24_x1 = 0;
				en_hull24_x2 = 0;
				en_hull24_y1 = 0;
				en_hull24_y2 = 0;
				en24_red = 10'h000;
				en24_green = 10'h000;
				en24_blue = 10'h000;
				shot_act = 0;
			end else if (shoty1 == 0) begin
				shot_act = 0;
			end else begin
				shoty1 = shoty1 - 1;
				shoty2 = shoty2 - 1;
			end
		end
		
		
		//Setting Bullet position//
		if ( alive && (en_hull_x1 <= ship_hull_x1) && (en_hull_x2 >= ship_hull_x2) ) begin
			if ( en_shot != 1'b1 ) begin
				en_shot = 1'b1;
				en_shot_x1 = (en_hull_x1 + en_hull_x2)/2;
				en_shot_x2 = (en_hull_x1 + en_hull_x2)/2 + 1;
				en_shot_y1 = en_hull_y2;
				en_shot_y2 = en_hull_y2 + 1;
			end
		end
		if ( alive2 && (en_hull2_x1 <= ship_hull_x1) && (en_hull2_x2 >= ship_hull_x2) ) begin
			if ( en_shot2 != 1'b1 ) begin
				en_shot2 = 1'b1;
				en_shot2_x1 = (en_hull2_x1 + en_hull2_x2)/2;
				en_shot2_x2 = (en_hull2_x1 + en_hull2_x2)/2 + 1;
				en_shot2_y1 = en_hull2_y2;
				en_shot2_y2 = en_hull2_y2 + 1;
			end
		end
		if ( alive3 && (en_hull3_x1 <= ship_hull_x1) && (en_hull3_x2 >= ship_hull_x2) ) begin
			if ( en_shot3 != 1'b1 ) begin
				en_shot3 = 1'b1;
				en_shot3_x1 = (en_hull3_x1 + en_hull3_x2)/2;
				en_shot3_x2 = (en_hull3_x1 + en_hull3_x2)/2 + 1;
				en_shot3_y1 =  en_hull3_y2;
				en_shot3_y2 =  en_hull3_y2 + 1;
			end
		end
		if ( alive4 && (en_hull4_x1 <= ship_hull_x1) && (en_hull4_x2 >= ship_hull_x2) ) begin
			if ( en_shot4 != 1'b1 ) begin
				en_shot4 = 1'b1;
				en_shot4_x1 = (en_hull4_x1 + en_hull4_x2)/2;
				en_shot4_x2 = (en_hull4_x1 + en_hull4_x2)/2 + 1;
				en_shot4_y1 =  en_hull4_y2;
				en_shot4_y2 =  en_hull4_y2 + 1;
			end
		end
		if ( alive5 && (en_hull5_x1 <= ship_hull_x1) && (en_hull5_x2 >= ship_hull_x2) ) begin
			if ( en_shot5 != 1'b1 ) begin
				en_shot5 = 1'b1;
				en_shot5_x1 = (en_hull5_x1 + en_hull5_x2)/2;
				en_shot5_x2 = (en_hull5_x1 + en_hull5_x2)/2 + 1;
				en_shot5_y1 =  en_hull5_y2;
				en_shot5_y2 =  en_hull5_y2 + 1;
			end
		end
		if ( alive6 && (en_hull6_x1 <= ship_hull_x1) && (en_hull6_x2 >= ship_hull_x2) ) begin
			if ( en_shot6 != 1'b1 ) begin
				  en_shot6 = 1'b1;
				  en_shot6_x1 = (en_hull6_x1 + en_hull6_x2)/2;
				  en_shot6_x2 = (en_hull6_x1 + en_hull6_x2)/2 + 1;
				  en_shot6_y1 =  en_hull6_y2;
				  en_shot6_y2 =  en_hull6_y2 + 1;
			end
		end
		if ( alive7 && (en_hull7_x1 <= ship_hull_x1) && (en_hull7_x2 >= ship_hull_x2) ) begin
			if ( en_shot7 != 1'b1 ) begin
				  en_shot7 = 1'b1;
				  en_shot7_x1 = (en_hull7_x1 + en_hull7_x2)/2;
				  en_shot7_x2 = (en_hull7_x1 + en_hull7_x2)/2 + 1;
				  en_shot7_y1 =  en_hull7_y2;
				  en_shot7_y2 =  en_hull7_y2 + 1;
			end
		end
		if ( alive8 && (en_hull8_x1 <= ship_hull_x1) && (en_hull8_x2 >= ship_hull_x2) ) begin
			if ( en_shot8 != 1'b1 ) begin
				  en_shot8 = 1'b1;
				  en_shot8_x1 = (en_hull8_x1 + en_hull8_x2)/2;
				  en_shot8_x2 = (en_hull8_x1 + en_hull8_x2)/2 + 1;
				  en_shot8_y1 =  en_hull8_y2;
				  en_shot8_y2 =  en_hull8_y2 + 1;
			end
		end		
		if ( alive9 && (en_hull9_x1 <= ship_hull_x1) && (en_hull9_x2 >= ship_hull_x2) ) begin
			if ( en_shot9 != 1'b1 ) begin
				  en_shot9 = 1'b1;
				  en_shot9_x1 = (en_hull9_x1 + en_hull9_x2)/2;
				  en_shot9_x2 = (en_hull9_x1 + en_hull9_x2)/2 + 1;
				  en_shot9_y1 =  en_hull9_y2;
				  en_shot9_y2 =  en_hull9_y2 + 1;
			end
		end		
		if ( alive10 && (en_hull10_x1 <= ship_hull_x1) && (en_hull10_x2 >= ship_hull_x2) ) begin
			if ( en_shot10 != 1'b1 ) begin
				  en_shot10 = 1'b1;
				  en_shot10_x1 = (en_hull10_x1 + en_hull10_x2)/2;
				  en_shot10_x2 = (en_hull10_x1 + en_hull10_x2)/2 + 1;
				  en_shot10_y1 =  en_hull10_y2;
				  en_shot10_y2 =  en_hull10_y2 + 1;
			end
		end		
		if ( alive11 && (en_hull11_x1 <= ship_hull_x1) && (en_hull11_x2 >= ship_hull_x2) ) begin
			if ( en_shot11 != 1'b1 ) begin
				  en_shot11 = 1'b1;
				  en_shot11_x1 = (en_hull11_x1 + en_hull11_x2)/2;
				  en_shot11_x2 = (en_hull11_x1 + en_hull11_x2)/2 + 1;
				  en_shot11_y1 =  en_hull11_y2;
				  en_shot11_y2 =  en_hull11_y2 + 1;
			end
		end		
		if ( alive12 && (en_hull12_x1 <= ship_hull_x1) && (en_hull12_x2 >= ship_hull_x2) ) begin
			if ( en_shot12 != 1'b1 ) begin
				  en_shot12 = 1'b1;
				  en_shot12_x1 = (en_hull12_x1 + en_hull12_x2)/2;
				  en_shot12_x2 = (en_hull12_x1 + en_hull12_x2)/2 + 1;
				  en_shot12_y1 =  en_hull12_y2;
				  en_shot12_y2 =  en_hull12_y2 + 1;
			end
		end
		if ( alive13 && (en_hull13_x1 <= ship_hull_x1) && (en_hull13_x2 >= ship_hull_x2) ) begin
			if ( en_shot13 != 1'b1 ) begin
				  en_shot13 = 1'b1;
				  en_shot13_x1 = (en_hull13_x1 + en_hull13_x2)/2;
				  en_shot13_x2 = (en_hull13_x1 + en_hull13_x2)/2 + 1;
				  en_shot13_y1 =  en_hull13_y2;
				  en_shot13_y2 =  en_hull13_y2 + 1;
			end
		end
		if ( alive14 && (en_hull14_x1 <= ship_hull_x1) && (en_hull14_x2 >= ship_hull_x2) ) begin
			if ( en_shot14 != 1'b1 ) begin
				  en_shot14 = 1'b1;
				  en_shot14_x1 = (en_hull14_x1 + en_hull14_x2)/2;
				  en_shot14_x2 = (en_hull14_x1 + en_hull14_x2)/2 + 1;
				  en_shot14_y1 =  en_hull14_y2;
				  en_shot14_y2 =  en_hull14_y2 + 1;
			end
		end
		if ( alive15 && (en_hull15_x1 <= ship_hull_x1) && (en_hull15_x2 >= ship_hull_x2) ) begin
			if ( en_shot15 != 1'b1 ) begin
				  en_shot15 = 1'b1;
				  en_shot15_x1 = (en_hull15_x1 + en_hull15_x2)/2;
				  en_shot15_x2 = (en_hull15_x1 + en_hull15_x2)/2 + 1;
				  en_shot15_y1 =  en_hull15_y2;
				  en_shot15_y2 =  en_hull15_y2 + 1;
			end
		end
		if ( alive16 && (en_hull16_x1 <= ship_hull_x1) && (en_hull16_x2 >= ship_hull_x2) ) begin
			if ( en_shot16 != 1'b1 ) begin
				  en_shot16 = 1'b1;
				  en_shot16_x1 = (en_hull16_x1 + en_hull16_x2)/2;
				  en_shot16_x2 = (en_hull16_x1 + en_hull16_x2)/2 + 1;
				  en_shot16_y1 =  en_hull16_y2;
				  en_shot16_y2 =  en_hull16_y2 + 1;
			end
		end
		if ( alive17 && (en_hull17_x1 <= ship_hull_x1) && (en_hull17_x2 >= ship_hull_x2) ) begin
			if ( en_shot17 != 1'b1 ) begin
				  en_shot17 = 1'b1;
				  en_shot17_x1 = (en_hull17_x1 + en_hull17_x2)/2;
				  en_shot17_x2 = (en_hull17_x1 + en_hull17_x2)/2 + 1;
				  en_shot17_y1 =  en_hull17_y2;
				  en_shot17_y2 =  en_hull17_y2 + 1;
			end
		end
		if ( alive18 && (en_hull18_x1 <= ship_hull_x1) && (en_hull18_x2 >= ship_hull_x2) ) begin
			if ( en_shot18 != 1'b1 ) begin
				  en_shot18 = 1'b1;
				  en_shot18_x1 = (en_hull18_x1 + en_hull18_x2)/2;
				  en_shot18_x2 = (en_hull18_x1 + en_hull18_x2)/2 + 1;
				  en_shot18_y1 =  en_hull18_y2;
				  en_shot18_y2 =  en_hull18_y2 + 1;
			end
		end
		if ( alive19 && (en_hull19_x1 <= ship_hull_x1) && (en_hull19_x2 >= ship_hull_x2) ) begin
			if ( en_shot19 != 1'b1 ) begin
				  en_shot19 = 1'b1;
				  en_shot19_x1 = (en_hull19_x1 + en_hull19_x2)/2;
				  en_shot19_x2 = (en_hull19_x1 + en_hull19_x2)/2 + 1;
				  en_shot19_y1 =  en_hull19_y2;
				  en_shot19_y2 =  en_hull19_y2 + 1;
			end
		end
		if ( alive20 && (en_hull20_x1 <= ship_hull_x1) && (en_hull20_x2 >= ship_hull_x2) ) begin
			if ( en_shot20 != 1'b1 ) begin
				  en_shot20 = 1'b1;
				  en_shot20_x1 = (en_hull20_x1 + en_hull20_x2)/2;
				  en_shot20_x2 = (en_hull20_x1 + en_hull20_x2)/2 + 1;
				  en_shot20_y1 =  en_hull20_y2;
				  en_shot20_y2 =  en_hull20_y2 + 1;
			end
		end
		if ( alive21 && (en_hull21_x1 <= ship_hull_x1) && (en_hull21_x2 >= ship_hull_x2) ) begin
			if ( en_shot21 != 1'b1 ) begin
				  en_shot21 = 1'b1;
				  en_shot21_x1 = (en_hull21_x1 + en_hull21_x2)/2;
				  en_shot21_x2 = (en_hull21_x1 + en_hull21_x2)/2 + 1;
				  en_shot21_y1 =  en_hull21_y2;
				  en_shot21_y2 =  en_hull21_y2 + 1;
			end
		end
		if ( alive22 && (en_hull22_x1 <= ship_hull_x1) && (en_hull22_x2 >= ship_hull_x2) ) begin
			if ( en_shot22 != 1'b1 ) begin
				  en_shot22 = 1'b1;
				  en_shot22_x1 = (en_hull22_x1 + en_hull22_x2)/2;
				  en_shot22_x2 = (en_hull22_x1 + en_hull22_x2)/2 + 1;
				  en_shot22_y1 =  en_hull22_y2;
				  en_shot22_y2 =  en_hull22_y2 + 1;
			end
		end
		if ( alive23 && (en_hull23_x1 <= ship_hull_x1) && (en_hull23_x2 >= ship_hull_x2) ) begin
			if ( en_shot23 != 1'b1 ) begin
				  en_shot23 = 1'b1;
				  en_shot23_x1 = (en_hull23_x1 + en_hull23_x2)/2;
				  en_shot23_x2 = (en_hull23_x1 + en_hull23_x2)/2 + 1;
				  en_shot23_y1 =  en_hull23_y2;
				  en_shot23_y2 =  en_hull23_y2 + 1;
			end
		end
		if ( alive24 && (en_hull24_x1 <= ship_hull_x1) && (en_hull24_x2 >= ship_hull_x2) ) begin
			if ( en_shot24 != 1'b1 ) begin
				  en_shot24 = 1'b1;
				  en_shot24_x1 = (en_hull24_x1 + en_hull24_x2)/2;
				  en_shot24_x2 = (en_hull24_x1 + en_hull24_x2)/2 + 1;
				  en_shot24_y1 =  en_hull24_y2;
				  en_shot24_y2 =  en_hull24_y2 + 1;
			end
		end

		
		//Enemy Shootin//
		if ( ((VGA_X >= en_shot_x1) && (VGA_X <= en_shot_x2) && (VGA_Y >= en_shot_y1) && (VGA_Y <= en_shot_y2)) && (en_shot) ) begin
			mRed = 10'hFFF;
			mGreen = 10'hFFF;
			mBlue = 10'hFFF;
			if ((en_shot_y1 >= ship_hull_y1) && (en_shot_y2 <= ship_hull_y2) && (en_shot_x1 >= ship_hull_x1) && (en_shot_x2 <= ship_hull_x2)) begin 
				if (!exp_live) begin
					exp_x1 = (ship_hull_x1 + ship_hull_x2)/2;
					exp_y1 = ship_hull_y2;
					exp_live = 1'b1;
				end
				ship_alive = 1'b0;
				ship_hull_x1 = 0;
				ship_hull_x2 = 0;
				ship_hull_y1 = 0;
				ship_hull_y2 = 0;
				ship_red = 10'h000;
				ship_green = 10'h000;
				ship_blue = 10'h000;
				en_shot = 0;
			end else if (en_shot_y1 == 480) begin
					en_shot = 1'b0;
			end else begin
				if(shottest >= 1250000/16) begin
					en_shot_y1 = en_shot_y1 + 1;
					en_shot_y2 = en_shot_y2 + 1;
					shottest = 0;
				end
			end
		end
		if ( ((VGA_X >= en_shot2_x1) && (VGA_X <= en_shot2_x2) && (VGA_Y >= en_shot2_y1) && (VGA_Y <= en_shot2_y2)) && (en_shot2) ) begin
			mRed = 10'hFFF;
			mGreen = 10'hFFF;
			mBlue = 10'hFFF;
			if ((en_shot2_y1 >= ship_hull_y1) && (en_shot2_y2 <= ship_hull_y2) && (en_shot2_x1 >= ship_hull_x1) && (en_shot2_x2 <= ship_hull_x2)) begin // 
				if (!exp_live) begin
					exp_x1 = ship_hull_x1 + ((ship_hull_x2 - ship_hull_x1)/2);
					exp_y1 = ship_hull_y2;
					exp_live = 1'b1;
				end
				ship_alive = 1'b0;
				ship_hull_x1 = 0;
				ship_hull_x2 = 0;
				ship_hull_y1 = 0;
				ship_hull_y2 = 0;
				ship_red = 10'h000;
				ship_green = 10'h000;
				ship_blue = 10'h000;
				en_shot2 = 0;
			end else if (en_shot2_y1 == 480) begin
					en_shot2 = 1'b0;
			end else begin
				if(shottest >= 1250000/16) begin
					en_shot2_y1 = en_shot2_y1 + 1;
					en_shot2_y2 = en_shot2_y2 + 1;
					shottest = 0;
				end
			end
		end
		if ( ((VGA_X >= en_shot3_x1) && (VGA_X <= en_shot3_x2) && (VGA_Y >= en_shot3_y1) && (VGA_Y <= en_shot3_y2)) && (en_shot3) ) begin
			mRed = 10'hFFF;
			mGreen = 10'hFFF;
			mBlue = 10'hFFF;
			if ((en_shot3_y1 >= ship_hull_y1) && (en_shot3_y2 <= ship_hull_y2) && (en_shot3_x1 >= ship_hull_x1) && (en_shot3_x2 <= ship_hull_x2)) begin // 
				if (!exp_live) begin
					exp_x1 = ship_hull_x1 + ((ship_hull_x2 - ship_hull_x1)/2);
					exp_y1 = ship_hull_y2;
					exp_live = 1'b1;
				end
				ship_alive = 1'b0;
				ship_hull_x1 = 0;
				ship_hull_x2 = 0;
				ship_hull_y1 = 0;
				ship_hull_y2 = 0;
				ship_red = 10'h000;
				ship_green = 10'h000;
				ship_blue = 10'h000;
				en_shot3 = 0;
			end else if (en_shot3_y1 == 480) begin
					en_shot3 = 1'b0;
			end else begin
				if(shottest >= 1250000/16) begin
					en_shot3_y1 = en_shot3_y1 + 1;
					en_shot3_y2 = en_shot3_y2 + 1;
					shottest = 0;
				end
			end
		end
		if ( ((VGA_X >= en_shot4_x1) && (VGA_X <= en_shot4_x2) && (VGA_Y >= en_shot4_y1) && (VGA_Y <= en_shot4_y2)) && (en_shot4) ) begin
			mRed = 10'hFFF;
			mGreen = 10'hFFF;
			mBlue = 10'hFFF;
			if ((en_shot4_y1 >= ship_hull_y1) && (en_shot4_y2 <= ship_hull_y2) && (en_shot4_x1 >= ship_hull_x1) && (en_shot4_x2 <= ship_hull_x2)) begin // 
				if (!exp_live) begin
					exp_x1 = ship_hull_x1 + ((ship_hull_x2 - ship_hull_x1)/2);
					exp_y1 = ship_hull_y2;
					exp_live = 1'b1;
				end
				ship_alive = 1'b0;
				ship_hull_x1 = 0;
				ship_hull_x2 = 0;
				ship_hull_y1 = 0;
				ship_hull_y2 = 0;
				ship_red = 10'h000;
				ship_green = 10'h000;
				ship_blue = 10'h000;
				en_shot4 = 0;
			end else if (en_shot4_y1 == 480) begin
					en_shot4 = 1'b0;
			end else begin
				if(shottest >= 1250000/16) begin
					en_shot4_y1 = en_shot4_y1 + 1;
					en_shot4_y2 = en_shot4_y2 + 1;
					shottest = 0;
				end
			end
		end		
		if ( ((VGA_X >= en_shot5_x1) && (VGA_X <= en_shot5_x2) && (VGA_Y >= en_shot5_y1) && (VGA_Y <= en_shot5_y2)) && (en_shot5) ) begin
			mRed = 10'hFFF;
			mGreen = 10'hFFF;
			mBlue = 10'hFFF;
			if ((en_shot5_y1 >= ship_hull_y1) && (en_shot5_y2 <= ship_hull_y2) && (en_shot5_x1 >= ship_hull_x1) && (en_shot5_x2 <= ship_hull_x2)) begin // 
				if (!exp_live) begin
					exp_x1 = ship_hull_x1 + ((ship_hull_x2 - ship_hull_x1)/2);
					exp_y1 = ship_hull_y2;
					exp_live = 1'b1;
				end
				ship_alive = 1'b0;
				ship_hull_x1 = 0;
				ship_hull_x2 = 0;
				ship_hull_y1 = 0;
				ship_hull_y2 = 0;
				ship_red = 10'h000;
				ship_green = 10'h000;
				ship_blue = 10'h000;
				en_shot2 = 0;
			end else if (en_shot5_y1 == 480) begin
					en_shot5 = 1'b0;
			end else begin
				if(shottest >= 1250000/16) begin
					en_shot5_y1 = en_shot5_y1 + 1;
					en_shot5_y2 = en_shot5_y2 + 1;
					shottest = 0;
				end
			end
		end		
		if ( ((VGA_X >= en_shot6_x1) && (VGA_X <= en_shot6_x2) && (VGA_Y >= en_shot6_y1) && (VGA_Y <= en_shot6_y2)) && (en_shot6) ) begin
			mRed = 10'hFFF;
			mGreen = 10'hFFF;
			mBlue = 10'hFFF;
			if ((en_shot6_y1 >= ship_hull_y1) && (en_shot6_y2 <= ship_hull_y2) && (en_shot6_x1 >= ship_hull_x1) && (en_shot6_x2 <= ship_hull_x2)) begin // 
				if (!exp_live) begin
					exp_x1 = ship_hull_x1 + ((ship_hull_x2 - ship_hull_x1)/2);
					exp_y1 = ship_hull_y2;
					exp_live = 1'b1;
				end
				ship_alive = 1'b0;
				ship_hull_x1 = 0;
				ship_hull_x2 = 0;
				ship_hull_y1 = 0;
				ship_hull_y2 = 0;
				ship_red = 10'h000;
				ship_green = 10'h000;
				ship_blue = 10'h000;
				en_shot6 = 0;
			end else if (en_shot6_y1 == 480) begin
					en_shot6 = 1'b0;
			end else begin
				if(shottest >= 1250000/16) begin
					en_shot6_y1 = en_shot6_y1 + 1;
					en_shot6_y2 = en_shot6_y2 + 1;
					shottest = 0;
				end
			end
		end		
		if ( ((VGA_X >= en_shot7_x1) && (VGA_X <= en_shot7_x2) && (VGA_Y >= en_shot7_y1) && (VGA_Y <= en_shot7_y2)) && (en_shot7) ) begin
			mRed = 10'hFFF;
			mGreen = 10'hFFF;
			mBlue = 10'hFFF;
			if ((en_shot7_y1 >= ship_hull_y1) && (en_shot7_y2 <= ship_hull_y2) && (en_shot7_x1 >= ship_hull_x1) && (en_shot7_x2 <= ship_hull_x2)) begin // 
				if (!exp_live) begin
					exp_x1 = ship_hull_x1 + ((ship_hull_x2 - ship_hull_x1)/2);
					exp_y1 = ship_hull_y2;
					exp_live = 1'b1;
				end
				ship_alive = 1'b0;
				ship_hull_x1 = 0;
				ship_hull_x2 = 0;
				ship_hull_y1 = 0;
				ship_hull_y2 = 0;
				ship_red = 10'h000;
				ship_green = 10'h000;
				ship_blue = 10'h000;
				en_shot7 = 0;
			end else if (en_shot7_y1 == 480) begin
					en_shot7 = 1'b0;
			end else begin
				if(shottest >= 1250000/16) begin
					en_shot7_y1 = en_shot7_y1 + 1;
					en_shot7_y2 = en_shot7_y2 + 1;
					shottest = 0;
				end
			end
		end		
		if ( ((VGA_X >= en_shot8_x1) && (VGA_X <= en_shot8_x2) && (VGA_Y >= en_shot8_y1) && (VGA_Y <= en_shot8_y2)) && (en_shot8) ) begin
			mRed = 10'hFFF;
			mGreen = 10'hFFF;
			mBlue = 10'hFFF;
			if ((en_shot8_y1 >= ship_hull_y1) && (en_shot8_y2 <= ship_hull_y2) && (en_shot8_x1 >= ship_hull_x1) && (en_shot8_x2 <= ship_hull_x2)) begin // 
				if (!exp_live) begin
					exp_x1 = ship_hull_x1 + ((ship_hull_x2 - ship_hull_x1)/2);
					exp_y1 = ship_hull_y2;
					exp_live = 1'b1;
				end
				ship_alive = 1'b0;
				ship_hull_x1 = 0;
				ship_hull_x2 = 0;
				ship_hull_y1 = 0;
				ship_hull_y2 = 0;
				ship_red = 10'h000;
				ship_green = 10'h000;
				ship_blue = 10'h000;
				en_shot8 = 0;
			end else if (en_shot8_y1 == 480) begin
					en_shot8 = 1'b0;
			end else begin
				if(shottest >= 1250000/16) begin
					en_shot8_y1 = en_shot8_y1 + 1;
					en_shot8_y2 = en_shot8_y2 + 1;
					shottest = 0;
				end
			end
		end
		if ( ((VGA_X >= en_shot9_x1) && (VGA_X <= en_shot9_x2) && (VGA_Y >= en_shot9_y1) && (VGA_Y <= en_shot9_y2)) && (en_shot9) ) begin
			mRed = 10'hFFF;
			mGreen = 10'hFFF;
			mBlue = 10'hFFF;
			if ((en_shot9_y1 >= ship_hull_y1) && (en_shot9_y2 <= ship_hull_y2) && (en_shot9_x1 >= ship_hull_x1) && (en_shot9_x2 <= ship_hull_x2)) begin // 
				if (!exp_live) begin
					exp_x1 = ship_hull_x1 + ((ship_hull_x2 - ship_hull_x1)/2);
					exp_y1 = ship_hull_y2;
					exp_live = 1'b1;
				end
				ship_alive = 1'b0;
				ship_hull_x1 = 0;
				ship_hull_x2 = 0;
				ship_hull_y1 = 0;
				ship_hull_y2 = 0;
				ship_red = 10'h000;
				ship_green = 10'h000;
				ship_blue = 10'h000;
				en_shot9 = 0;
			end else if (en_shot9_y1 == 480) begin
					en_shot9 = 1'b0;
			end else begin
				if(shottest >= 1250000/16) begin
					en_shot9_y1 = en_shot9_y1 + 1;
					en_shot9_y2 = en_shot9_y2 + 1;
					shottest = 0;
				end
			end
		end		
		if ( ((VGA_X >= en_shot10_x1) && (VGA_X <= en_shot10_x2) && (VGA_Y >= en_shot10_y1) && (VGA_Y <= en_shot10_y2)) && (en_shot10) ) begin
			mRed = 10'hFFF;
			mGreen = 10'hFFF;
			mBlue = 10'hFFF;
			if ((en_shot10_y1 >= ship_hull_y1) && (en_shot10_y2 <= ship_hull_y2) && (en_shot10_x1 >= ship_hull_x1) && (en_shot10_x2 <= ship_hull_x2)) begin // 
				if (!exp_live) begin
					exp_x1 = ship_hull_x1 + ((ship_hull_x2 - ship_hull_x1)/2);
					exp_y1 = ship_hull_y2;
					exp_live = 1'b1;
				end
				ship_alive = 1'b0;
				ship_hull_x1 = 0;
				ship_hull_x2 = 0;
				ship_hull_y1 = 0;
				ship_hull_y2 = 0;
				ship_red = 10'h000;
				ship_green = 10'h000;
				ship_blue = 10'h000;
				en_shot10 = 0;
			end else if (en_shot10_y1 == 480) begin
					en_shot10 = 1'b0;
			end else begin
				if(shottest >= 1250000/16) begin
					en_shot10_y1 = en_shot10_y1 + 1;
					en_shot10_y2 = en_shot10_y2 + 1;
					shottest = 0;
				end
			end
		end		
		if ( ((VGA_X >= en_shot11_x1) && (VGA_X <= en_shot11_x2) && (VGA_Y >= en_shot11_y1) && (VGA_Y <= en_shot11_y2)) && (en_shot11) ) begin
			mRed = 10'hFFF;
			mGreen = 10'hFFF;
			mBlue = 10'hFFF;
			if ((en_shot11_y1 >= ship_hull_y1) && (en_shot11_y2 <= ship_hull_y2) && (en_shot11_x1 >= ship_hull_x1) && (en_shot11_x2 <= ship_hull_x2)) begin // 
				if (!exp_live) begin
					exp_x1 = ship_hull_x1 + ((ship_hull_x2 - ship_hull_x1)/2);
					exp_y1 = ship_hull_y2;
					exp_live = 1'b1;
				end
				ship_alive = 1'b0;
				ship_hull_x1 = 0;
				ship_hull_x2 = 0;
				ship_hull_y1 = 0;
				ship_hull_y2 = 0;
				ship_red = 10'h000;
				ship_green = 10'h000;
				ship_blue = 10'h000;
				en_shot11 = 0;
			end else if (en_shot11_y1 == 480) begin
					en_shot11 = 1'b0;
			end else begin
				if(shottest >= 1250000/16) begin
					en_shot11_y1 = en_shot11_y1 + 1;
					en_shot11_y2 = en_shot11_y2 + 1;
					shottest = 0;
				end
			end
		end
		if ( ((VGA_X >= en_shot12_x1) && (VGA_X <= en_shot12_x2) && (VGA_Y >= en_shot12_y1) && (VGA_Y <= en_shot12_y2)) && (en_shot12) ) begin
			mRed = 10'hFFF;
			mGreen = 10'hFFF;
			mBlue = 10'hFFF;
			if ((en_shot12_y1 >= ship_hull_y1) && (en_shot12_y2 <= ship_hull_y2) && (en_shot12_x1 >= ship_hull_x1) && (en_shot12_x2 <= ship_hull_x2)) begin // 
				if (!exp_live) begin
					exp_x1 = ship_hull_x1 + ((ship_hull_x2 - ship_hull_x1)/2);
					exp_y1 = ship_hull_y2;
					exp_live = 1'b1;
				end
				ship_alive = 1'b0;
				ship_hull_x1 = 0;
				ship_hull_x2 = 0;
				ship_hull_y1 = 0;
				ship_hull_y2 = 0;
				ship_red = 10'h000;
				ship_green = 10'h000;
				ship_blue = 10'h000;
				en_shot12 = 0;
			end else if (en_shot12_y1 == 480) begin
					en_shot12 = 1'b0;
			end else begin
				if(shottest >= 1250000/16) begin
					en_shot12_y1 = en_shot12_y1 + 1;
					en_shot12_y2 = en_shot12_y2 + 1;
					shottest = 0;
				end
			end
		end		
		if ( ((VGA_X >= en_shot13_x1) && (VGA_X <= en_shot13_x2) && (VGA_Y >= en_shot13_y1) && (VGA_Y <= en_shot13_y2)) && (en_shot13) ) begin
			mRed = 10'hFFF;
			mGreen = 10'hFFF;
			mBlue = 10'hFFF;
			if ((en_shot13_y1 >= ship_hull_y1) && (en_shot13_y2 <= ship_hull_y2) && (en_shot13_x1 >= ship_hull_x1) && (en_shot13_x2 <= ship_hull_x2)) begin // 
				if (!exp_live) begin
					exp_x1 = ship_hull_x1 + ((ship_hull_x2 - ship_hull_x1)/2);
					exp_y1 = ship_hull_y2;
					exp_live = 1'b1;
				end
				ship_alive = 1'b0;
				ship_hull_x1 = 0;
				ship_hull_x2 = 0;
				ship_hull_y1 = 0;
				ship_hull_y2 = 0;
				ship_red = 10'h000;
				ship_green = 10'h000;
				ship_blue = 10'h000;
				en_shot13 = 0;
			end else if (en_shot13_y1 == 480) begin
					en_shot13 = 1'b0;
			end else begin
				if(shottest >= 1250000/16) begin
					en_shot13_y1 = en_shot13_y1 + 1;
					en_shot13_y2 = en_shot13_y2 + 1;
					shottest = 0;
				end
			end
		end		
		if ( ((VGA_X >= en_shot14_x1) && (VGA_X <= en_shot14_x2) && (VGA_Y >= en_shot14_y1) && (VGA_Y <= en_shot14_y2)) && (en_shot14) ) begin
			mRed = 10'hFFF;
			mGreen = 10'hFFF;
			mBlue = 10'hFFF;
			if ((en_shot14_y1 >= ship_hull_y1) && (en_shot14_y2 <= ship_hull_y2) && (en_shot14_x1 >= ship_hull_x1) && (en_shot14_x2 <= ship_hull_x2)) begin // 
				if (!exp_live) begin
					exp_x1 = ship_hull_x1 + ((ship_hull_x2 - ship_hull_x1)/2);
					exp_y1 = ship_hull_y2;
					exp_live = 1'b1;
				end
				ship_alive = 1'b0;
				ship_hull_x1 = 0;
				ship_hull_x2 = 0;
				ship_hull_y1 = 0;
				ship_hull_y2 = 0;
				ship_red = 10'h000;
				ship_green = 10'h000;
				ship_blue = 10'h000;
				en_shot14 = 0;
			end else if (en_shot14_y1 == 480) begin
					en_shot14 = 1'b0;
			end else begin
				if(shottest >= 1250000/16) begin
					en_shot14_y1 = en_shot14_y1 + 1;
					en_shot14_y2 = en_shot14_y2 + 1;
					shottest = 0;
				end
			end
		end		
		if ( ((VGA_X >= en_shot15_x1) && (VGA_X <= en_shot15_x2) && (VGA_Y >= en_shot15_y1) && (VGA_Y <= en_shot15_y2)) && (en_shot15) ) begin
			mRed = 10'hFFF;
			mGreen = 10'hFFF;
			mBlue = 10'hFFF;
			if ((en_shot15_y1 >= ship_hull_y1) && (en_shot15_y2 <= ship_hull_y2) && (en_shot15_x1 >= ship_hull_x1) && (en_shot15_x2 <= ship_hull_x2)) begin // 
				if (!exp_live) begin
					exp_x1 = ship_hull_x1 + ((ship_hull_x2 - ship_hull_x1)/2);
					exp_y1 = ship_hull_y2;
					exp_live = 1'b1;
				end
				ship_alive = 1'b0;
				ship_hull_x1 = 0;
				ship_hull_x2 = 0;
				ship_hull_y1 = 0;
				ship_hull_y2 = 0;
				ship_red = 10'h000;
				ship_green = 10'h000;
				ship_blue = 10'h000;
				en_shot15 = 0;
			end else if (en_shot15_y1 == 480) begin
					en_shot15 = 1'b0;
			end else begin
				if(shottest >= 1250000/16) begin
					en_shot15_y1 = en_shot15_y1 + 1;
					en_shot15_y2 = en_shot15_y2 + 1;
					shottest = 0;
				end
			end
		end		
		if ( ((VGA_X >= en_shot6_x1) && (VGA_X <= en_shot6_x2) && (VGA_Y >= en_shot6_y1) && (VGA_Y <= en_shot6_y2)) && (en_shot6) ) begin
			mRed = 10'hFFF;
			mGreen = 10'hFFF;
			mBlue = 10'hFFF;
			if ((en_shot6_y1 >= ship_hull_y1) && (en_shot6_y2 <= ship_hull_y2) && (en_shot6_x1 >= ship_hull_x1) && (en_shot6_x2 <= ship_hull_x2)) begin // 
				if (!exp_live) begin
					exp_x1 = ship_hull_x1 + ((ship_hull_x2 - ship_hull_x1)/2);
					exp_y1 = ship_hull_y2;
					exp_live = 1'b1;
				end
				ship_alive = 1'b0;
				ship_hull_x1 = 0;
				ship_hull_x2 = 0;
				ship_hull_y1 = 0;
				ship_hull_y2 = 0;
				ship_red = 10'h000;
				ship_green = 10'h000;
				ship_blue = 10'h000;
				en_shot6 = 0;
			end else if (en_shot6_y1 == 480) begin
					en_shot6 = 1'b0;
			end else begin
				if(shottest >= 1250000/16) begin
					en_shot6_y1 = en_shot6_y1 + 1;
					en_shot6_y2 = en_shot6_y2 + 1;
					shottest = 0;
				end
			end
		end
		if ( ((VGA_X >= en_shot17_x1) && (VGA_X <= en_shot17_x2) && (VGA_Y >= en_shot17_y1) && (VGA_Y <= en_shot17_y2)) && (en_shot17) ) begin
			mRed = 10'hFFF;
			mGreen = 10'hFFF;
			mBlue = 10'hFFF;
			if ((en_shot17_y1 >= ship_hull_y1) && (en_shot17_y2 <= ship_hull_y2) && (en_shot17_x1 >= ship_hull_x1) && (en_shot17_x2 <= ship_hull_x2)) begin // 
				if (!exp_live) begin
					exp_x1 = ship_hull_x1 + ((ship_hull_x2 - ship_hull_x1)/2);
					exp_y1 = ship_hull_y2;
					exp_live = 1'b1;
				end
				ship_alive = 1'b0;
				ship_hull_x1 = 0;
				ship_hull_x2 = 0;
				ship_hull_y1 = 0;
				ship_hull_y2 = 0;
				ship_red = 10'h000;
				ship_green = 10'h000;
				ship_blue = 10'h000;
				en_shot17 = 0;
			end else if (en_shot17_y1 == 480) begin
					en_shot17 = 1'b0;
			end else begin
				if(shottest >= 1250000/16) begin
					en_shot17_y1 = en_shot17_y1 + 1;
					en_shot17_y2 = en_shot17_y2 + 1;
					shottest = 0;
				end
			end
		end
		if ( ((VGA_X >= en_shot18_x1) && (VGA_X <= en_shot18_x2) && (VGA_Y >= en_shot18_y1) && (VGA_Y <= en_shot18_y2)) && (en_shot18) ) begin
			mRed = 10'hFFF;
			mGreen = 10'hFFF;
			mBlue = 10'hFFF;
			if ((en_shot18_y1 >= ship_hull_y1) && (en_shot18_y2 <= ship_hull_y2) && (en_shot18_x1 >= ship_hull_x1) && (en_shot18_x2 <= ship_hull_x2)) begin // 
				if (!exp_live) begin
					exp_x1 = ship_hull_x1 + ((ship_hull_x2 - ship_hull_x1)/2);
					exp_y1 = ship_hull_y2;
					exp_live = 1'b1;
				end
				ship_alive = 1'b0;
				ship_hull_x1 = 0;
				ship_hull_x2 = 0;
				ship_hull_y1 = 0;
				ship_hull_y2 = 0;
				ship_red = 10'h000;
				ship_green = 10'h000;
				ship_blue = 10'h000;
				en_shot18 = 0;
			end else if (en_shot18_y1 == 480) begin
					en_shot18 = 1'b0;
			end else begin
				if(shottest >= 1250000/16) begin
					en_shot18_y1 = en_shot18_y1 + 1;
					en_shot18_y2 = en_shot18_y2 + 1;
					shottest = 0;
				end
			end
		end		
		if ( ((VGA_X >= en_shot19_x1) && (VGA_X <= en_shot19_x2) && (VGA_Y >= en_shot19_y1) && (VGA_Y <= en_shot19_y2)) && (en_shot19) ) begin
			mRed = 10'hFFF;
			mGreen = 10'hFFF;
			mBlue = 10'hFFF;
			if ((en_shot19_y1 >= ship_hull_y1) && (en_shot19_y2 <= ship_hull_y2) && (en_shot19_x1 >= ship_hull_x1) && (en_shot19_x2 <= ship_hull_x2)) begin // 
				if (!exp_live) begin
					exp_x1 = ship_hull_x1 + ((ship_hull_x2 - ship_hull_x1)/2);
					exp_y1 = ship_hull_y2;
					exp_live = 1'b1;
				end
				ship_alive = 1'b0;
				ship_hull_x1 = 0;
				ship_hull_x2 = 0;
				ship_hull_y1 = 0;
				ship_hull_y2 = 0;
				ship_red = 10'h000;
				ship_green = 10'h000;
				ship_blue = 10'h000;
				en_shot19 = 0;
			end else if (en_shot19_y1 == 480) begin
					en_shot19 = 1'b0;
			end else begin
				if(shottest >= 1250000/16) begin
					en_shot19_y1 = en_shot19_y1 + 1;
					en_shot19_y2 = en_shot19_y2 + 1;
					shottest = 0;
				end
			end
		end		
		if ( ((VGA_X >= en_shot20_x1) && (VGA_X <= en_shot20_x2) && (VGA_Y >= en_shot20_y1) && (VGA_Y <= en_shot20_y2)) && (en_shot20) ) begin
			mRed = 10'hFFF;
			mGreen = 10'hFFF;
			mBlue = 10'hFFF;
			if ((en_shot20_y1 >= ship_hull_y1) && (en_shot20_y2 <= ship_hull_y2) && (en_shot20_x1 >= ship_hull_x1) && (en_shot20_x2 <= ship_hull_x2)) begin // 
				if (!exp_live) begin
					exp_x1 = ship_hull_x1 + ((ship_hull_x2 - ship_hull_x1)/2);
					exp_y1 = ship_hull_y2;
					exp_live = 1'b1;
				end
				ship_alive = 1'b0;
				ship_hull_x1 = 0;
				ship_hull_x2 = 0;
				ship_hull_y1 = 0;
				ship_hull_y2 = 0;
				ship_red = 10'h000;
				ship_green = 10'h000;
				ship_blue = 10'h000;
				en_shot20 = 0;
			end else if (en_shot20_y1 == 480) begin
					en_shot20 = 1'b0;
			end else begin
				if(shottest >= 1250000/16) begin
					en_shot20_y1 = en_shot20_y1 + 1;
					en_shot20_y2 = en_shot20_y2 + 1;
					shottest = 0;
				end
			end
		end
		if ( ((VGA_X >= en_shot21_x1) && (VGA_X <= en_shot21_x2) && (VGA_Y >= en_shot21_y1) && (VGA_Y <= en_shot21_y2)) && (en_shot21) ) begin
			mRed = 10'hFFF;
			mGreen = 10'hFFF;
			mBlue = 10'hFFF;
			if ((en_shot21_y1 >= ship_hull_y1) && (en_shot21_y2 <= ship_hull_y2) && (en_shot21_x1 >= ship_hull_x1) && (en_shot21_x2 <= ship_hull_x2)) begin // 
				if (!exp_live) begin
					exp_x1 = ship_hull_x1 + ((ship_hull_x2 - ship_hull_x1)/2);
					exp_y1 = ship_hull_y2;
					exp_live = 1'b1;
				end
				ship_alive = 1'b0;
				ship_hull_x1 = 0;
				ship_hull_x2 = 0;
				ship_hull_y1 = 0;
				ship_hull_y2 = 0;
				ship_red = 10'h000;
				ship_green = 10'h000;
				ship_blue = 10'h000;
				en_shot21 = 0;
			end else if (en_shot21_y1 == 480) begin
					en_shot21 = 1'b0;
			end else begin
				if(shottest >= 1250000/16) begin
					en_shot21_y1 = en_shot21_y1 + 1;
					en_shot21_y2 = en_shot21_y2 + 1;
					shottest = 0;
				end
			end
		end
		if ( ((VGA_X >= en_shot22_x1) && (VGA_X <= en_shot22_x2) && (VGA_Y >= en_shot22_y1) && (VGA_Y <= en_shot22_y2)) && (en_shot22) ) begin
			mRed = 10'hFFF;
			mGreen = 10'hFFF;
			mBlue = 10'hFFF;
			if ((en_shot22_y1 >= ship_hull_y1) && (en_shot22_y2 <= ship_hull_y2) && (en_shot22_x1 >= ship_hull_x1) && (en_shot22_x2 <= ship_hull_x2)) begin // 
				if (!exp_live) begin
					exp_x1 = ship_hull_x1 + ((ship_hull_x2 - ship_hull_x1)/2);
					exp_y1 = ship_hull_y2;
					exp_live = 1'b1;
				end
				ship_alive = 1'b0;
				ship_hull_x1 = 0;
				ship_hull_x2 = 0;
				ship_hull_y1 = 0;
				ship_hull_y2 = 0;
				ship_red = 10'h000;
				ship_green = 10'h000;
				ship_blue = 10'h000;
				en_shot22 = 0;
			end else if (en_shot22_y1 == 480) begin
					en_shot22 = 1'b0;
			end else begin
				if(shottest >= 1250000/16) begin
					en_shot22_y1 = en_shot22_y1 + 1;
					en_shot22_y2 = en_shot22_y2 + 1;
					shottest = 0;
				end
			end
		end
		if ( ((VGA_X >= en_shot23_x1) && (VGA_X <= en_shot23_x2) && (VGA_Y >= en_shot23_y1) && (VGA_Y <= en_shot23_y2)) && (en_shot23) ) begin
			mRed = 10'hFFF;
			mGreen = 10'hFFF;
			mBlue = 10'hFFF;
			if ((en_shot23_y1 >= ship_hull_y1) && (en_shot23_y2 <= ship_hull_y2) && (en_shot23_x1 >= ship_hull_x1) && (en_shot23_x2 <= ship_hull_x2)) begin // 
				if (!exp_live) begin
					exp_x1 = ship_hull_x1 + ((ship_hull_x2 - ship_hull_x1)/2);
					exp_y1 = ship_hull_y2;
					exp_live = 1'b1;
				end
				ship_alive = 1'b0;
				ship_hull_x1 = 0;
				ship_hull_x2 = 0;
				ship_hull_y1 = 0;
				ship_hull_y2 = 0;
				ship_red = 10'h000;
				ship_green = 10'h000;
				ship_blue = 10'h000;
				en_shot23 = 0;
			end else if (en_shot23_y1 == 480) begin
					en_shot23 = 1'b0;
			end else begin
				if(shottest >= 1250000/16) begin
					en_shot23_y1 = en_shot23_y1 + 1;
					en_shot23_y2 = en_shot23_y2 + 1;
					shottest = 0;
				end
			end
		end
		if ( ((VGA_X >= en_shot24_x1) && (VGA_X <= en_shot24_x2) && (VGA_Y >= en_shot24_y1) && (VGA_Y <= en_shot24_y2)) && (en_shot24) ) begin
			mRed = 10'hFFF;
			mGreen = 10'hFFF;
			mBlue = 10'hFFF;
			if ((en_shot24_y1 >= ship_hull_y1) && (en_shot24_y2 <= ship_hull_y2) && (en_shot24_x1 >= ship_hull_x1) && (en_shot24_x2 <= ship_hull_x2)) begin // 
				if (!exp_live) begin
					exp_x1 = ship_hull_x1 + ((ship_hull_x2 - ship_hull_x1)/2);
					exp_y1 = ship_hull_y2;
					exp_live = 1'b1;
				end
				ship_alive = 1'b0;
				ship_hull_x1 = 0;
				ship_hull_x2 = 0;
				ship_hull_y1 = 0;
				ship_hull_y2 = 0;
				ship_red = 10'h000;
				ship_green = 10'h000;
				ship_blue = 10'h000;
				en_shot24 = 0;
			end else if (en_shot24_y1 == 480) begin
					en_shot24 = 1'b0;
			end else begin
				if(shottest >= 1250000/16) begin
					en_shot24_y1 = en_shot24_y1 + 1;
					en_shot24_y2 = en_shot24_y2 + 1;
					shottest = 0;
				end
			end
		end		
		//MAKES ENEMIES SHOOT. DO NOT DELETE SHOTTEST
		shottest = shottest + 4;
		
		
		//Draw Enemy Shot//
		if ( en_shot && (VGA_X >= en_shot_x1) && (VGA_X <= en_shot_x2) && (VGA_Y <= en_shot_y2) && (VGA_Y >= en_shot_y1)	) begin
			mRed = 10'hFFF;
			mGreen = 10'hFFF;
			mBlue = 10'hFFF;
		end
		
		///Draw Enemy///
		if ( (VGA_X <= en_hull_x2) && (VGA_X >= en_hull_x1) && (VGA_Y <= en_hull_y2) && (VGA_Y >= en_hull_y1) && (alive) ) begin
			mRed = en_red;
			mGreen = en_green;
			mBlue = en_blue;
		end
		///Draw Enemy 2///
		if ( (VGA_X <= en_hull2_x2) && (VGA_X >= en_hull2_x1) && (VGA_Y <= en_hull2_y2) && (VGA_Y >= en_hull2_y1) && (alive2) ) begin
			mRed = en2_red;
			mGreen = en2_green;
			mBlue = en2_blue;
		end
		///Draw Enemy 3///
		if ( (VGA_X <= en_hull3_x2) && (VGA_X >= en_hull3_x1) && (VGA_Y <= en_hull3_y2) && (VGA_Y >= en_hull3_y1) && (alive3) ) begin
			mRed = en3_red;
			mGreen = en3_green;
			mBlue = en3_blue;
		end
		///Draw Enemy 4///
		if ( (VGA_X <= en_hull4_x2) && (VGA_X >= en_hull4_x1) && (VGA_Y <= en_hull4_y2) && (VGA_Y >= en_hull4_y1) && (alive4) ) begin
			mRed = en4_red;
			mGreen = en4_green;
			mBlue = en4_blue;
		end
		///Draw Enemy 5///
		if ( (VGA_X <= en_hull5_x2) && (VGA_X >= en_hull5_x1) && (VGA_Y <= en_hull5_y2) && (VGA_Y >= en_hull5_y1) && (alive5) ) begin
			mRed = en5_red;
			mGreen = en5_green;
			mBlue = en5_blue;
		end
		///Draw Enemy 6///
		if ( (VGA_X <= en_hull6_x2) && (VGA_X >= en_hull6_x1) && (VGA_Y <= en_hull6_y2) && (VGA_Y >= en_hull6_y1) && (alive6) ) begin
			mRed = en6_red;
			mGreen = en6_green;
			mBlue = en6_blue;
		end
		///Draw Enemy 7///
		if ( (VGA_X <= en_hull7_x2) && (VGA_X >= en_hull7_x1) && (VGA_Y <= en_hull7_y2) && (VGA_Y >= en_hull7_y1) && (alive7) ) begin
			mRed = en7_red;
			mGreen = en7_green;
			mBlue = en7_blue;
		end
		///Draw Enemy 8///
		if ( (VGA_X <= en_hull8_x2) && (VGA_X >= en_hull8_x1) && (VGA_Y <= en_hull8_y2) && (VGA_Y >= en_hull8_y1) && (alive8) ) begin
			mRed = en8_red;
			mGreen = en8_green;
			mBlue = en8_blue;
		end
		///Draw Enemy 9///
		if ( (VGA_X <= en_hull9_x2) && (VGA_X >= en_hull9_x1) && (VGA_Y <= en_hull9_y2) && (VGA_Y >= en_hull9_y1) && (alive9) ) begin
			mRed = en9_red;
			mGreen = en9_green;
			mBlue = en9_blue;
		end
		///Draw Enemy 10///
		if ( (VGA_X <= en_hull10_x2) && (VGA_X >= en_hull10_x1) && (VGA_Y <= en_hull10_y2) && (VGA_Y >= en_hull10_y1) && (alive10) ) begin
			mRed = en10_red;
			mGreen = en10_green;
			mBlue = en10_blue;
		end
		///Draw Enemy 11///
		if ( (VGA_X <= en_hull11_x2) && (VGA_X >= en_hull11_x1) && (VGA_Y <= en_hull11_y2) && (VGA_Y >= en_hull11_y1) && (alive11) ) begin
			mRed = en11_red;
			mGreen = en11_green;
			mBlue = en11_blue;
		end
		///Draw Enemy 12///
		if ( (VGA_X <= en_hull12_x2) && (VGA_X >= en_hull12_x1) && (VGA_Y <= en_hull12_y2) && (VGA_Y >= en_hull12_y1) && (alive12) ) begin
			mRed = en12_red;
			mGreen = en12_green;
			mBlue = en12_blue;
		end
		///Draw Enemy 13///
		if ( (VGA_X <= en_hull13_x2) && (VGA_X >= en_hull13_x1) && (VGA_Y <= en_hull13_y2) && (VGA_Y >= en_hull13_y1) && (alive13) ) begin
			mRed = en13_red;
			mGreen = en13_green;
			mBlue = en13_blue;
		end
		///Draw Enemy 14///
		if ( (VGA_X <= en_hull14_x2) && (VGA_X >= en_hull14_x1) && (VGA_Y <= en_hull14_y2) && (VGA_Y >= en_hull14_y1) && (alive14) ) begin
			mRed = en14_red;
			mGreen = en14_green;
			mBlue = en14_blue;
		end
		///Draw Enemy 15///
		if ( (VGA_X <= en_hull15_x2) && (VGA_X >= en_hull15_x1) && (VGA_Y <= en_hull15_y2) && (VGA_Y >= en_hull15_y1) && (alive15) ) begin
			mRed = en15_red;
			mGreen = en15_green;
			mBlue = en15_blue;
		end
		///Draw Enemy 16///
		if ( (VGA_X <= en_hull16_x2) && (VGA_X >= en_hull16_x1) && (VGA_Y <= en_hull16_y2) && (VGA_Y >= en_hull16_y1) && (alive16) ) begin
			mRed = en16_red;
			mGreen = en16_green;
			mBlue = en16_blue;
		end
		///Draw Enemy 17///
		if ( (VGA_X <= en_hull17_x2) && (VGA_X >= en_hull17_x1) && (VGA_Y <= en_hull17_y2) && (VGA_Y >= en_hull17_y1) && (alive17) ) begin
			mRed = en17_red;
			mGreen = en17_green;
			mBlue = en17_blue;
		end
		///Draw Enemy 18///
		if ( (VGA_X <= en_hull18_x2) && (VGA_X >= en_hull18_x1) && (VGA_Y <= en_hull18_y2) && (VGA_Y >= en_hull18_y1) && (alive18) ) begin
			mRed = en18_red;
			mGreen = en18_green;
			mBlue = en18_blue;
		end
		///Draw Enemy 19///
		if ( (VGA_X <= en_hull19_x2) && (VGA_X >= en_hull19_x1) && (VGA_Y <= en_hull19_y2) && (VGA_Y >= en_hull19_y1) && (alive19) ) begin
			mRed = en19_red;
			mGreen = en19_green;
			mBlue = en19_blue;
		end
		///Draw Enemy 20///
		if ( (VGA_X <= en_hull20_x2) && (VGA_X >= en_hull20_x1) && (VGA_Y <= en_hull20_y2) && (VGA_Y >= en_hull20_y1) && (alive20) ) begin
			mRed = en20_red;
			mGreen = en20_green;
			mBlue = en20_blue;
		end
		///Draw Enemy 21///
		if ( (VGA_X <= en_hull21_x2) && (VGA_X >= en_hull21_x1) && (VGA_Y <= en_hull21_y2) && (VGA_Y >= en_hull21_y1) && (alive21) ) begin
			mRed = en21_red;
			mGreen = en21_green;
			mBlue = en21_blue;
		end
		///Draw Enemy 22///
		if ( (VGA_X <= en_hull22_x2) && (VGA_X >= en_hull22_x1) && (VGA_Y <= en_hull22_y2) && (VGA_Y >= en_hull22_y1) && (alive22) ) begin
			mRed = en22_red;
			mGreen = en22_green;
			mBlue = en22_blue;
		end
		///Draw Enemy 23///
		if ( (VGA_X <= en_hull23_x2) && (VGA_X >= en_hull23_x1) && (VGA_Y <= en_hull23_y2) && (VGA_Y >= en_hull23_y1) && (alive23) ) begin
			mRed = en23_red;
			mGreen = en23_green;
			mBlue = en23_blue;
		end
		///Draw Enemy 24///
		if ( (VGA_X <= en_hull24_x2) && (VGA_X >= en_hull24_x1) && (VGA_Y <= en_hull24_y2) && (VGA_Y >= en_hull24_y1) && (alive24) ) begin
			mRed = en24_red;
			mGreen = en24_green;
			mBlue = en24_blue;
		end
	
		
		
		//Explosion//
		if ( (exp_live) && ((VGA_X - (exp_x1))**2 + (VGA_Y - exp_y1)**2 <= exp_radius)) begin //remember to add the variables used here up above, there is going to need to be either a max radius bound or a max x and y bound
			mRed = exp_red;
			mGreen = exp_green;
			mBlue = exp_blue;
			if (exp_radius >= 1000) begin
				exp_radius = 0;
				exp_live = 1'b0;
			end
		end
		
		///GAME OVER SCREEN///
		//Check if ship is alive, if not set ship stuff to 0 and and bring up this screen
		if ( !ship_alive ) begin
			//Y
			if (	(VGA_X >= 264) && (VGA_X <= 280) && (VGA_Y >= 0) && (VGA_Y <= 120) ) begin		//Top left post
				mRed = 10'hFFF;
				mGreen = 10'hFFF;
				mBlue = 10'hFFF;
			end
			if ( (VGA_X >= 295) && (VGA_X <= 311) && (VGA_Y >= 0) && (VGA_Y <= 120) ) begin		//Top right post
				mRed = 10'hFFF;
				mGreen = 10'hFFF;
				mBlue = 10'hFFF;
			end
			if ( (VGA_X >= 264) && (VGA_X <= 311) && (VGA_Y >= 90) && (VGA_Y <= 120)	) begin	//Crossbar
				mRed = 10'hFFF;
				mGreen = 10'hFFF;
				mBlue = 10'hFFF;
			end
			if ( (VGA_X >= 280) && (VGA_X <= 296) && (VGA_Y >= 90) && (VGA_Y <= 240) ) begin		//Middle Post
				mRed = 10'hFFF;
				mGreen = 10'hFFF;
				mBlue = 10'hFFF;
			end
			//O
			if ( (VGA_X >= 328) && (VGA_X <= 375) && (VGA_Y >= 0) && (VGA_Y <= 24) ) begin			//Top
				mRed = 10'hFFF;
				mGreen = 10'hFFF;
				mBlue = 10'hFFF;
			end 
			if ( (VGA_X >= 328) && (VGA_X <= 344) && (VGA_Y >= 0) && (VGA_Y <= 240)	) begin			//Left Side
				mRed = 10'hFFF;
				mGreen = 10'hFFF;
				mBlue = 10'hFFF;
			end
			if ( (VGA_X >= 359) && (VGA_X <= 375) && (VGA_Y >= 0) && (VGA_Y <= 240)	) begin			//Right Side
				mRed = 10'hFFF;
				mGreen = 10'hFFF;
				mBlue = 10'hFFF;
			end
			if ( (VGA_X >= 328) && (VGA_X <= 375) && (VGA_Y >= 216) && (VGA_Y <= 240) ) begin		//Bottom
				mRed = 10'hFFF;
				mGreen = 10'hFFF;
				mBlue = 10'hFFF;	
			end
			//U
			if ( (VGA_X >= 392) && (VGA_X <= 408) && (VGA_Y >= 0) && (VGA_Y <= 240)	) begin		//Left Side
				mRed = 10'hFFF;
				mGreen = 10'hFFF;
				mBlue = 10'hFFF;
			end
			if ( (VGA_X >= 423) && (VGA_X <= 439) && (VGA_Y >= 0) && (VGA_Y <= 240)	) begin	//Right Side
				mRed = 10'hFFF;
				mGreen = 10'hFFF;
				mBlue = 10'hFFF;
			end
			if ( (VGA_X >= 392) && (VGA_X <= 423) && (VGA_Y >= 216) && (VGA_Y <= 240)	) begin	//Bottom
				mRed = 10'hFFF;
				mGreen = 10'hFFF;
				mBlue = 10'hFFF;	
			end
			//D
			if ( (VGA_X >= 256) && (VGA_X <= 304) && (VGA_Y >= 240) && (VGA_Y <= 264) ) begin
				mRed = 10'hFFF;
				mGreen = 10'hFFF;
				mBlue = 10'hFFF;
			end
			if ( (VGA_X >= 256) && (VGA_X <= 304) && (VGA_Y >= 456) && (VGA_Y <= 480) ) begin
				mRed = 10'hFFF;
				mGreen = 10'hFFF;
				mBlue = 10'hFFF;
			end
			if ( (VGA_X >= 256) && (VGA_X <= 278) && (VGA_Y >= 240) && (VGA_Y <= 480) ) begin
				mRed = 10'hFFF;
				mGreen = 10'hFFF;
				mBlue = 10'hFFF;
			end
			if ( (VGA_X >= 295) && (VGA_X <= 319) && (VGA_Y >= 264) && (VGA_Y <= 456) ) begin
				mRed = 10'hFFF;
				mGreen = 10'hFFF;
				mBlue = 10'hFFF;	
			end
			//I
			if ( (VGA_X >= 320) && (VGA_X <= 383) && (VGA_Y >= 240) && (VGA_Y <= 264) ) begin			//Top
				mRed = 10'hFFF;
				mGreen = 10'hFFF;
				mBlue = 10'hFFF;
			end
			if ( (VGA_X >= 344) && (VGA_X <= 358) && (VGA_Y >= 240) && (VGA_Y <= 480) ) begin			//Bottom
				mRed = 10'hFFF;
				mGreen = 10'hFFF;
				mBlue = 10'hFFF;
			end
			if ( (VGA_X >= 320) && (VGA_X <= 383) && (VGA_Y >= 456) && (VGA_Y <= 480) ) begin	//Middle Post
				mRed = 10'hFFF;
				mGreen = 10'hFFF;
				mBlue = 10'hFFF;
			end
			//E
			if ( (VGA_X >= 384) && (VGA_X <= 447) && (VGA_Y >= 240) && (VGA_Y <= 264) ) begin			//Top Bar
				mRed = 10'hFFF;
				mGreen = 10'hFFF;
				mBlue = 10'hFFF;
			end
			if ( (VGA_X >= 384) && (VGA_X <= 436) && (VGA_Y >= 348) && (VGA_Y <= 372) ) begin			//Middle Bar
				mRed = 10'hFFF;
				mGreen = 10'hFFF;
				mBlue = 10'hFFF;
			end
			if ( (VGA_X >= 384) && (VGA_X <= 447) && (VGA_Y >= 456) && (VGA_Y <= 480) ) begin			//Bottom Bar
				mRed = 10'hFFF;
				mGreen = 10'hFFF;
				mBlue = 10'hFFF;
			end
			if ( (VGA_X >= 384) && (VGA_X <= 408) && (VGA_Y >= 240) && (VGA_X <= 480) ) begin	//Left Post
				mRed = 10'hFFF;
				mGreen = 10'hFFF;
				mBlue = 10'hFFF;	
			end
			//D
			if (	(VGA_X >= 448) && (VGA_X <= 472) && (VGA_Y >= 240) && (VGA_Y <= 480)	) begin
				mRed = 10'hFFF;
				mGreen = 10'hFFF;
				mBlue = 10'hFFF;
			end
			if ( (VGA_X >= 472) && (VGA_X <= 488) && (VGA_Y >= 240) && (VGA_Y <= 264) ) begin
				mRed = 10'hFFF;
				mGreen = 10'hFFF;
				mBlue = 10'hFFF;
			end
			if ( (VGA_X >= 472) && (VGA_X <= 488) && (VGA_Y >= 456) && (VGA_Y <= 480) ) begin
				mRed = 10'hFFF;
				mGreen = 10'hFFF;
				mBlue = 10'hFFF;
			end
			if ( (VGA_X >= 487) && (VGA_X <= 511) && (VGA_Y >= 264) && (VGA_Y <= 456) ) begin
				mRed = 10'hFFF;
				mGreen = 10'hFFF;
				mBlue = 10'hFFF;
			end
		end
		
		///YOU WIN SCREEN///
		//Check if all enemies are dead then bring up this screen
		if ( 	!alive && !alive2 && !alive3 && !alive4 && !alive5 && !alive6 && !alive7 && !alive8 && 
				!alive9 && !alive10 && !alive11 && !alive12 && !alive13 && !alive14 && !alive15 && !alive16 && 
				!alive17 && !alive18 && !alive19 && !alive20 && !alive21 && !alive22 && !alive23 && !alive24 ) begin
			//Y
			if (	(VGA_X >= 264) && (VGA_X <= 280) && (VGA_Y >= 0) && (VGA_Y <= 120) ) begin		//Top left post
				mRed = 10'hFFF;
				mGreen = 10'hFFF;
				mBlue = 10'hFFF;
			end
			if ( (VGA_X >= 295) && (VGA_X <= 311) && (VGA_Y >= 0) && (VGA_Y <= 120) ) begin		//Top right post
				mRed = 10'hFFF;
				mGreen = 10'hFFF;
				mBlue = 10'hFFF;
			end
			if ( (VGA_X >= 264) && (VGA_X <= 311) && (VGA_Y >= 90) && (VGA_Y <= 120)	) begin	//Crossbar
				mRed = 10'hFFF;
				mGreen = 10'hFFF;
				mBlue = 10'hFFF;
			end
			if ( (VGA_X >= 280) && (VGA_X <= 296) && (VGA_Y >= 90) && (VGA_Y <= 240) ) begin		//Middle Post
				mRed = 10'hFFF;
				mGreen = 10'hFFF;
				mBlue = 10'hFFF;
			end
			//O
			if ( (VGA_X >= 328) && (VGA_X <= 375) && (VGA_Y >= 0) && (VGA_Y <= 24) ) begin			//Top
				mRed = 10'hFFF;
				mGreen = 10'hFFF;
				mBlue = 10'hFFF;
			end 
			if ( (VGA_X >= 328) && (VGA_X <= 344) && (VGA_Y >= 0) && (VGA_Y <= 240)	) begin			//Left Side
				mRed = 10'hFFF;
				mGreen = 10'hFFF;
				mBlue = 10'hFFF;
			end
			if ( (VGA_X >= 359) && (VGA_X <= 375) && (VGA_Y >= 0) && (VGA_Y <= 240)	) begin			//Right Side
				mRed = 10'hFFF;
				mGreen = 10'hFFF;
				mBlue = 10'hFFF;
			end
			if ( (VGA_X >= 328) && (VGA_X <= 375) && (VGA_Y >= 216) && (VGA_Y <= 240) ) begin		//Bottom
				mRed = 10'hFFF;
				mGreen = 10'hFFF;
				mBlue = 10'hFFF;	
			end
			//U
			if ( (VGA_X >= 392) && (VGA_X <= 408) && (VGA_Y >= 0) && (VGA_Y <= 240)	) begin		//Left Side
				mRed = 10'hFFF;
				mGreen = 10'hFFF;
				mBlue = 10'hFFF;
			end
			if ( (VGA_X >= 423) && (VGA_X <= 439) && (VGA_Y >= 0) && (VGA_Y <= 240)	) begin	//Right Side
				mRed = 10'hFFF;
				mGreen = 10'hFFF;
				mBlue = 10'hFFF;
			end
			if ( (VGA_X >= 392) && (VGA_X <= 423) && (VGA_Y >= 216) && (VGA_Y <= 240)	) begin	//Bottom
				mRed = 10'hFFF;
				mGreen = 10'hFFF;
				mBlue = 10'hFFF;	
			end
			//W
			if ( (VGA_X >= 256) && (VGA_X <= 264) && (VGA_Y >= 240) && (VGA_Y <= 480) ) begin		//Left Post
				mRed = 10'hFFF;
				mGreen = 10'hFFF;
				mBlue = 10'hFFF;
			end
			if ( (VGA_X >= 311) && (VGA_X <= 319) && (VGA_Y >= 240) && (VGA_Y <= 480) ) begin			//Right Post
				mRed = 10'hFFF;
				mGreen = 10'hFFF;
				mBlue = 10'hFFF;
			end
			if ( (VGA_X >= 280) && (VGA_X <= 296) && (VGA_Y >= 360) && (VGA_Y <= 480) ) begin			//Middle Post
				mRed = 10'hFFF;
				mGreen = 10'hFFF;
				mBlue = 10'hFFF;
			end
			if ( (VGA_X >= 256) && (VGA_X <= 319) && (VGA_Y >= 456) && (VGA_Y <= 480)	) begin	//Bottom
				mRed = 10'hFFF;
				mGreen = 10'hFFF;
				mBlue = 10'hFFF;	
			end
			//I
			if ( (VGA_X >= 328) && (VGA_X <= 375) && (VGA_Y >= 240) && (VGA_Y <= 264) ) begin			//Top
				mRed = 10'hFFF;
				mGreen = 10'hFFF;
				mBlue = 10'hFFF;
			end
			if ( (VGA_X >= 346) && (VGA_X <= 355) && (VGA_Y >= 240) && (VGA_Y <= 480) ) begin			//Bottom
				mRed = 10'hFFF;
				mGreen = 10'hFFF;
				mBlue = 10'hFFF;
			end
			if ( (VGA_X >= 328) && (VGA_X <= 375) && (VGA_Y >= 456) && (VGA_Y <= 480) ) begin	//Middle Post
				mRed = 10'hFFF;
				mGreen = 10'hFFF;
				mBlue = 10'hFFF;
			end
			//N
			if ( (VGA_X >= 384) && (VGA_X <= 400) && (VGA_Y >= 240) && (VGA_Y <= 480) ) begin			//Left Post
				mRed = 10'hFFF;
				mGreen = 10'hFFF;
				mBlue = 10'hFFF;
			end
			if ( (VGA_X >= 424) && (VGA_X <= 436) &&  (VGA_Y >= 420) && (VGA_Y <= 480) ) begin
				mRed = 10'hFFF;
				mGreen = 10'hFFF;
				mBlue = 10'hFFF;
			end
			if ( (VGA_X >= 416) && (VGA_X <= 424) && (VGA_Y >= 360) && (VGA_Y <= 420) ) begin			//Middle Left Post
				mRed = 10'hFFF;
				mGreen = 10'hFFF;
				mBlue = 10'hFFF;
			end
			if ( (VGA_X >= 408) && (VGA_X <= 416) && (VGA_Y >= 300) && (VGA_Y <= 360) ) begin		//Middle Right Post
				mRed = 10'hFFF;
				mGreen = 10'hFFF;
				mBlue = 10'hFFF;
			end
			if ( (VGA_X >= 400) && (VGA_X <= 408) && (VGA_Y >= 240) && (VGA_Y <= 300) ) begin
				mRed = 10'hFFF;
				mGreen = 10'hFFF;
				mBlue = 10'hFFF;
			end
			if ( (VGA_X >= 434) && (VGA_X <= 447) && (VGA_Y >= 240) && (VGA_Y <= 480) ) begin			//Right Post
				mRed = 10'hFFF;
				mGreen = 10'hFFF;
				mBlue = 10'hFFF;
			end
		end
	end
	
	Lab4 music(.signalout(musicOut), .clk(clk));
	
	
	VGA_Ctrl			u9	(	//	Host Side
							.iRed(mRed),
							.iGreen(mGreen),
							.iBlue(mBlue),
							.oCurrent_X(VGA_X),
							.oCurrent_Y(VGA_Y),
							.oRequest(VGA_Read),
							//	VGA Side
							.oVGA_R(vga_r10 ),
							.oVGA_G(vga_g10 ),
							.oVGA_B(vga_b10 ),
							.oVGA_HS(VGA_HS),
							.oVGA_VS(VGA_VS),
							.oVGA_SYNC(VGA_SYNC_N),
							.oVGA_BLANK(VGA_BLANK_N),
							.oVGA_CLOCK(VGA_CLK),
							//	Control Signal
							.iCLK(clk25),
							.iRST_N(1)	);
endmodule

module	VGA_Ctrl	(	//	Host Side
						iRed,
						iGreen,
						iBlue,
						oCurrent_X,
						oCurrent_Y,
						oAddress,
						oRequest,
						//	VGA Side
						oVGA_R,
						oVGA_G,
						oVGA_B,
						oVGA_HS,
						oVGA_VS,
						oVGA_SYNC,
						oVGA_BLANK,
						oVGA_CLOCK,
						//	Control Signal
						iCLK,
						iRST_N	);
	//	Host Side
	input		[9:0]	iRed;
	input		[9:0]	iGreen;
	input		[9:0]	iBlue;
	output		[21:0]	oAddress;
	output		[10:0]	oCurrent_X;
	output		[10:0]	oCurrent_Y;
	output				oRequest;
	//	VGA Side
	output		[9:0]	oVGA_R;
	output		[9:0]	oVGA_G;
	output		[9:0]	oVGA_B;
	output	reg			oVGA_HS;
	output	reg			oVGA_VS;
	output				oVGA_SYNC;
	output				oVGA_BLANK;
	output				oVGA_CLOCK;
	//	Control Signal
	input				iCLK;
	input				iRST_N;	
	//	Internal Registers
	reg			[10:0]	H_Cont;
	reg			[10:0]	V_Cont;
	////////////////////////////////////////////////////////////
	//	Horizontal	Parameter
	parameter	H_FRONT	=	16;
	parameter	H_SYNC	=	96;
	parameter	H_BACK	=	48;
	parameter	H_ACT	=	640;
	parameter	H_BLANK	=	H_FRONT+H_SYNC+H_BACK;
	parameter	H_TOTAL	=	H_FRONT+H_SYNC+H_BACK+H_ACT;
	////////////////////////////////////////////////////////////
	//	Vertical Parameter
	parameter	V_FRONT	=	11;
	parameter	V_SYNC	=	2;
	parameter	V_BACK	=	31;
	parameter	V_ACT	=	480;
	parameter	V_BLANK	=	V_FRONT+V_SYNC+V_BACK;
	parameter	V_TOTAL	=	V_FRONT+V_SYNC+V_BACK+V_ACT;
	////////////////////////////////////////////////////////////
	assign	oVGA_SYNC	=	1'b1;			//	This pin is unused.
	assign	oVGA_BLANK	=	~((H_Cont<H_BLANK)||(V_Cont<V_BLANK));
	assign	oVGA_CLOCK	=	~iCLK;
	assign	oVGA_R		=	iRed;
	assign	oVGA_G		=	iGreen;
	assign	oVGA_B		=	iBlue;
	assign	oAddress	=	oCurrent_Y*H_ACT+oCurrent_X;
	assign	oRequest	=	((H_Cont>=H_BLANK && H_Cont<H_TOTAL)	&&
							 (V_Cont>=V_BLANK && V_Cont<V_TOTAL));
	assign	oCurrent_X	=	(H_Cont>=H_BLANK)	?	H_Cont-H_BLANK	:	11'h0	;
	assign	oCurrent_Y	=	(V_Cont>=V_BLANK)	?	V_Cont-V_BLANK	:	11'h0	;

	//	Horizontal Generator: Refer to the pixel clock
	always@(posedge iCLK or negedge iRST_N)
	begin
		if(!iRST_N)
		begin
			H_Cont		<=	0;
			oVGA_HS		<=	1;
		end
		else
		begin
			if(H_Cont<H_TOTAL)
			H_Cont	<=	H_Cont+1'b1;
			else
			H_Cont	<=	0;
			//	Horizontal Sync
			if(H_Cont==H_FRONT-1)			//	Front porch end
			oVGA_HS	<=	1'b0;
			if(H_Cont==H_FRONT+H_SYNC-1)	//	Sync pulse end
			oVGA_HS	<=	1'b1;
		end
	end

	//	Vertical Generator: Refer to the horizontal sync
	always@(posedge oVGA_HS or negedge iRST_N)
	begin
		if(!iRST_N)
		begin
			V_Cont		<=	0;
			oVGA_VS		<=	1;
		end
		else
		begin
			if(V_Cont<V_TOTAL)
			V_Cont	<=	V_Cont+1'b1;
			else
			V_Cont	<=	0;
			//	Vertical Sync
			if(V_Cont==V_FRONT-1)			//	Front porch end
			oVGA_VS	<=	1'b0;
			if(V_Cont==V_FRONT+V_SYNC-1)	//	Sync pulse end
			oVGA_VS	<=	1'b1;
		end
	end

endmodule


module Lab4(signalout, clk);
	input clk;
	//input [1:0] sw;
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
