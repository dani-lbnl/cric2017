# Plot the measuruments extract from Fiji

filepath = "/Users/dani/Dropbox/MANAGEMENT/CRIC/CRIC2017/UFOP/cursoDoutoradoBiotecnologia/code/quantMic_results.csv";
outputdir = "/Users/dani/Dropbox/MANAGEMENT/CRIC/CRIC2017/UFOP/cursoDoutoradoBiotecnologia/code/"
d=read.csv(filepath,sep=",",head=T);


plot(x=d$Area, y=d$Mean,col='red',pch=20,xlab="area",ylab="perim",main='Cell measuruments')

dnew = d[,2:12]
plot(dnew,col='blue',pch=20)

#----Clustering
km=kmeans(dnew,iter.max=100,2,algorithm='L');

png(filename=paste(outputdir,"figInR.png",sep=''),width = 600, height=600, units = "px", pointsize = 20,bg = "white"); 
plot(d$Area,d$Mean, col=km$cluster,xlab = "Area", ylab = "Mean Intensity", main = "Cell clustering",pch=km$cluster+19)
legend('bottomright', legend=c("class1","class2"), col=c(1,2), pch=c(20,21), title="kmeans")
dev.off()
  

