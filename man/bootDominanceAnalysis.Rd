% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/bootDominanceAnalysis.r
\name{bootDominanceAnalysis}
\alias{bootDominanceAnalysis}
\title{Bootstrap Analysis for Dominance Analysis}
\usage{
bootDominanceAnalysis(
  x,
  R,
  constants = c(),
  terms = NULL,
  fit.functions = "default",
  null.model = NULL,
  ...
)
}
\arguments{
\item{x}{An object of class \code{lm}, \code{glm}, or \code{lmer}.}

\item{R}{The number of bootstrap resamples.}

\item{constants}{A vector of predictors to remain unchanged between models,
i.e., variables not subjected to bootstrap analysis.}

\item{terms}{A vector of terms to be analyzed. By default, terms are obtained from the model.}

\item{fit.functions}{A list of functions providing fit indices for the model.
Refer to \code{fit.functions} parameter in \code{\link{dominanceAnalysis}} function.}

\item{null.model}{Applicable only for linear mixed models. It refers to the null model against which to test the submodels,
i.e., only random effects, without any fixed effects.}

\item{...}{Additional arguments provided to \code{lm} or \code{lmer} (not implemented yet).}
}
\value{
An object of class \code{bootDominanceAnalysis} containing:
  \item{boot}{The results of the bootstrap analysis.}
  \item{preds}{The predictors analyzed.}
  \item{fit.functions}{The fit functions used in the analysis.}
  \item{c.names}{A vector where each value represents the name of a specific dominance analysis result.
               Names are prefixed with the type of dominance (complete, conditional, or general),
               and the fit function used, followed by the names of the first and second predictors
               involved in the comparison.}
  \item{m.names}{Names of each one the predictor pairs.}
  \item{terms}{The terms analyzed.}
  \item{R}{The number of bootstrap resamples.}
}
\description{
Implements a bootstrap procedure as presented by Azen and Budescu (2003).
Provides the expected level of dominance of predictor \eqn{X_i} over \eqn{X_j},
as the degree to which the pattern found in the sample is reproduced in the
bootstrap samples.
}
\details{
Use \code{summary()} to obtain a nicely formatted \code{data.frame}.
}
\examples{
\donttest{
lm.1 <- lm(Employed ~ ., longley)
da.boot <- bootDominanceAnalysis(lm.1, R = 1000)
summary(da.boot)
}
}
