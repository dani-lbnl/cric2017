/*
 * Lecture UFOP Biotecnology Graduate Program
 * Nov 3rd 2017
 * Dani Ushizima - dani.ushizima@gmail.com
 * 
 * Show a few segmentation strategies
 */

//Close all the windows
run("Close All");
path = "/Users/dani/Dropbox/MANAGEMENT/CRIC/CRIC2017/UFOP/cursoDoutoradoBiotecnologia/code/";

//1. Substract background - use the Fiji tool
open(path + "2806 14 2.tif");
run("Subtract Background...", "rolling=50 light");
rename("image1");

//2. Subtract background - constructing a method
vsize = 50;
open("/Users/dani/Dropbox/MANAGEMENT/CRIC/CRIC2017/git/cric2017/UFOP/images/ambar/2806 14 2.tif");
rename("orig");
run("Duplicate...", "title=background"); 
run("Maximum...", "radius="+vsize); 
run("Minimum...", "radius="+vsize); 
run("Gaussian Blur...", "sigma="+vsize); 
run("Subtract...", "value=207"); 
imageCalculator("Subtract", "orig", "background"); 
selectWindow("background");
close();
rename("image2");

//3. Find threshold using Sauvola & Pietaksinen on color images
selectWindow("image1");
run("Duplicate...", "title=image1a");

k = getNumber("Please enter k", 0.5);
R = getNumber("Please enter R", 128); 
getRawStatistics(nP, mean, min, max, std); 
T = mean*(1+k*(std/R-1));
setThreshold(0, T);  //setThreshold(low, high) sets the thresholds.
run("Convert to Mask"); //binarizes the image according to the thresholds set.
imageCalculator("AND create", "image1","image1a");
selectWindow("image1a");
close();

//4. Find threshold using the color threshold tool
//run("Color Threshold...");
run("Tile");

go = getNumber("Keep going? (0/no or 1/yes)", 0);
if(go == 0)
	exit;

//5. Computer generated code improved by cytologist
selectWindow("image1");
run("Duplicate...", "title=image1b");
min=newArray(3);
max=newArray(3);
filter=newArray(3);
a=getTitle();
run("RGB Stack");
run("Convert Stack to Images");
selectWindow("Red");
rename("0");
selectWindow("Green");
rename("1");
selectWindow("Blue");
rename("2");
for (i=0;i<3;i++){
  selectWindow(""+i);
  run("Convert to Mask", "method=Otsu background=Dark calculate black");
  run("Remove Outliers...", "radius=3 threshold=50 which=Bright stack");
  run("Fill Holes");
}
imageCalculator("OR create", "0","1");
imageCalculator("OR create", "Result of 0","2");
for (i=0;i<3;i++){
  selectWindow(""+i);
  close();
}
selectWindow("Result of 0");
close();
selectWindow("Result of Result of 0");
rename(a);
imageCalculator("AND create", "image1",a);
selectWindow("image1b");
close();
run("Tile");
// Colour Thresholding-------------