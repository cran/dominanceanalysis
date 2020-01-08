## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  fig.width=5,
  fig.height=4
)

## -----------------------------------------------------------------------------
library(dominanceanalysis)
data("tropicbird")

## -----------------------------------------------------------------------------
str(tropicbird)

## ----test training,eval=FALSE-------------------------------------------------
#  library(caTools)
#  set.seed(101)
#  sample <- caTools::sample.split(tropicbird$ID, SplitRatio = .70)
#  train <- subset(tropicbird, sample == TRUE)
#  test  <- subset(tropicbird, sample == FALSE)

## ----echo=FALSE---------------------------------------------------------------
train<-readRDS(system.file("extdata", "da-lr-train.rds", package = "dominanceanalysis"))
test<-readRDS(system.file("extdata", "da-lr-train.rds", package = "dominanceanalysis"))


## -----------------------------------------------------------------------------
modpres <- glm(pres~rem+land+alt+slo+rain+coast, data=train, family=binomial(link='logit'))

## -----------------------------------------------------------------------------
summary(modpres)

## -----------------------------------------------------------------------------
anova(modpres, test="Chisq")

## -----------------------------------------------------------------------------
library(pscl)
pR2(modpres)

## -----------------------------------------------------------------------------
da.glm.fit()("names")

## -----------------------------------------------------------------------------
dapres<-dominanceAnalysis(modpres)

## -----------------------------------------------------------------------------
getFits(dapres,"r2.m")

## -----------------------------------------------------------------------------
dominanceMatrix(dapres, type="complete",fit.functions = "r2.m", ordered=TRUE)

## -----------------------------------------------------------------------------
contributionByLevel(dapres,fit.functions="r2.m")

## -----------------------------------------------------------------------------
plot(dapres, which.graph ="conditional",fit.function = "r2.m")

## -----------------------------------------------------------------------------
dominanceMatrix(dapres, type="conditional",fit.functions = "r2.m", ordered=TRUE)

## -----------------------------------------------------------------------------
averageContribution(dapres,fit.functions = "r2.m")

## -----------------------------------------------------------------------------
plot(dapres, which.graph ="general",fit.function = "r2.m")

## -----------------------------------------------------------------------------
dominanceMatrix(dapres, type="general",fit.functions = "r2.m", ordered=TRUE)

## ----eval=FALSE---------------------------------------------------------------
#  bootmodpres100 <- bootDominanceAnalysis(modpres, R=100)
#  summary(bootmodpres100,fit.functions="r2.m")

## ---- echo=FALSE--------------------------------------------------------------
readRDS(system.file("extdata", "bootmodpres100.rds", package = "dominanceanalysis"))

## ----eval=FALSE---------------------------------------------------------------
#  bootavemodpres100<-bootAverageDominanceAnalysis(modpres,R=100)
#  summary(bootavemodpres100,fit.functions=c("r2.m"))

## ---- echo=FALSE--------------------------------------------------------------
readRDS(system.file("extdata", "bootavemodpres100.rds", package = "dominanceanalysis"))

## ----echo=FALSE,eval=FALSE----------------------------------------------------
#  # This code save the sample selection
#  library(caTools)
#  set.seed(101)
#  sample <- caTools::sample.split(tropicbird$ID, SplitRatio = .70)
#  train <- subset(tropicbird, sample == TRUE)
#  test  <- subset(tropicbird, sample == FALSE)
#  
#  saveRDS(train, "da-lr-train.rds")
#  saveRDS(test, "da-lr-test.rds")
#  bootmodpres100 <- bootDominanceAnalysis(modpres, R=100)
#  bootavemodpres100<-bootAverageDominanceAnalysis(modpres,R=100)
#  
#  # This code allows to save the bootstrap analyses
#  saveRDS(summary(bootmodpres100, fit.functions="r2.m"), "bootmodpres100.rds")
#  saveRDS(summary(bootavemodpres100, fit.functions="r2.m"), "bootavemodpres100.rds")
#  

