
#' No.of clusters
#'
#' Estimates the number of clusters from the \code{\link{bmt}} run
#'
#' @importFrom stats rnorm
#'
#' @param bmt_output output from the \code{\link{bmt}} run
#' @param prob_threshold probability threshold. Default is 0.5. Do not change it unless
#'    you know what you are doing. See the referenced paper
#'
#' @return The number of clusters
#'
#' @details Estimates the number of clusters as the number of big merges + 1. The probability threshold
#'     is an adjustment that renders this estimation process more robust to sampling fluctuations.
#'     If the sum of the sample frequencies for the two merging clusters in the last big
#'     merge is less than 50 percent, we do not report any merges and thus are left with just 1 cluster.
#'     See the referenced paper for more details.
#'
#' @seealso \code{\link{bmt}}
#'
#' @examples
#' library(fusionclust)
#' set.seed(42)
#' x<- c(rnorm(1000,-2,1), rnorm(1000,2,1))
#' out<- bmt(x)
#' k<- nclust(out)
#'
#' @references
#' \enumerate{
#' \item P. Radchenko, G. Mukherjee, Convex clustering via l1 fusion penalization,
#'  J. Roy. Statist, Soc. Ser. B (Statistical Methodology) (2017)
#'  doi:10.1111/rssb.12226.
#' }
#'
#' @export

nclust<- function(bmt_output,prob_threshold=0.5){

  l<- bmt_output$splits
  if(length(l)<1){
    return(1)
  }
  kk<- dim(bmt_output$prob)[1]
  if(sum(bmt_output$prob[kk,])<prob_threshold){
    return(1)
  }
  return(length(l)+1)
}
