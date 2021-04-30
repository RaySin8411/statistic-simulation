f1=function(x){
    y=3*x^3-2*x^2+5*x-6
    return(y)
}
curve(f1,from = -10,to = 10)
#----------------------------------------------
f2=function(x,a=0,b=1){#a for E[X]; b=Var[X]
      y=1/(sqrt(2*pi*b))*exp(-(x-a)^2/(2*b))
      return(y)
}
curve(f2(x),from = -3,to = 3,col='red')
curve(f2(x,0,3),from = -9,to = 9,col='blue',add = T)
curve(f2(x,0,5),from = -15,to = 15,col='green',add = T)

#These figure are equivalent to
curve(dnorm(x),from = -3,to = 3,col='red')

#--------------------------------------------
b=3;c=8;y=2
f3=function(x){
  c<<- 6
  y=b*x^b-2*x^2+5*x-c
  return(y)
}
curve(f3,from = -10,to = 10)

#--------------------------------------------
(function(x,y){z<- x^2+y^2;x+y+z})(0:7,1)

#--------------------------------------------
f5=function(x,FUN=mean){
  FUN(x);
}
f5(1:10)
f5(1:3,mean)
f5(1:3,var)
