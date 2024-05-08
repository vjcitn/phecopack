#' search strings for matches, returning data frame with associated ICD10 codes and PheCodes
#' @import dplyr
#' @param cvec character()
#' @note uses data(phe.icd10) from phecopack
#' @return list named with elements of `cvec`; 
#' component i is a data.frame of matches of `cvec[i]`
#' in `phe.icd10$ICD10.String` using `grepl`
#' @examples
#' nn = get_icd10(c("asthma", "malignant", "cardiac"))
#' sapply(nn, nrow)
#' lapply(nn, function(x) head(unique(x$ICD10.String)))
#' lapply(nn, function(x) head(unique(x$Phenotype)))
#' @export
get_icd10 = function(cvec) {
 data("phe.icd10", package="phecopack")
 ans = lapply(cvec, function(x) 
    phe.icd10 |> 
      dplyr::filter(grepl(x, ICD10.String, ignore.case=TRUE)))
 names(ans) = cvec
 ans
}
