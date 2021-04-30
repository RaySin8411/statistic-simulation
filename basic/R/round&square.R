x = seq(-1, 1, 0.01)
y = seq(-1, 1, 0.01)
z1=rep(-1,length(y))
z2=rep(1,length(x))

#square
plot(x,y, xlim = c(-1,1), ylim=c(-1,1), axes=F,type='n', asp = 1,ylab='',xlab='')
lines(x,z1)
lines(x,z2)
lines(z1,y)
lines(z2,y)
points(x = 0, y = 0, pch = 19,col = "darkgreen")
text(-1.2,1,labels=c("(-1,1)"))
text(-1.2,-1,labels=c("(-1,-1)"))
text(1.2,-1,labels=c("(1,-1)"))
text(1.2,1,labels=c("(1,1)"))
text(0,-0.08,labels=c("(0,0)"))
mtext(1, text = "Figure 2", line = 4 )

#square&round
plot(x,y, xlim = c(-1,1), ylim=c(-1,1), axes=F,type='n', asp =1,ylab='',xlab='')

#curve((pi),add=T, from=-1 , to =1)
curve((  1 * (1 - x^2)^0.5 ), col = "blue",add=T ,from=-1 , to =1)
curve(( -1 * (1 - x^2)^0.5 ), col = "blue",add=T, from=-1 , to =1)
points(x = 0, y = 0, pch = 19,col = "darkgreen")
lines(x,z1)
lines(x,z2)
lines(z1,y)
lines(z2,y)
points(x = 0, y = 0, pch = 19,col = "darkgreen")
text(-1.2,1,labels=c("(-1,1)"))
text(-1.2,-1,labels=c("(-1,-1)"))
text(1.2,-1,labels=c("(1,-1)"))
text(1.2,1,labels=c("(1,1)"))

mtext(1, text = "Figure 3", line = 4 )
text(0,-0.08,labels=c("(0,0)"))

