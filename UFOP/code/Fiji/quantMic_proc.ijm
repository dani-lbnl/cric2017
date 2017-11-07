/*  
 * Lecture UFOP Biotecnology Graduate Program
 * Nov 3rd 2017
 * Dani Ushizima - dani.ushizima@gmail.com

 Algorithm:	
	Crop and resize
	Color, grayscale and LUT
	Enhancement for what? Smooth vs. crispy
	Border detection
	Create an animated gif
 */

//Close all the windows
run("Close All");

path = "/Users/dani/Dropbox/MANAGEMENT/CRIC/CRIC2017/UFOP/cursoDoutoradoBiotecnologia/code/";

//1. Crop and resize
open(path + "2806 14 2.tif");
rename("orig");
makeRectangle(835, 402, 232, 253);
run("Duplicate...", "title=atypical");

//2. Color, grayscale and LUT
run("Duplicate...", "title=atypical_gray");
run("8-bit");

//3.Enhancement for what? Smooth vs. crispy
selectWindow("atypical_gray");
run("Duplicate...", "title=atypical_smooth");
run("Smooth");

selectWindow("orig");
run("Duplicate...", "title=atypical_crispy");
run("Enhance Contrast", "saturated=0.35");

//4.Threshold
selectWindow("atypical_smooth");
run("Duplicate...", "title=atypical_threshold");
setThreshold(0,140);
run("Convert to Mask", " black");

//5.Border detection
run("Duplicate...", "title=atypical_border");
run("Find Edges");

//6.Create an animated gif
selectWindow("orig");
close();
run("Images to Stack", "name=Stack title=[] use");
run("Animated Gif ... ", "name=Stack set_global_lookup_table_options=[Do not use] optional=[] image=[No Disposal] set=450 number=0 transparency=[No Transparency] red=0 green=0 blue=0 index=0 filename="+path+"quantMic_proc.gif");

//7.Create a montage
run("Make Montage...", "columns=3 rows=2 scale=1 first=1 last=6 increment=1 border=0 font=20 label use");

