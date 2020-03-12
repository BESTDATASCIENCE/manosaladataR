#' @title Identifica potenciales delimitadores del archivo
#'
#' @param path ruta del archivo
#' @param delims un vector de delimitadores a tratar
#' @param n numero de filas a mirar en el archivo para determinar los delimitadores
#' @param comment identica las lineas que son comentarios
#' @param skip numero de lineas a evitar al inicio
#' @param quote configura el tipo de texto para frases
#' @importFrom utils download.file
#'

identify_delim <- function(path,
                           delims = c("\t", ",", " ", "|", ";"),
                           n = 10,
                           comment = "#",
                           skip = 0,
                           quote = "\"") {

  # Attempt splitting on list of delimieters
  num_splits <- list()
  for (delim in delims) {

    test <- scan(path,
                 what = "character",
                 nlines = n,
                 allowEscapes = FALSE,
                 encoding = "UTF-8",
                 sep = delim,
                 quote = quote,
                 skip = skip,
                 comment.char = comment,
                 quiet = TRUE)

    num_splits[[delim]] <- length(test)
  }

  if(all(unlist(num_splits) < n)){
    n <- as.numeric(names(sort(table(unlist(num_splits)),decreasing = TRUE)[1]))
  }

  if (all(unlist(num_splits) == n)) {
    warning("Not able to detect delimiter for the file. Defaulting to `\t`.")
    return("\t")
  }

  # which delims that produced consistent splits and greater than 1?
  good_delims <- do.call("c", lapply(num_splits, function(cuts, nrows) {
    (cuts %% nrows == 0) & cuts > nrows
  }, n))

  good_delims <- names(good_delims)[good_delims]

  if (length(good_delims) == 0) {
    warning("Not able to detect delimiter for the file. Defaulting to ` `.")
    return(" ")
  } else if (length(good_delims) > 1) {
    warning(
      "Detected multiple possible delimeters:",
      paste0("`", good_delims, "`", collapse = ", "), ". Defaulting to ",
      paste0("`", good_delims[1], "`"), "."
    )
    return(good_delims[1])
  } else {
    return(good_delims)
  }
}
