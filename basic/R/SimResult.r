# sampling stage
library(nlme)
SimResult = function(datamatrix,SampleFraction,SimTime,EndFlag){

    CNS = dim(datamatrix)[1] # the total number of species over the whole region 
    print(c("True number of species",CNS))
    NQ = dim(datamatrix)[2]  #Number of Quadrats (Total.Area/Xwidth/Ywidth)
    if (SampleFraction!=1) SS = as.integer(SampleFraction*NQ)+1   #Sample Size
    else SS = as.integer(SampleFraction*NQ)
    print(SS)
    RandomDataMatrix = matrix(nrow=CNS,ncol=SS)
    
    ObsS = c()
    Xi = c()
    ShatMM = c()
    ShatMM2 = c()
    uncond.Shat = c()
    
    Shat.Sj1 = c()
    Shat.Sj2 = c()
    Spatial.Shat.cond = c()
    Local.Shat.uncond = c()
    var.hat.ShatMM2 = c()
    alpha.lower = 0.000001
    q = SS/NQ

    set.seed(20070523, kind = NULL)# for fixing the sampling result when sample() is used   4/14 
    for(w in 1:SimTime)
    {   
        generate.sample <- sample(1:NQ, SS, replace=FALSE)
        #equivalent to 
        #generate.sample <- rank(runif(NQ,0,1)) #memory-consuming       
        
        #for(M in 1:SS)
        #    RandomDataMatrix[,M] <- datamatrix[,generate.sample[M]]
        RandomDataMatrix <- datamatrix[,generate.sample]
            
        Xi = rowSums(RandomDataMatrix) 
        #equivalent to #Xi = apply(RandomDataMatrix,1,sum) 

        
        f = mapply(function(x){length(Xi[Xi==x])},1:max(Xi)) 
        ObsS[w] = sum(f)  
        Cut = length(f)

        ############### Haas et al (begin) #################
        Shat.Sj1[w] = ObsS[w]/(1-(1-q)*f[1]/sum((1:length(f))*f))       
        r2.hat = max(0, Shat.Sj1[w]/((sum((1:length(f))*f))^2)*sum((1:length(f))*f*((1:length(f))-1))+
            Shat.Sj1[w]*q/sum((1:length(f))*f)-1)
        Shat.Sj2[w] = (ObsS[w]-(1-q)*log(1-q)*r2.hat*f[1]/q)/
            (1-(1-q)*f[1]/sum((1:length(f))*f))
        ############### Haas et al (end) #################



        ############### Conditional MLE (Mingoti and Meeden) (begin)#################
        cond.logf<-function(x){
                a <- x[1]
                b <- x[2]
        
                rhoN = mapply(
                                function(x){
                                        exp(lgamma(x+a)-lgamma(x+1)+
                                        lgamma(SS+b-x)-lgamma(SS-x+1))
                                    },
                                    1:SS)
                rhoSum = sum(rhoN)

                res <- -sum(f*log(rhoN[1:length(f)]/rhoSum))

                res
            }               
        ############### Conditional MLE (Mingoti and Meeden) (end)#################
        cond.logfSol = nlminb(c(0.2,0.2), cond.logf, lower=c(alpha.lower,alpha.lower), upper=c(1000,1000))
        cond.ahat=cond.logfSol$par[1]
        cond.bhat=cond.logfSol$par[2]

        
#print(c(cond.ahat,cond.bhat))

        if(cond.ahat == alpha.lower) 
        {
            ShatMM2[w] = ObsS[w]*(digamma(NQ+cond.bhat)-digamma(cond.bhat))/
                        (digamma(SS+cond.bhat)-digamma(cond.bhat))
            ShatMM[w] = ObsS[w] + 
                        f[1]/SS*(SS+cond.bhat-1)*sum(1/(cond.bhat+(SS:(NQ-1))))                       
        }
        else
        {                   
            ShatMM[w] = ObsS[w] + 
                        f[1]/SS*(SS+cond.bhat-1)/cond.ahat*
                        (1-exp(lgamma(SS+cond.ahat+cond.bhat)-lgamma(SS+cond.bhat)+
                        lgamma(NQ+cond.bhat)-lgamma(NQ+cond.ahat+cond.bhat)))  
    
            # new method   
            ShatMM2[w] = ObsS[w]*(1-exp(lgamma(cond.ahat+cond.bhat)-lgamma(cond.bhat)+
                            lgamma(NQ+cond.bhat)-lgamma(NQ+cond.ahat+cond.bhat)))/
                            (1-exp(lgamma(cond.ahat+cond.bhat)-lgamma(cond.bhat)+
                            lgamma(SS+cond.bhat)-lgamma(SS+cond.ahat+cond.bhat)))
#            ShatMM2[w] = ObsS[w]*(1-beta(cond.ahat,NQ+cond.bhat)/beta(cond.ahat,cond.bhat))/
#                            (1-beta(cond.ahat,SS+cond.bhat)/beta(cond.ahat,cond.bhat))                           
        }


        ############### Unconditional MLE (begin)#################
        uncond.logf<-function(x){
                a <- x[1]
                b <- x[2]
                uncond.S <- x[3]
        
                rhoN = mapply(
                                function(x){
                                        exp(lgamma(x+a)-lgamma(x+1)+
                                        lgamma(SS+b-x)-lgamma(SS-x+1))
                                    },
                                    1:SS)
                rhoSum = sum(rhoN)
                
                rho.null = (1-exp(lgamma(NQ+a+b)-lgamma(NQ+b)+
                              lgamma(SS+b)-lgamma(SS+a+b)))/
                              (1-exp(lgamma(NQ+a+b)-lgamma(NQ+b)+
                              lgamma(b)-lgamma(a+b)))

                res <- (-sum(f*log(rhoN[1:length(f)]/rhoSum))-
                        ObsS[w]*log(1-rho.null)-(uncond.S-ObsS[w])*log(rho.null)-
                        sum(log(uncond.S-(0:(ObsS[w]-1)))))

                res
            }               
        ############### Unconditional MLE (end)#################
        uncond.logfSol = nlminb(c(cond.ahat,cond.bhat,ShatMM2[w]), 
          uncond.logf, lower=c(alpha.lower,alpha.lower,ObsS[w]), 
          upper=c(1000,1000,ShatMM2[w]))
        uncond.ahat=uncond.logfSol$par[1]
        uncond.bhat=uncond.logfSol$par[2]
        #uncond.Shat=uncond.logfSol$par[3]
        

        if(uncond.ahat == alpha.lower) 
        {
            uncond.Shat[w] = ObsS[w]*(digamma(NQ+uncond.bhat)-digamma(uncond.bhat))/
                        (digamma(SS+uncond.bhat)-digamma(uncond.bhat))
        }
        else
        {                      
            # new method   
            uncond.Shat[w] = ObsS[w]*(1-exp(lgamma(uncond.ahat+uncond.bhat)-lgamma(uncond.bhat)+
                            lgamma(NQ+uncond.bhat)-lgamma(NQ+uncond.ahat+uncond.bhat)))/
                            (1-exp(lgamma(uncond.ahat+uncond.bhat)-lgamma(uncond.bhat)+
                            lgamma(SS+uncond.bhat)-lgamma(SS+uncond.ahat+uncond.bhat)))
        }

#print(c(un=uncond.Shat,cond=ShatMM2[w],uncond.logfSol$par[3],uncond.ahat,cond.ahat))




        
        var.cov = function(par){
            est.S=par[1]
            est.a=par[2]
            est.b=par[3]

        if(est.a != alpha.lower) 
        {
            A = exp(lgamma(est.a+est.b)-lgamma(est.b)+
                        lgamma(NQ+est.b)-lgamma(NQ+est.a+est.b))                       
            B = exp(lgamma(est.a+est.b)-lgamma(est.b)+
                        lgamma(SS+est.b)-lgamma(SS+est.a+est.b))                       
                        
            dA.da = A*(digamma(est.a+est.b)-digamma(NQ+est.a+est.b))
            dB.da = B*(digamma(est.a+est.b)-digamma(SS+est.a+est.b))
            
            dA.db = A*(digamma(est.a+est.b)-digamma(NQ+est.a+est.b)+
                                digamma(NQ+est.b)-digamma(est.b))
            dB.db = B*(digamma(est.a+est.b)-digamma(SS+est.a+est.b)+
                                digamma(SS+est.b)-digamma(est.b))

            dS.da = (1-A)/(1-B)*(dB.da/(1-B)-dA.da/(1-A))
            dS.db = (1-A)/(1-B)*(dB.db/(1-B)-dA.db/(1-A))                        
        }         
        else
        {
            A = digamma(NQ+est.b)/digamma(est.b)
            B = digamma(SS+est.b)/digamma(est.b)
                        
            dA.da = 0
            dB.da = 0
            
            dA.db = A*(psigamma(NQ+est.b,1)/digamma(NQ+est.b)-psigamma(est.b,1)/digamma(est.b))
            dB.db = B*(psigamma(SS+est.b,1)/digamma(SS+est.b)-psigamma(est.b,1)/digamma(est.b))

            dS.da = 0
            dS.db = (1-A)/(1-B)*(dB.db/(1-B)-dA.db/(1-A))                     
        }   
        dS = c(dS.da,dS.db)
        Fisher.Info = (fdHess(c(est.a,est.b), cond.logf)$Hessian)

        if(det(Fisher.Info)!=0)
        { 
            if(ObsS[w]^2*t(dS)%*%solve(Fisher.Info)%*%(dS)>0)            
                var.local.Shat = ObsS[w]*(1-ObsS[w]/ShatMM2[w])*((1-A)/(1-B))^2 + 
                    ObsS[w]^2*t(dS)%*%solve(Fisher.Info,)%*%(dS)
            else
                var.local.Shat = ObsS[w]*(1-ObsS[w]/ShatMM2[w])*((1-A)/(1-B))^2                       
        }
        else
        {
            var.local.Shat = ObsS[w]*(1-ObsS[w]/ShatMM2[w])*((1-A)/(1-B))^2                           
        }
            
        return(var.local.Shat)
        }

      
        var.hat.ShatMM2[w]= var.cov(c(ShatMM2[w],cond.ahat,cond.bhat))
                     
    }
    ############### Loop ending ###########################################################################
  
    #RMSE.Shat = sqrt(sum((Shat-CNS)^2)/SimTime)
    RMSE.Shat.Sj1 = sqrt(sum((Shat.Sj1-CNS)^2)/SimTime)
    RMSE.Shat.Sj2 = sqrt(sum((Shat.Sj2-CNS)^2)/SimTime)
     
    RMSE.ShatMM = sqrt(sum((ShatMM-CNS)^2)/SimTime)
    RMSE.ShatMM2 = sqrt(sum((ShatMM2-CNS)^2)/SimTime)
    RMSE.Local.Shat.uncond = sqrt(sum((Local.Shat.uncond-CNS)^2)/SimTime)

    if(EndFlag!=1)
        output.as.Latex.format = c(    
                    noquote(sprintf("%.2f & %.1f & (%.1f,%.1f) (%.1f, %.1f, %.1f) & %.1f (%.1f) & %.1f (%.1f) & %.1f (%.1f) \\\\", 
                            SampleFraction,mean(ObsS),mean(ShatMM2),mean(uncond.Shat),RMSE.ShatMM2,sd(ShatMM2),mean(sqrt(var.hat.ShatMM2)),mean(ShatMM),RMSE.ShatMM,
                                    mean(Shat.Sj1),RMSE.Shat.Sj1,mean(Shat.Sj2),RMSE.Shat.Sj2))
                ) 
    else
        output.as.Latex.format = c(     
                    noquote(sprintf("%.2f & %.1f & (%.1f,%.1f) (%.1f, %.1f, %.1f) & %.1f (%.1f) & %.1f (%.1f) & %.1f (%.1f) \\\\\\\\", 
                            SampleFraction,mean(ObsS),mean(ShatMM2),mean(uncond.Shat),RMSE.ShatMM2,sd(ShatMM2),mean(sqrt(var.hat.ShatMM2)),mean(ShatMM),RMSE.ShatMM,
                                    mean(Shat.Sj1),RMSE.Shat.Sj1,mean(Shat.Sj2),RMSE.Shat.Sj2))
                ) 
                 
    return(output.as.Latex.format)           
}


