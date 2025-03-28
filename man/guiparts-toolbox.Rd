% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/guiparts-toolbox.r
\docType{class}
\name{toolbox-class}
\alias{toolbox-class}
\alias{toolbox}
\title{Tool Box Subclass}
\description{
\code{toolbox} class is a subclass for GUI tool box frame.
}
\details{
This class is a subclass which make GUI tool box frame.
}

\section{Fields}{

\describe{
\item{\code{frame}: }{\code{tkwin} class object; parent of widget window.} 
\item{\code{length}: }{Integer; number of grids.} 
\item{\code{back_list}: }{List of \code{tkwin} class object; list of grids.} 
\item{\code{size}: }{\code{textfield} class object; the value of the font size frame.} 
\item{\code{family}: }{\code{listbox} class object; the value of the font family frame.} 
\item{\code{colour}: }{\code{listbox} class object; the value of the colour set frame.} 
\item{\code{goption}: }{\code{checkboxes} class object; values of other options frame.} 
\item{\code{theme}: }{\code{radioboxes} class object; the value of the graph theme frame.} 
}
}

\section{Contains}{

\code{gparts_base}
}

\section{Methods}{

\describe{
\item{\code{back(perline = 3)}: }{\code{back} method for \code{gparts_base} class.}
\item{\code{front(top,
  showcolourbox = TRUE, 
  fontSize = unlist(options("kmg2FontSize")), 
  fontSize = unlist(options("kmg2FontSize")), 
  fontFamily = unlist(options("kmg2FontFamily")), 
  colourSet = unlist(options("kmg2ColourSet")), 
  saveGraph = unlist(options("kmg2SaveGraph")), 
  themeBase = unlist(options("kmg2Theme"))
)}: }{
  \code{front} method for \code{toolbox} subclass.
}
}
}

\seealso{
Other guiparts: 
\code{\link{back,gparts_base-method}},
\code{\link{checkboxes-class}},
\code{\link{front,checkboxes-method}},
\code{\link{front,radioboxes-method}},
\code{\link{front,textfield-method}},
\code{\link{front,textfields-method}},
\code{\link{front,toolbox-method}},
\code{\link{front,variableboxes-method}},
\code{\link{gparts_base-class}},
\code{\link{radioboxes-class}},
\code{\link{textfield-class}},
\code{\link{textfields-class}},
\code{\link{variableboxes-class}}
}
\concept{guiparts}
\keyword{hplot}
