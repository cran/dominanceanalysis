
<!-- README.md is generated from README.Rmd. Please edit that file -->
dominanceanalysis
=================

[![Build Status](https://travis-ci.org/clbustos/dominanceAnalysis.svg?branch=master)](https://travis-ci.org/clbustos/dominanceAnalysis) [![codecov](https://codecov.io/gh/clbustos/dominanceAnalysis/branch/master/graph/badge.svg)](https://codecov.io/gh/clbustos/dominanceAnalysis)

Dominance Analysis (Azen and Budescu, 2003, 2006; Azen and Traxel, 2009; Budescu, 1993; Luo and Azen, 2013), for multiple regression models: Ordinary Least Squares, Generalized Linear Models and Hierarchical Linear Models.

**Features**:

-   Provides complete, conditional and general dominance analysis for *lm* (univariate and multivariate), *lmer* and *glm* (family=binomial) models.
-   Covariance / correlation matrixes could be used as input for OLS dominance analysis, using `lmWithCov()` and `mlmWithCov()` methods, respectively.
-   Multiple criteria can be used as fit indices, which is useful especially for HLM.

Examples
========

Linear regression
-----------------

We could apply dominance analysis directly on the data, using *lm* (see Azen and Budescu, 2003).

The *attitude* data is composed of six predictors of the overall rating of 35 clerical employees of a large financial organization: complaints, privileges, learning, raises, critical and advancement. The method `dominanceAnalysis()` can retrieve all necessary information directly from a *lm* model.

``` r
  library(dominanceanalysis)
  lm.attitude<-lm(rating~.,attitude)
  da.attitude<-dominanceAnalysis(lm.attitude)
```

Using `print()` method on the *dominanceAnalysis* object, we can see that *complaints* completely dominates all other predictors, followed by *learning* (lrnn). The remaining 4 variables (prvl,rass,crtc,advn) don't show a consistent pattern for complete and conditional dominance.

The `print()` method uses `abbreviate`, to allow complex models to be visualized at a glance.

``` r
  print(da.attitude)
#> 
#> Dominance analysis
#> Predictors: complaints, privileges, learning, raises, critical, advance 
#> Fit-indices: r2 
#> 
#> * Fit index:  r2 
#>                            complete              conditional
#> complaints prvl,lrnn,rass,crtc,advn prvl,lrnn,rass,crtc,advn
#> privileges                     crtc                     crtc
#> learning        prvl,rass,crtc,advn      prvl,rass,crtc,advn
#> raises                         crtc                     crtc
#> critical                                                    
#> advance                                                     
#>                             general
#> complaints prvl,lrnn,rass,crtc,advn
#> privileges                crtc,advn
#> learning        prvl,rass,crtc,advn
#> raises               prvl,crtc,advn
#> critical                           
#> advance                        crtc
#> 
#> Average contribution:
#> complaints   learning     raises privileges    advance   critical 
#>      0.371      0.156      0.120      0.051      0.028      0.007
```

The `summary()` method provides the average contribution of each variable. This contribution defines general dominance. Also, shows the complete dominance analysis matrix, that presents all fit differences between levels.

``` r
  summary(da.attitude)
#> 
#> * Fit index:  r2 
#> 
#> Average contribution of each variable:
#> 
#> complaints   learning     raises privileges    advance   critical 
#>      0.371      0.156      0.120      0.051      0.028      0.007 
#> 
#> Dominance Analysis matrix:
#>                                                   model level   fit
#>                                                       1     0     0
#>                                              complaints     1 0.681
#>                                              privileges     1 0.182
#>                                                learning     1 0.389
#>                                                  raises     1 0.348
#>                                                critical     1 0.024
#>                                                 advance     1 0.024
#>                                         Average level 1     1      
#>                                   complaints+privileges     2 0.683
#>                                     complaints+learning     2 0.708
#>                                       complaints+raises     2 0.684
#>                                     complaints+critical     2 0.681
#>                                      complaints+advance     2 0.682
#>                                     privileges+learning     2 0.408
#>                                       privileges+raises     2 0.382
#>                                     privileges+critical     2 0.191
#>                                      privileges+advance     2 0.182
#>                                         learning+raises     2 0.451
#>                                       learning+critical     2 0.396
#>                                        learning+advance     2 0.432
#>                                         raises+critical     2 0.353
#>                                          raises+advance     2 0.399
#>                                        critical+advance     2 0.038
#>                                         Average level 2     2      
#>                          complaints+privileges+learning     3 0.715
#>                            complaints+privileges+raises     3 0.686
#>                          complaints+privileges+critical     3 0.683
#>                           complaints+privileges+advance     3 0.683
#>                              complaints+learning+raises     3 0.708
#>                            complaints+learning+critical     3 0.708
#>                             complaints+learning+advance     3 0.726
#>                              complaints+raises+critical     3 0.684
#>                               complaints+raises+advance     3  0.69
#>                             complaints+critical+advance     3 0.682
#>                              privileges+learning+raises     3 0.459
#>                            privileges+learning+critical     3 0.413
#>                             privileges+learning+advance     3 0.458
#>                              privileges+raises+critical     3 0.386
#>                               privileges+raises+advance     3 0.443
#>                             privileges+critical+advance     3 0.191
#>                                learning+raises+critical     3 0.451
#>                                 learning+raises+advance     3 0.552
#>                               learning+critical+advance     3 0.453
#>                                 raises+critical+advance     3 0.401
#>                                         Average level 3     3      
#>                   complaints+privileges+learning+raises     4 0.715
#>                 complaints+privileges+learning+critical     4 0.715
#>                  complaints+privileges+learning+advance     4 0.729
#>                   complaints+privileges+raises+critical     4 0.686
#>                    complaints+privileges+raises+advance     4  0.69
#>                  complaints+privileges+critical+advance     4 0.684
#>                     complaints+learning+raises+critical     4 0.708
#>                      complaints+learning+raises+advance     4 0.729
#>                    complaints+learning+critical+advance     4 0.727
#>                      complaints+raises+critical+advance     4  0.69
#>                     privileges+learning+raises+critical     4 0.459
#>                      privileges+learning+raises+advance     4 0.563
#>                    privileges+learning+critical+advance     4 0.476
#>                      privileges+raises+critical+advance     4 0.445
#>                        learning+raises+critical+advance     4 0.553
#>                                         Average level 4     4      
#>          complaints+privileges+learning+raises+critical     5 0.715
#>           complaints+privileges+learning+raises+advance     5 0.732
#>         complaints+privileges+learning+critical+advance     5 0.731
#>           complaints+privileges+raises+critical+advance     5 0.691
#>             complaints+learning+raises+critical+advance     5 0.729
#>             privileges+learning+raises+critical+advance     5 0.564
#>                                         Average level 5     5      
#>  complaints+privileges+learning+raises+critical+advance     6 0.733
#>  complaints privileges learning raises critical advance
#>       0.681      0.182    0.389  0.348    0.024   0.024
#>                  0.002    0.027  0.003        0   0.001
#>       0.501               0.226    0.2    0.009       0
#>       0.319      0.019           0.062    0.007   0.043
#>       0.336      0.033    0.102           0.005    0.05
#>       0.657      0.166    0.372  0.329            0.013
#>       0.658      0.158    0.408  0.375    0.014        
#>       0.494      0.075    0.227  0.194    0.007   0.022
#>                           0.032  0.003        0       0
#>                  0.007               0        0   0.018
#>                  0.002    0.024               0   0.006
#>                  0.002    0.027  0.003            0.001
#>                  0.001    0.043  0.007        0        
#>       0.307                      0.051    0.005    0.05
#>       0.305               0.077           0.004   0.061
#>       0.493               0.222  0.195                0
#>       0.502               0.276  0.261    0.009        
#>       0.258      0.008                        0   0.102
#>       0.312      0.016           0.055            0.057
#>       0.293      0.026            0.12    0.021        
#>       0.331      0.033    0.098                   0.048
#>       0.291      0.044    0.154           0.003        
#>       0.645      0.153    0.416  0.363                 
#>       0.374      0.029    0.137  0.106    0.004   0.034
#>                                      0        0   0.014
#>                           0.029               0   0.004
#>                           0.032  0.003                0
#>                           0.046  0.007        0        
#>                  0.007                        0    0.02
#>                  0.007               0            0.019
#>                  0.004           0.003    0.002        
#>                  0.002    0.024                   0.005
#>                  0.001    0.039               0        
#>                  0.001    0.045  0.007                 
#>       0.257                                   0   0.104
#>       0.302                      0.046            0.063
#>       0.271                      0.105    0.018        
#>       0.301               0.073                   0.059
#>       0.247                0.12           0.002        
#>       0.493               0.285  0.254                 
#>       0.257      0.008                            0.102
#>       0.176      0.011                    0.001        
#>       0.274      0.022             0.1                 
#>       0.288      0.044    0.152                        
#>       0.287      0.011    0.084  0.053    0.002   0.039
#>                                               0   0.017
#>                                      0            0.016
#>                                  0.002    0.002        
#>                           0.029                   0.004
#>                           0.041               0        
#>                           0.047  0.007                 
#>                  0.007                            0.021
#>                  0.003                    0.001        
#>                  0.004           0.002                 
#>                  0.001     0.04                        
#>       0.256                                       0.105
#>       0.169                               0.001        
#>       0.255                      0.088                 
#>       0.246               0.119                        
#>       0.176      0.011                                 
#>        0.22      0.005    0.055   0.02    0.001   0.032
#>                                                   0.017
#>                                           0.001        
#>                                  0.002                 
#>                           0.042                        
#>                  0.003                                 
#>       0.169                                            
#>       0.169      0.003    0.042  0.002    0.001   0.017
#> 
```

To evaluate the robustness of our results, we can use bootstrap analysis (Azen and Budescu, 2006).

We applied a bootstrap analysis using `bootDominanceAnalysis()` method with *R*<sup>2</sup> as a fit index and 100 permutations. For precise results, you need to run at least 1000 replications.

``` r
  bda.attitude=bootDominanceAnalysis(lm.attitude, R=100)
```

The `summary()` method presents the results for the bootstrap analysis. *Dij* shows the original result, and *mDij*, the mean for Dij on bootstrap samples and *SE.Dij* its standard error. *Pij* is the proportion of bootstrap samples where *i* dominates *j*, *Pji* is the proportion of bootstrap samples where *j* dominates *i* and *Pnoij* is the proportion of samples where no dominance can be asserted. *Rep* is the proportion of samples where original dominance is replicated.

We can see that the value of complete dominance for *complaints* is fairly robust over all variables (Dij almost equal to mDij, and small SE), contrarily to *learning* (Dij differs from mDij, and bigger SE).

``` r
  summary(bda.attitude)
#> Dominance Analysis
#> ==================
#> Fit index: r2 
#>    dominance          i          k Dij  mDij SE.Dij  Pij  Pji Pnoij  Rep
#>     complete complaints privileges 1.0 0.980 0.0985 0.96 0.00  0.04 0.96
#>     complete complaints   learning 1.0 0.910 0.2290 0.85 0.03  0.12 0.85
#>     complete complaints     raises 1.0 0.980 0.0985 0.96 0.00  0.04 0.96
#>     complete complaints   critical 1.0 0.975 0.1095 0.95 0.00  0.05 0.95
#>     complete complaints    advance 1.0 0.955 0.1438 0.91 0.00  0.09 0.91
#>     complete privileges   learning 0.0 0.275 0.2694 0.02 0.47  0.51 0.47
#>     complete privileges     raises 0.5 0.460 0.1363 0.00 0.08  0.92 0.92
#>     complete privileges   critical 1.0 0.530 0.1560 0.08 0.02  0.90 0.08
#>     complete privileges    advance 0.5 0.510 0.0704 0.02 0.00  0.98 0.98
#>     complete   learning     raises 1.0 0.615 0.2918 0.31 0.08  0.61 0.31
#>     complete   learning   critical 1.0 0.715 0.2776 0.46 0.03  0.51 0.46
#>     complete   learning    advance 1.0 0.665 0.2363 0.33 0.00  0.67 0.33
#>     complete     raises   critical 1.0 0.555 0.1572 0.11 0.00  0.89 0.11
#>     complete     raises    advance 0.5 0.525 0.1095 0.05 0.00  0.95 0.95
#>     complete   critical    advance 0.5 0.520 0.0985 0.04 0.00  0.96 0.96
#>  conditional complaints privileges 1.0 0.985 0.0857 0.97 0.00  0.03 0.97
#>  conditional complaints   learning 1.0 0.925 0.2289 0.89 0.04  0.07 0.89
#>  conditional complaints     raises 1.0 0.975 0.1306 0.96 0.01  0.03 0.96
#>  conditional complaints   critical 1.0 0.990 0.0704 0.98 0.00  0.02 0.98
#>  conditional complaints    advance 1.0 0.980 0.0985 0.96 0.00  0.04 0.96
#>  conditional privileges   learning 0.0 0.195 0.3089 0.07 0.68  0.25 0.68
#>  conditional privileges     raises 0.5 0.345 0.2532 0.02 0.33  0.65 0.65
#>  conditional privileges   critical 1.0 0.600 0.2462 0.24 0.04  0.72 0.24
#>  conditional privileges    advance 0.5 0.535 0.1629 0.09 0.02  0.89 0.89
#>  conditional   learning     raises 1.0 0.665 0.3697 0.49 0.16  0.35 0.49
#>  conditional   learning   critical 1.0 0.790 0.2859 0.62 0.04  0.34 0.62
#>  conditional   learning    advance 1.0 0.760 0.2511 0.52 0.00  0.48 0.52
#>  conditional     raises   critical 1.0 0.685 0.2626 0.39 0.02  0.59 0.39
#>  conditional     raises    advance 0.5 0.595 0.1971 0.19 0.00  0.81 0.81
#>  conditional   critical    advance 0.5 0.445 0.2552 0.08 0.19  0.73 0.73
#>      general complaints privileges 1.0 1.000 0.0000 1.00 0.00  0.00 1.00
#>      general complaints   learning 1.0 0.930 0.2564 0.93 0.07  0.00 0.93
#>      general complaints     raises 1.0 0.980 0.1407 0.98 0.02  0.00 0.98
#>      general complaints   critical 1.0 1.000 0.0000 1.00 0.00  0.00 1.00
#>      general complaints    advance 1.0 1.000 0.0000 1.00 0.00  0.00 1.00
#>      general privileges   learning 0.0 0.100 0.3015 0.10 0.90  0.00 0.90
#>      general privileges     raises 0.0 0.070 0.2564 0.07 0.93  0.00 0.93
#>      general privileges   critical 1.0 0.760 0.4292 0.76 0.24  0.00 0.76
#>      general privileges    advance 1.0 0.770 0.4230 0.77 0.23  0.00 0.77
#>      general   learning     raises 1.0 0.600 0.4924 0.60 0.40  0.00 0.60
#>      general   learning   critical 1.0 0.930 0.2564 0.93 0.07  0.00 0.93
#>      general   learning    advance 1.0 0.970 0.1714 0.97 0.03  0.00 0.97
#>      general     raises   critical 1.0 0.940 0.2387 0.94 0.06  0.00 0.94
#>      general     raises    advance 1.0 1.000 0.0000 1.00 0.00  0.00 1.00
#>      general   critical    advance 0.0 0.440 0.4989 0.44 0.56  0.00 0.56
```

Another way to perform the dominance analysis is by using a correlation or covariance matrix. As an example, we use the *ability.cov* matrix which is composed of five specific skills that might explain *general intelligence* (general). The biggest average contribution is for predictor *reading* (0.152). Nevertheless, in the output of `summary()` method on level 1, we can see that *picture* (0.125) dominates over *reading* (0.077) on 'vocab' submodel.

``` r
lmwithcov<-lmWithCov(general~picture+blocks+maze+reading+vocab, cov2cor(ability.cov$cov))
da.cov<-dominanceAnalysis(lmwithcov)
print(da.cov)
#> 
#> Dominance analysis
#> Predictors: picture, blocks, maze, reading, vocab 
#> Fit-indices: r2 
#> 
#> * Fit index:  r2 
#>          complete         conditional             general
#> picture      maze                maze                maze
#> blocks  pctr,maze      pctr,maze,vocb      pctr,maze,vocb
#> maze                                                     
#> reading maze,vocb pctr,blck,maze,vocb pctr,blck,maze,vocb
#> vocab                                           pctr,maze
#> 
#> Average contribution:
#> reading  blocks   vocab picture    maze 
#>   0.152   0.124   0.096   0.091   0.043
summary(da.cov)
#> 
#> * Fit index:  r2 
#> 
#> Average contribution of each variable:
#> 
#> reading  blocks   vocab picture    maze 
#>   0.152   0.124   0.096   0.091   0.043 
#> 
#> Dominance Analysis matrix:
#>                              model level   fit picture blocks  maze
#>                                  1     0     0   0.217  0.304 0.116
#>                            picture     1 0.217          0.121 0.065
#>                             blocks     1 0.304   0.034        0.011
#>                               maze     1 0.116   0.167    0.2      
#>                            reading     1 0.332   0.106  0.138 0.057
#>                              vocab     1 0.265   0.125  0.155 0.054
#>                    Average level 1     1         0.108  0.153 0.047
#>                     picture+blocks     2 0.338                0.015
#>                       picture+maze     2 0.282           0.07      
#>                    picture+reading     2 0.439          0.055 0.036
#>                      picture+vocab     2  0.39          0.059 0.033
#>                        blocks+maze     2 0.316   0.037             
#>                     blocks+reading     2  0.47   0.023        0.009
#>                       blocks+vocab     2  0.42   0.028        0.007
#>                       maze+reading     2 0.389   0.086   0.09      
#>                         maze+vocab     2 0.319   0.104  0.108      
#>                      reading+vocab     2 0.341   0.103  0.131 0.052
#>                    Average level 2     2         0.064  0.085 0.025
#>                picture+blocks+maze     3 0.353                     
#>             picture+blocks+reading     3 0.494                0.011
#>               picture+blocks+vocab     3 0.448                0.009
#>               picture+maze+reading     3 0.475           0.03      
#>                 picture+maze+vocab     3 0.423          0.035      
#>              picture+reading+vocab     3 0.445          0.051 0.033
#>                blocks+maze+reading     3 0.479   0.026             
#>                  blocks+maze+vocab     3 0.427   0.031             
#>               blocks+reading+vocab     3 0.473   0.023        0.008
#>                 maze+reading+vocab     3 0.394   0.085  0.087      
#>                    Average level 3     3         0.041  0.051 0.016
#>        picture+blocks+maze+reading     4 0.505                     
#>          picture+blocks+maze+vocab     4 0.458                     
#>       picture+blocks+reading+vocab     4 0.496                0.011
#>         picture+maze+reading+vocab     4 0.478          0.028      
#>          blocks+maze+reading+vocab     4 0.481   0.026             
#>                    Average level 4     4         0.026  0.028 0.011
#>  picture+blocks+maze+reading+vocab     5 0.507                     
#>  reading vocab
#>    0.332 0.265
#>    0.221 0.172
#>    0.166 0.116
#>    0.273 0.203
#>          0.009
#>    0.077      
#>    0.184 0.125
#>    0.156  0.11
#>    0.193 0.141
#>          0.006
#>    0.055      
#>    0.164 0.111
#>          0.002
#>    0.053      
#>          0.004
#>    0.074      
#>               
#>    0.116 0.062
#>    0.152 0.105
#>          0.002
#>    0.048      
#>          0.003
#>    0.055      
#>               
#>          0.002
#>    0.054      
#>               
#>               
#>    0.077 0.028
#>          0.002
#>    0.049      
#>               
#>               
#>               
#>    0.049 0.002
#> 
```

Hierarchical Linear Models
--------------------------

For Hierarchical Linear Models using *lme4*, you should provide a null model (see Luo and Azen, 2013).

As an example, we use *npk* dataset, which contains information about a classical N, P, K (nitrogen, phosphate, potassium) factorial experiment on the growth of peas conducted on 6 blocks.

``` r
library(lme4)
#> Loading required package: Matrix
lmer.npk.1<-lmer(yield~N+P+K+(1|block),npk)
lmer.npk.0<-lmer(yield~1+(1|block),npk)
da.lmer<-dominanceAnalysis(lmer.npk.1,null.model=lmer.npk.0)
```

Using `print()` method, we can see that random effects are modeled as a constant (1 | block).

``` r
print(da.lmer)
#> 
#> Dominance analysis
#> Predictors: N, P, K 
#> Constants: ( 1 | block ) 
#> Fit-indices: rb.r2.1, rb.r2.2, sb.r2.1, sb.r2.2 
#> 
#> * Fit index:  rb.r2.1 
#>   complete conditional general
#> N      P,K         P,K     P,K
#> P                             
#> K        P           P       P
#> 
#> Average contribution:
#>      N      K      P 
#>  0.341  0.148 -0.030 
#> * Fit index:  rb.r2.2 
#>   complete conditional general
#> N                             
#> P      N,K         N,K     N,K
#> K        N           N       N
#> 
#> Average contribution:
#>      P      K      N 
#>  0.022 -0.112 -0.259 
#> * Fit index:  sb.r2.1 
#>   complete conditional general
#> N      P,K         P,K     P,K
#> P                             
#> K        P           P       P
#> 
#> Average contribution:
#>      N      K      P 
#>  0.192  0.084 -0.017 
#> * Fit index:  sb.r2.2 
#>   complete conditional general
#> N                          P,K
#> P                             
#> K                            P
#> 
#> Average contribution:
#> N K P 
#> 0 0 0
```

The fit indices used in the analysis were *rb.r2.1* (R&B *R*<sub>1</sub><sup>2</sup>: Level-1 variance component explained by predictors), *rb.r2.2* (R&B *R*<sub>2</sub><sup>2</sup>: Level-2 variance component explained by predictors), *sb.r2.1* (S&B *R*<sub>1</sub><sup>2</sup>: Level-1 proportional reduction in error predicting scores at Level-1), and *sb.r2.2* (S&B *R*<sub>2</sub><sup>2</sup>: Level-2 proportional reduction in error predicting scores at Level-1). We can see that using *rb.r2.1* and *sb.r2.1* index, that shows influence of predictors on Level-1 variance, clearly *nitrogen* dominates over *potassium* and *phosphate*, and *potassium* dominates over *phosphate*.

``` r
s.da.lmer=summary(da.lmer)
s.da.lmer
#> 
#> * Fit index:  rb.r2.1 
#> 
#> Average contribution of each variable:
#> 
#>      N      K      P 
#>  0.341  0.148 -0.030 
#> 
#> Dominance Analysis matrix:
#>                model level    fit     N      P     K
#>        ( 1 | block )     0      0 0.317 -0.042  0.13
#>      ( 1 | block )+N     1  0.317       -0.025 0.158
#>      ( 1 | block )+P     1 -0.042 0.334        0.136
#>      ( 1 | block )+K     1   0.13 0.345 -0.037      
#>      Average level 1     1         0.34 -0.031 0.147
#>    ( 1 | block )+N+P     2  0.292              0.167
#>    ( 1 | block )+N+K     2  0.475       -0.016      
#>    ( 1 | block )+P+K     2  0.094 0.366             
#>      Average level 2     2        0.366 -0.016 0.167
#>  ( 1 | block )+N+P+K     3  0.459                   
#> 
#> * Fit index:  rb.r2.2 
#> 
#> Average contribution of each variable:
#> 
#>      P      K      N 
#>  0.022 -0.112 -0.259 
#> 
#> Dominance Analysis matrix:
#>                model level    fit      N     P      K
#>        ( 1 | block )     0      0 -0.241 0.032 -0.099
#>      ( 1 | block )+N     1 -0.241        0.019  -0.12
#>      ( 1 | block )+P     1  0.032 -0.254       -0.103
#>      ( 1 | block )+K     1 -0.099 -0.262 0.028       
#>      Average level 1     1        -0.258 0.023 -0.112
#>    ( 1 | block )+N+P     2 -0.222              -0.127
#>    ( 1 | block )+N+K     2 -0.361        0.012       
#>    ( 1 | block )+P+K     2 -0.071 -0.277             
#>      Average level 2     2        -0.277 0.012 -0.127
#>  ( 1 | block )+N+P+K     3 -0.348                    
#> 
#> * Fit index:  sb.r2.1 
#> 
#> Average contribution of each variable:
#> 
#>      N      K      P 
#>  0.192  0.084 -0.017 
#> 
#> Dominance Analysis matrix:
#>                model level    fit     N      P     K
#>        ( 1 | block )     0      0 0.179 -0.024 0.073
#>      ( 1 | block )+N     1  0.179       -0.014 0.089
#>      ( 1 | block )+P     1 -0.024 0.189        0.077
#>      ( 1 | block )+K     1  0.073 0.195 -0.021      
#>      Average level 1     1        0.192 -0.017 0.083
#>    ( 1 | block )+N+P     2  0.165              0.094
#>    ( 1 | block )+N+K     2  0.268       -0.009      
#>    ( 1 | block )+P+K     2  0.053 0.206             
#>      Average level 2     2        0.206 -0.009 0.094
#>  ( 1 | block )+N+P+K     3  0.259                   
#> 
#> * Fit index:  sb.r2.2 
#> 
#> Average contribution of each variable:
#> 
#> N K P 
#> 0 0 0 
#> 
#> Dominance Analysis matrix:
#>                model level fit N P K
#>        ( 1 | block )     0   0 0 0 0
#>      ( 1 | block )+N     1   0   0 0
#>      ( 1 | block )+P     1   0 0   0
#>      ( 1 | block )+K     1   0 0 0  
#>      Average level 1     1     0 0 0
#>    ( 1 | block )+N+P     2   0     0
#>    ( 1 | block )+N+K     2   0   0  
#>    ( 1 | block )+P+K     2   0 0    
#>      Average level 2     2     0 0 0
#>  ( 1 | block )+N+P+K     3   0
sm.rb.r2.1=s.da.lmer$rb.r2.1$summary.matrix
# Nitrogen completely dominates  potassium
as.logical(na.omit(sm.rb.r2.1$N > sm.rb.r2.1$K))
#> [1] TRUE TRUE TRUE TRUE
# Nitrogen completely dominates  phosphate
as.logical(na.omit(sm.rb.r2.1$N > sm.rb.r2.1$P))
#> [1] TRUE TRUE TRUE TRUE
# Potassium completely dominates phosphate
as.logical(na.omit(sm.rb.r2.1$K > sm.rb.r2.1$P))
#> [1] TRUE TRUE TRUE TRUE
```

Logistic regression
-------------------

Dominance analysis can be used in logistic regression (see Azen and Traxel, 2009).

As an example, we used the *esoph* dataset, that contains information about a case-control study of (o)esophageal cancer in Ille-et-Vilaine, France.

Looking at the report for standard glm summary method, we can see that the linear effect of each variable was significant (*p* &lt; 0.05 for *agegp.L*, *alcgp.L* and *tobgp.L*), such as the quadratic effect of predictor age (*p* &lt; 0.05 for *agegp.Q*). Even so,it is hard to identify which variable is more important to predict esophageal cancer.

``` r
glm.esoph<-glm(cbind(ncases,ncontrols)~agegp+alcgp+tobgp, esoph,family="binomial")
summary(glm.esoph)
#> 
#> Call:
#> glm(formula = cbind(ncases, ncontrols) ~ agegp + alcgp + tobgp, 
#>     family = "binomial", data = esoph)
#> 
#> Deviance Residuals: 
#>     Min       1Q   Median       3Q      Max  
#> -1.6891  -0.5618  -0.2168   0.2314   2.0642  
#> 
#> Coefficients:
#>             Estimate Std. Error z value Pr(>|z|)    
#> (Intercept) -1.77997    0.19796  -8.992  < 2e-16 ***
#> agegp.L      3.00534    0.65215   4.608 4.06e-06 ***
#> agegp.Q     -1.33787    0.59111  -2.263  0.02362 *  
#> agegp.C      0.15307    0.44854   0.341  0.73291    
#> agegp^4      0.06410    0.30881   0.208  0.83556    
#> agegp^5     -0.19363    0.19537  -0.991  0.32164    
#> alcgp.L      1.49185    0.19935   7.484 7.23e-14 ***
#> alcgp.Q     -0.22663    0.17952  -1.262  0.20680    
#> alcgp.C      0.25463    0.15906   1.601  0.10942    
#> tobgp.L      0.59448    0.19422   3.061  0.00221 ** 
#> tobgp.Q      0.06537    0.18811   0.347  0.72823    
#> tobgp.C      0.15679    0.18658   0.840  0.40071    
#> ---
#> Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
#> 
#> (Dispersion parameter for binomial family taken to be 1)
#> 
#>     Null deviance: 227.241  on 87  degrees of freedom
#> Residual deviance:  53.973  on 76  degrees of freedom
#> AIC: 225.45
#> 
#> Number of Fisher Scoring iterations: 6
```

We performed dominance analysis on this dataset and the results are shown below. The fit indices were *r2.m* (*R*<sub>*M*</sub><sup>2</sup>: McFadden's measure), *r2.cs* (*R*<sub>*C**S*</sub><sup>2</sup>: Cox and Snell's measure), *r2.n* (*R*<sub>*N*</sub><sup>2</sup>: Nagelkerke's measure) and *r2.e* (*R*<sub>*E*</sub><sup>2</sup>: Estrella's measure). For all fit indices, we can conclude that *age* and *alcohol* completely dominate *tobacco*, while *age* shows general dominance over both *alcohol* and *tobacco.*

``` r
da.esoph<-dominanceAnalysis(glm.esoph)
print(da.esoph)
#> 
#> Dominance analysis
#> Predictors: agegp, alcgp, tobgp 
#> Fit-indices: r2.m, r2.cs, r2.n, r2.e 
#> 
#> * Fit index:  r2.m 
#>       complete conditional   general
#> agegp     tbgp        tbgp alcg,tbgp
#> alcgp     tbgp        tbgp      tbgp
#> tobgp                               
#> 
#> Average contribution:
#> agegp alcgp tobgp 
#> 0.363 0.339 0.061 
#> * Fit index:  r2.cs 
#>       complete conditional   general
#> agegp     tbgp        tbgp alcg,tbgp
#> alcgp     tbgp        tbgp      tbgp
#> tobgp                               
#> 
#> Average contribution:
#> agegp alcgp tobgp 
#> 2.129 2.023 0.446 
#> * Fit index:  r2.n 
#>       complete conditional   general
#> agegp     tbgp        tbgp alcg,tbgp
#> alcgp     tbgp        tbgp      tbgp
#> tobgp                               
#> 
#> Average contribution:
#> agegp alcgp tobgp 
#> 2.303 2.188 0.483 
#> * Fit index:  r2.e 
#>       complete conditional   general
#> agegp     tbgp        tbgp alcg,tbgp
#> alcgp     tbgp        tbgp      tbgp
#> tobgp                               
#> 
#> Average contribution:
#> agegp alcgp tobgp 
#> 1.372 1.288 0.246
summary(da.esoph)
#> 
#> * Fit index:  r2.m 
#> 
#> Average contribution of each variable:
#> 
#> agegp alcgp tobgp 
#> 0.363 0.339 0.061 
#> 
#> Dominance Analysis matrix:
#>              model level    fit agegp alcgp tobgp
#>                  1     0 -0.649 0.388 0.389 0.078
#>              agegp     1 -0.261       0.328 0.084
#>              alcgp     1  -0.26 0.327       0.032
#>              tobgp     1 -0.571 0.394 0.343      
#>    Average level 1     1         0.36 0.336 0.058
#>        agegp+alcgp     2  0.067             0.047
#>        agegp+tobgp     2 -0.177       0.291      
#>        alcgp+tobgp     2 -0.228 0.341            
#>    Average level 2     2        0.341 0.291 0.047
#>  agegp+alcgp+tobgp     3  0.113                  
#> 
#> * Fit index:  r2.cs 
#> 
#> Average contribution of each variable:
#> 
#> agegp alcgp tobgp 
#> 2.129 2.023 0.446 
#> 
#> Dominance Analysis matrix:
#>              model level    fit agegp alcgp tobgp
#>                  1     0 -4.344 3.381 3.388 0.974
#>              agegp     1 -0.963       1.121 0.383
#>              alcgp     1 -0.956 1.114       0.156
#>              tobgp     1  -3.37 2.789  2.57      
#>    Average level 1     1        1.952 1.846 0.269
#>        agegp+alcgp     2  0.159             0.095
#>        agegp+tobgp     2  -0.58       0.834      
#>        alcgp+tobgp     2   -0.8 1.054            
#>    Average level 2     2        1.054 0.834 0.095
#>  agegp+alcgp+tobgp     3  0.254                  
#> 
#> * Fit index:  r2.n 
#> 
#> Average contribution of each variable:
#> 
#> agegp alcgp tobgp 
#> 2.303 2.188 0.483 
#> 
#> Dominance Analysis matrix:
#>              model level    fit agegp alcgp tobgp
#>                  1     0 -4.699 3.657 3.665 1.054
#>              agegp     1 -1.042       1.213 0.414
#>              alcgp     1 -1.034 1.205       0.169
#>              tobgp     1 -3.645 3.017  2.78      
#>    Average level 1     1        2.111 1.996 0.291
#>        agegp+alcgp     2  0.171             0.103
#>        agegp+tobgp     2 -0.628       0.902      
#>        alcgp+tobgp     2 -0.865  1.14            
#>    Average level 2     2         1.14 0.902 0.103
#>  agegp+alcgp+tobgp     3  0.275                  
#> 
#> * Fit index:  r2.e 
#> 
#> Average contribution of each variable:
#> 
#> agegp alcgp tobgp 
#> 1.372 1.288 0.246 
#> 
#> Dominance Analysis matrix:
#>              model level    fit agegp alcgp tobgp
#>                  1     0 -2.639 1.818 1.823 0.428
#>              agegp     1 -0.821       0.984 0.297
#>              alcgp     1 -0.815 0.979       0.117
#>              tobgp     1 -2.211 1.687 1.513      
#>    Average level 1     1        1.333 1.249 0.207
#>        agegp+alcgp     2  0.164             0.104
#>        agegp+tobgp     2 -0.524       0.791      
#>        alcgp+tobgp     2 -0.698 0.965            
#>    Average level 2     2        0.965 0.791 0.104
#>  agegp+alcgp+tobgp     3  0.267
```

Then, we performed a bootstrap analysis. Using McFadden's measure (*r2.m*), we can see that bootstrap dominance of *age* over *tobacco*, and of *alcohol* over *tobacco* have standard errors (*SE.Dij*) of 0 and reproducibility (*Rep*) equal to 1, so are fairly robust on all levels.Dominance values of *age* over *alcohol* are not easily reproducible and require more research

``` r
da.b.esoph<-bootDominanceAnalysis(glm.esoph,R = 200)
print(format(summary(da.b.esoph)$r2.m,digits=3),row.names=F)
#>    dominance     i     k Dij  mDij SE.Dij   Pij   Pji Pnoij   Rep
#>     complete agegp alcgp 0.5 0.580 0.4551 0.505 0.345 0.150 0.150
#>     complete agegp tobgp 1.0 0.998 0.0354 0.995 0.000 0.005 0.995
#>     complete alcgp tobgp 1.0 1.000 0.0000 1.000 0.000 0.000 1.000
#>  conditional agegp alcgp 0.5 0.580 0.4551 0.505 0.345 0.150 0.150
#>  conditional agegp tobgp 1.0 0.998 0.0354 0.995 0.000 0.005 0.995
#>  conditional alcgp tobgp 1.0 1.000 0.0000 1.000 0.000 0.000 1.000
#>      general agegp alcgp 1.0 0.590 0.4931 0.590 0.410 0.000 0.590
#>      general agegp tobgp 1.0 1.000 0.0000 1.000 0.000 0.000 1.000
#>      general alcgp tobgp 1.0 1.000 0.0000 1.000 0.000 0.000 1.000
```

Set of predictors
-----------------

Budescu (1993) shows that dominance analysis can be applied to groups or set of inseparable predictors.

``` r
m.budescu.5=matrix(c(1,.30,.41,.33,
                .30,1,.16,.57,
                .41,.16,1,.50,
                .33,.57,.50,1), nrow = 4,ncol = 4,byrow = T,
              dimnames = list(c('SES','IQ','nAch','GPA'),
                              c('SES','IQ','nAch','GPA')))
lmCov.b5<-lmWithCov(GPA~SES+IQ+nAch,m.budescu.5)
da.b5<-dominanceAnalysis(lmCov.b5)
print(da.b5)
#> 
#> Dominance analysis
#> Predictors: SES, IQ, nAch 
#> Fit-indices: r2 
#> 
#> * Fit index:  r2 
#>      complete conditional  general
#> SES                               
#> IQ   SES,nAch    SES,nAch SES,nAch
#> nAch      SES         SES      SES
#> 
#> Average contribution:
#>    IQ  nAch   SES 
#> 0.266 0.186 0.044
summary(da.b5)
#> 
#> * Fit index:  r2 
#> 
#> Average contribution of each variable:
#> 
#>    IQ  nAch   SES 
#> 0.266 0.186 0.044 
#> 
#> Dominance Analysis matrix:
#>            model level   fit   SES    IQ  nAch
#>                1     0     0 0.109 0.325  0.25
#>              SES     1 0.109       0.244  0.16
#>               IQ     1 0.325 0.028       0.172
#>             nAch     1  0.25 0.019 0.246      
#>  Average level 1     1       0.023 0.245 0.166
#>           SES+IQ     2 0.353             0.144
#>         SES+nAch     2 0.269       0.228      
#>          IQ+nAch     2 0.496     0            
#>  Average level 2     2           0 0.228 0.144
#>      SES+IQ+nAch     3 0.496
da.b5.g<-dominanceAnalysis(lmCov.b5,terms = c("SES","IQ+nAch"))
print(da.b5.g)
#> 
#> Dominance analysis
#> Predictors: SES, IQ+nAch 
#> Terms:  = SES ;  = IQ+nAch 
#> Fit-indices: r2 
#> 
#> * Fit index:  r2 
#>         complete conditional general
#> SES                                 
#> IQ+nAch      SES         SES     SES
#> 
#> Average contribution:
#> IQ+nAch     SES 
#>   0.442   0.054
summary(da.b5.g)
#> 
#> * Fit index:  r2 
#> 
#> Average contribution of each variable:
#> 
#> IQ+nAch     SES 
#>   0.442   0.054 
#> 
#> Dominance Analysis matrix:
#>            model level   fit   SES IQ.nAch
#>                1     0     0 0.109   0.496
#>              SES     1 0.109         0.388
#>          IQ+nAch     1 0.496     0        
#>  Average level 1     1           0   0.388
#>      SES+IQ+nAch     2 0.496
```

Installation
------------

You can install the github version of dominanceanalysis from [github](https://github.com/clbustos/dominanceanalysis) with:

``` r
install_github("clbustos/dominanceanalysis")
```

Authors
-------

-   Claudio Bustos Navarrete: Creator and maintainer
-   Filipa Coutinho Soares: Documentation and testing

References
----------

-   Budescu, D. V. (1993). Dominance analysis: A new approach to the problem of relative importance of predictors in multiple regression. Psychological Bulletin, 114(3), 542-551. <https://doi.org/10.1037/0033-2909.114.3.542>

-   Azen, R., & Budescu, D. V. (2003). The dominance analysis approach for comparing predictors in multiple regression. Psychological Methods, 8(2), 129-148. <https://doi.org/10.1037/1082-989X.8.2.129>

-   Azen, R., & Budescu, D. V. (2006). Comparing Predictors in Multivariate Regression Models: An Extension of Dominance Analysis. Journal of Educational and Behavioral Statistics, 31(2), 157-180. <https://doi.org/10.3102/10769986031002157>

-   Azen, R., & Traxel, N. (2009). Using Dominance Analysis to Determine Predictor Importance in Logistic Regression. Journal of Educational and Behavioral Statistics, 34(3), 319-347. <https://doi.org/10.3102/1076998609332754>

-   Luo, W., & Azen, R. (2013). Determining Predictor Importance in Hierarchical Linear Models Using Dominance Analysis. Journal of Educational and Behavioral Statistics, 38(1), 3-31. <https://doi.org/10.3102/1076998612458319>
