/*  
 * Lecture UFOP Biotecnology Graduate Program
 * Nov 3rd 2017
 * Dani Ushizima - dani.ushizima@gmail.com

 Algorithm:	
	Extract features
 */

//Close all the windows
run("Close All");

path = "/Users/dani/Dropbox/MANAGEMENT/CRIC/CRIC2017/UFOP/cursoDoutoradoBiotecnologia/code/";

//1. Crop and resize
open(path + "2806 14 2.tif");
rename("orig");
//change image properties so that metrics will be given in pixel units as opposed to inches or any other unit in the metadata
run("Properties...", "channels=1 slices=1 frames=1 unit=pixel pixel_width=1 pixel_height=1 voxel_depth=1.0000000"); 

makeRectangle(835, 402, 232, 253);

run("Duplicate...", "title=atypical");
selectWindow("orig");
close();

//2. Color, grayscale and LUT
run("Duplicate...", "title=atypical_gray");
run("8-bit");

//3. Statistical region merging
run("Enhance Local Contrast (CLAHE)", "blocksize=127 histogram=256 maximum=3 mask=*None* fast_(less_accurate)");
run("Statistical Region Merging", "q=3 showaverages");

//4. Split phases
run("8-bit");
/*
nonZero=0;
getHistogram(values,counts,256);
for(i=0; i<255; i++)
	if (counts[i] != 0){
		print(values[i]);
		nonZero++;
	}
*/

setOption("BlackBackground", true);
setThreshold(0,115);
run("Convert to Mask");
rename("mask");

//Measurements
run("Set Measurements...", "area mean standard modal min perimeter integrated median skewness kurtosis stack redirect="+"atypical_gray"+" decimal=3");
run("Analyze Particles...", "size="+100+"-Infinity pixel show=Outlines display clear include");

//Overlay
selectWindow("atypical");
run("Duplicate...", "title=atypical_nuclei");
//wait(100);
run("Add Image...", "image=[Drawing of mask] x=0 y=0 opacity=30 zero");	 
run("Tile");
saveAs("Results", path+"quantMic_results.csv");
