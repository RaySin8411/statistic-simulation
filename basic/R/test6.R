#x1,...,x10~i.i.d normal(0,1)
x1=rnorm(1000,0,1)
x2=rnorm(1000,0,1)
x3=rnorm(1000,0,1)
x4=rnorm(1000,0,1)
x5=rnorm(1000,0,1)
x6=rnorm(1000,0,1)
x7=rnorm(1000,0,1)
x8=rnorm(1000,0,1)
x9=rnorm(1000,0,1)
x10=rnorm(1000,0,1)

#yi=xi^2,i=1,2,...,10
y1=x1^2
y2=x2^2
y3=x3^2
y4=x4^2
y5=x5^2
y6=x6^2
y7=x7^2
y8=x8^2
y9=x9^2
y10=x10^2

#11x1+21x2
x=seq(from=-50,to=50,by=0.1)
z1=11*x1+21*x2
plot(density(z1),col='blue',xlab ='11x1+21x2',ylab = 'probability',main='N(0,11^2+21^2)')
hist(z1,add=T,probability = T)
curve(dnorm(x,mean=0,sd=sqrt(121+441)),add=T,col='red')

legend("topright",                 # 表示在右上角
       pch='一' ,                # pch代表點的圖案
       col = c("blue", "red"),     # col代表顏色 
       legend = c("real ", "theory") # 顏色所對應的名稱
)

#x1/x2
x=seq(from=-12000,to=2000,by=20)
z2=x1/x2
plot(density(z2),xlim=c(-5000,5000),col='blue',xlab='x1/x2',ylab = 'probability',main =' t distribution with 1 degree of freedom')
hist(z2,add=T,probability = T )
curve(dt(x,df=1),add=T,col='red')

legend("topright",                 # 表示在左上角
       pch='一' ,                  # pch代表點的圖案
       col = c("blue", "red"),     # col代表顏色 
       legend = c("real ", "theory") # 顏色所對應的名稱
)


#y1+y2+y3
x=seq(from=0,to=25,by=0.1)
z3=y1+y2+y3
plot(density(z3),xlim=c(0,25),ylim=c(0,0.25),col='blue',xlab = 'Y1+Y2+Y3',ylab = 'probability',main='chi square distribution with 3 degrees of freedom')
hist(z3,probability = T,add=T)
curve(dchisq(x,df=3),add=T,col='red')
legend("topright",                 # 表示在右上角
       pch='一' ,                # pch代表點的圖案
       col = c("blue", "red"),     # col代表顏色 
       legend = c("real ", "theory") # 顏色所對應的名稱
)

#(y1+y2+y3)/(y1+y2+...+y10)
x=seq(from=-0.2,to=1.0,by=0.01)
z4=z3/(y1+y2+y3+y4+y5+y6+y7+y8+y9+y10)
plot(density(z4),xlim=c(0,1),ylim=c(0,3),col='blue',xlab='(y1+y2+y3)/(y1+y2+...+y10)',main='B(alphq=3,beta=7)')
hist(z4,probability = T,add=T)
curve(dbeta(x,shape1 = 3,shape2 = 7),col='red',add=T)

legend("topright",                 # 表示在右上角
       pch='一' ,                # pch代表點的圖案
       col = c("blue", "red"),     # col代表顏色 
       legend = c("real ", "theory") # 顏色所對應的名稱
)

#3X1/sqrt(y2+y3+...+y10)
x=seq(from=-8,to=6,by=0.1)
z5=3*x1/sqrt(y2+y3+y4+y5+y6+y7+y8+y9+y10)
plot(density(z5),col='blue',xlab='3x1/sqrt(y2+y3+...+y10)',ylab = 'probability',main = 't distribution with 9 degrees of freedom')
hist(z5,probability = T,add=T)
curve(dt(x,df=9),add=T,col='red')

legend("topright",                 # 表示在右上角
       pch='一' ,                # pch代表點的圖案
       col = c("blue", "red"),     # col代表顏色 
       legend = c("real ", "theory") # 顏色所對應的名稱
)
