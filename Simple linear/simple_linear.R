#引入資料
x=seq(1,40,by=2)
y=c(2,4,5,7,9,
    10,12,14,16,20,
    22,24,27,30,33,
    35,38,41,43,45)

simple_linear=function(x,y,alpha=0.05){
  if (length(x) == length(y)){
  #求 x,y的平均數
  y.bar=mean(y)
  x.bar=mean(x)
  
  ss1=(x-x.bar)*(y-y.bar)
  ss2=(x-x.bar)^2
  sum1=sum(ss1)
  sum2=sum(ss2)
  
  #算b0 ,b1 的estimator
  b1.hat=sum1/sum2
  b0.hat=y.bar-b1.hat*x.bar
  
  #算predicted value,residual 
  pre.y=b0.hat+b1.hat*x
  res=y-pre.y
  sqres=res^2
  
  #sample variance
  ssq=sum(sqres)/(length(x)-2)
  ss=sqrt(ssq)
  
  #算b0,b1的 stand error
  b1.se=sqrt(ssq/sum2)
  b0.se=sqrt(ssq*(1/length(x)+x.bar^2/sum2))
  
  #算b0,b1的 t值
  t.b1=b1.hat/b1.se
  t.b0=b0.hat/b0.se
  
  #算b0,b1的 p-value
  p.b1=2*(1-pt(abs(t.b1),length(x)-2))
  p.b0=2*(1-pt(abs(t.b0),length(x)-2))
  
  #算b0,b1的95%C.I
  c.b1=c(b1.hat-qt(alpha/2,df=length(x)-2,lower.tail = FALSE)*b1.se,
         b1.hat+qt(alpha/2,df=length(x)-2,lower.tail = FALSE)*b1.se)
  c.b0=c(b0.hat-qt(alpha/2,df=length(x)-2,lower.tail = FALSE)*b0.se,
         b0.hat+qt(alpha/2,df=length(x)-2,lower.tail = FALSE)*b0.se)
  
  b0=round(c(b0.hat,b0.se,t.b0,p.b0,c.b0),3)
  b1=round(c(b1.hat,b1.se,t.b1,p.b1,c.b1),3)
  A1=rbind(b0,b1)
  colnames(A1)=c("Estimate","Std. error","t value"," Pr(>|t|)",
                 "lower C.I.","upper  C.I.")
  rownames(A1)=c("Intercept","slope")
  return (A1)
  }
  else print('你輸入的自變數與應變數個數不同')
  
}

(test_slm=simple_linear(x,y))
summary(lm(y~x))

simple_linear_anova=function(x,y,lm_model){
  y.bar=mean(y)
  y.hat=lm_model[1,1]+lm_model[2,1]*x
  resid=y.hat-y
  ssr=sum((y.hat-y.bar)^2)
  sse=sum((resid)^2)
  #sst=sum((y-y.bar)^2)
  df.reg=1
  df.err=length(x)-2
  msr=ssr/df.reg
  mse=sse/df.err
  f=msr/mse
  p_value_f=round(pf(f,df.reg,df.err,lower.tail = FALSE),5)
  reg=c(ssr,df.reg,msr,f,p_value_f)
  err=c(sse,df.err,mse,NA,NA)
  aov=rbind(reg,err)
  rownames(aov)=c('Regression','Error')
  colnames(aov)=c('Sum sq','df','Mean sq','F value','Pr(>F)')
  return(aov)
}

simple_linear_anova(x,y,test_slm)
anova(lm(y~x))
