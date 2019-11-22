par(mfrow = c(1,2))

polyred = curve(dnorm(x), xlim = c(-3,3),ylab='dnorm(x3,0,1)',xlab='x3')
polyred$y[1]=0
polyred$y[75]=0
polygon(polyred$x[1:75],polyred$y[1:75], col = 'red')

title("Area to left of 1.5 = pnorm(1.5,0,1)")
text(0,0.15,'area = pnorm(1.5,0,1)',cex=0.7)
text(1.5,0,'1.5 = qnorm(0.9331928,0,1)',cex=0.7)


curve(pnorm(x),xlim=c(-3,3),ylab='function(x) pnorm(x) (x)')
x1=seq(from=-3,to=1.5,by=0.5)
n1=length(x)
y1=rep(0.9331928,n1)

y2=seq(from=0,to=0.9331928,by=0.04)
n2=length(y2)
x2=rep(1.5,n2)

title("F(z) = P(Z <= z)")
lines(x1,y1,lty=2)
lines(x2,y2,lty=2)

text(0,0.75,'qnorm(.9381928) is 1.5',cex=0.7)

text(1.5,0.1,'pnorm(1.5) is .9381928',cex=0.7)
