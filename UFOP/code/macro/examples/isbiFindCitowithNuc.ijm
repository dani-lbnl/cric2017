/*run("Calculator Plus", "i1=cito i2=Nuc operation=[Subtract: i2 = (i1-i2) x k1 + k2] k1=1 k2=0 create");
close();
selectWindow("cito");
imageCalculator("AND create", "cito","cito");
selectWindow("Result of cito");
*/
imageCalculator("AND create", "cito","Nuc");
selectWindow("Result of cito");
getStatistics(area, mean, min, max);
if (area > 100)
	print("Tem nucleo");


imageCalculator("AND create", "Nuc","cito");
	