#' Box Plot Subclass
#'
#' \code{gbox} class is a subclass for box plots.
#'
#' This class is a subclass which show dialog boxes of box plots for graphics editing.
#'
#' @section Fields:
#' \describe{
#' \item{\code{top}: }{\code{tkwin} class object; parent of widget window.}
#' \item{\code{alternateFrame}: }{\code{tkwin} class object; a special frame for some GUI parts.}
#' \item{\code{vbbox1}: }{\code{variableboxes} class object; the frame to select variables.}
#' \item{\code{vbbox2}: }{\code{variableboxes} class object; the frame to select facet variables.}
#' \item{\code{lbbox1}: }{\code{textfields} class object; the frame to set axis labels and the main title.}
#' \item{\code{rbbox1}: }{\code{radioboxes} class object; the frame to set the plot type.}
#' \item{\code{cbbox1}: }{\code{checkboxes} class object; the frame to set options.}
#' \item{\code{tbbox1}: }{\code{toolbox} class object; the frame to set the font, the colour set, other option, and the theme.}
#' }
#' @section Contains:
#' NULL
#' @section Methods:
#' \describe{
#' \item{\code{plotWindow()}: }{Create the window that make plots.}
#' \item{\code{savePlot(plot)}: }{Save the plot.}
#' \item{\code{registRmlist(object)}: }{Register deletable temporary objects.}
#' \item{\code{removeRmlist()}: }{Remove registered temporary objects.}
#' \item{\code{setFront()}: }{Set front parts of frames.}
#' \item{\code{setBack()}: }{Set back parts of frames.}
#' \item{\code{getWindowTitle()}: }{Get the title of the window.}
#' \item{\code{getHelp()}: }{Get the title of the help document.}
#' \item{\code{getParms()}: }{Get graphics settings parameters.}
#' \item{\code{checkTheme(index)}: }{Check themes.}
#' \item{\code{checkVariable(var)}: }{Check a variable length.}
#' \item{\code{checkError(parms)}: }{Check errors.}
#' \item{\code{setDataframe(parms)}: }{Set data frames.}
#' \item{\code{getGgplot(parms)}: }{Get \code{ggplot}.}
#' \item{\code{getGeom(parms)}: }{Get \code{geom}.}
#' \item{\code{getScale(parms)}: }{Get \code{scale}.}
#' \item{\code{getCoord(parms)}: }{Get \code{coord}.}
#' \item{\code{getFacet(parms)}: }{Get \code{facet}.}
#' \item{\code{getXlab(parms)}: }{Get \code{xlab}.}
#' \item{\code{getYlab(parms)}: }{Get \code{ylab}.}
#' \item{\code{getZlab(parms)}: }{Get \code{zlab}.}
#' \item{\code{getMain(parms)}: }{Get the main label.}
#' \item{\code{getTheme(parms)}: }{Get \code{theme}.}
#' \item{\code{getOpts(parms)}: }{Get other \code{opts}.}
#' \item{\code{getPlot(parms)}: }{Get the plot object.}
#' \item{\code{getMessage()}: }{Get the plot error message.}
#' \item{\code{commandDoIt(command)}: }{An wrapper function for command execution.}
#' }
#' @family plot
#'
#' @name gbox-class
#' @aliases gbox
#' @rdname plot-gbox
#' @docType class
#' @keywords hplot
#' @export gbox
gbox <- setRefClass(

  Class = "gbox",

  fields = c("vbbox1", "vbbox2", "lbbox1", "rbbox1", "rbbox2", "cbbox1", "tbbox1"),

  contains = c("plot_base"),

  methods = list(

    setFront = function() {

      vbbox1 <<- variableboxes$new()
      vbbox1$front(
        top       = top, 
        types     = list(Variables(), nonFactors(), Factors()),
        titles    = list(
          gettextKmg2("X variable"),
          gettextKmg2("Y variable (pick one)"),
          gettextKmg2("Stratum variable")
        ),
        initialSelection = list(FALSE, 0, FALSE)
      )

      vbbox2 <<- variableboxes$new()
      vbbox2$front(
        top       = top, 
        types     = list(Factors(), Factors()),
        titles    = list(
          gettextKmg2("Facet variable in rows"),
          gettextKmg2("Facet variable in cols")
        )
      )

      lbbox1 <<- textfields$new()
      lbbox1$front(
        top        = top,
        initValues = list("<auto>", "<auto>", "<auto>", ""),
        titles     = list(
          gettextKmg2("Horizontal axis label"),
          gettextKmg2("Vertical axis label"),
          gettextKmg2("Legend label"),
          gettextKmg2("Title")
        )
      )

      rbbox1 <<- radioboxes$new()
      rbbox1$front(
        top    = alternateFrame,
        labels = list(
          gettextKmg2("Box plot"),
          gettextKmg2("Notched box plot"),
          gettextKmg2("Violin plot"),
          gettextKmg2("95% C.I. (t distribution)"),
          gettextKmg2("95% C.I. (bootstrap)")
        ),
        title  = gettextKmg2("Plot type")
      )

      cbbox1 <<- checkboxes$new()
      cbbox1$front(
        top        = alternateFrame,
        initValues = list("0"),
        labels     = list(
          gettextKmg2("Flipped coordinates")
        ),
        title      = gettextKmg2("Options")
      )
      
      rbbox2 <<- radioboxes$new()
      rbbox2$front(
        top    = alternateFrame,
        labels = list(
          gettextKmg2("None"),
          gettextKmg2("Jitter"),
          gettextKmg2("Beeswarm")
        ),
        title  = gettextKmg2("Add data point")
      )
      
      tbbox1 <<- toolbox$new()
      tbbox1$front(top)

    },

    setBack = function() {

      vbbox1$back()
      vbbox2$back()
      lbbox1$back()

      tkgrid(
        rbbox1$frame,
        labelRcmdr(alternateFrame, text="    "),
        cbbox1$frame,
        labelRcmdr(alternateFrame, text="    "),
        rbbox2$frame,
        stick="nw")
      tkgrid(alternateFrame, stick="nw")
      tkgrid(labelRcmdr(alternateFrame, text="    "), stick="nw")

      tbbox1$back()

    },

    getWindowTitle = function() {
      
      gettextKmg2("Box plot / Violin plot / Confidence interval")
      
    },
    
    getHelp = function() {
      
      "geom_boxplot"
      
    },

    getParms = function() {

      x      <- getSelection(vbbox1$variable[[1]])
      y      <- getSelection(vbbox1$variable[[2]])
      z      <- getSelection(vbbox1$variable[[3]])

      s      <- getSelection(vbbox2$variable[[1]])
      t      <- getSelection(vbbox2$variable[[2]])

      x      <- checkVariable(x)
      y      <- checkVariable(y)
      z      <- checkVariable(z)
      s      <- checkVariable(s)
      t      <- checkVariable(t)

      xlab   <- tclvalue(lbbox1$fields[[1]]$value)
      xauto  <- x
      ylab   <- tclvalue(lbbox1$fields[[2]]$value)
      yauto  <- y
      zlab   <- tclvalue(lbbox1$fields[[3]]$value)
      zauto  <- z
      main   <- tclvalue(lbbox1$fields[[4]]$value)
      
      if (length(x) == 0 && length(z) != 0) {
        xlab <- zlab
        xauto <- zauto
      }
      
      size   <- tclvalue(tbbox1$size$value)
      family <- getSelection(tbbox1$family)
      colour <- getSelection(tbbox1$colour)
      save   <- tclvalue(tbbox1$goption$value[[1]])
      theme  <- checkTheme(getSelection(tbbox1$theme))
      
      options(
        kmg2FontSize   = tclvalue(tbbox1$size$value),
        kmg2FontFamily = seq_along(tbbox1$family$varlist)[tbbox1$family$varlist == getSelection(tbbox1$family)] - 1,
        kmg2ColourSet  = seq_along(tbbox1$colour$varlist)[tbbox1$colour$varlist == getSelection(tbbox1$colour)] - 1,
        kmg2SaveGraph  = tclvalue(tbbox1$goption$value[[1]]),
        kmg2Theme      = seq_along(tbbox1$theme$varlist)[tbbox1$theme$varlist == getSelection(tbbox1$theme)] - 1
      )

      plotType          <- tclvalue(rbbox1$value)
      flipedCoordinates <- tclvalue(cbbox1$value[[1]])
      dataPoint         <- tclvalue(rbbox2$value)

      list(
        x = x, y = y, z = z, s = s, t = t,
        xlab = xlab, xauto = xauto, ylab = ylab, yauto = yauto, zlab = zlab, main = main,
        size = size, family = family, colour = colour, save = save, theme = theme,
        plotType = plotType, flipedCoordinates = flipedCoordinates, dataPoint = dataPoint
      )

    },

    checkError = function(parms) {

      if (length(parms$y) == 0) {
        errorCondition(
          recall  = windowBox,
          message = gettextKmg2("Y variable is not selected")
        )
        errorCode <- TRUE
      } else {
        errorCode <- FALSE
      }
      errorCode

    },

    getGgplot = function(parms) {
      
      if (parms$plotType == "1" || parms$plotType == "2" || parms$plotType == "3") {
        ztype <- "fill"
      } else {
        ztype <- "colour"
      }

      if (length(parms$x) == 0 && length(parms$z) == 0) {
        ggplot <- "ggplot(data = .df, aes(x = factor(1), y = y)) + \n  "
      } else if (length(parms$x) == 0) {
        ggplot <- paste0("ggplot(data = .df, aes(x = z, y = y, ", ztype, " = z)) + \n  ")
      } else if (length(parms$z) == 0) {
        ggplot <- "ggplot(data = .df, aes(x = factor(x), y = y)) + \n  "
      } else {
        if (parms$plotType == "1" || parms$plotType == "2" || parms$plotType == "3") {
          ggplot <- paste0("ggplot(data = .df, aes(x = factor(x), y = y, ", ztype, " = z)) + \n  ")
        } else if (parms$dataPoint != "1") {
          ggplot <- paste0("ggplot(data = .df, aes(x = factor(x), y = y, ", ztype, " = z, fill = z)) + \n  ")
        } else {
          ggplot <- paste0("ggplot(data = .df, aes(x = factor(x), y = y, ", ztype, " = z)) + \n  ")
        }
      }
      ggplot

    },

    getGeom = function(parms) {
      
      if (length(parms$x) != 0 && length(parms$z) != 0) {
        dodge1 <- "position = position_dodge(width = 0.9), "
        dodge2 <- "position = position_dodge(width = 0.9)"
      } else {
        dodge1 <- dodge2 <- ""
      }

      if (parms$plotType == "1") {
        if (parms$dataPoint == "1") {
          geom <- paste0(
            "stat_boxplot(geom = \"errorbar\", ", dodge1, "width = 0.5) + \n  ",
            "geom_boxplot(", dodge2, ") + \n  "
          )
        } else {
          geom <- paste0(
            "stat_boxplot(geom = \"errorbar\", ", dodge1, "width = 0.5) + \n  ",
            "geom_boxplot(", dodge1, "outlier.colour = \"transparent\") + \n  "
          )
        }
      } else if (parms$plotType == "2") {
        if (parms$dataPoint == "1") {
          geom <- paste0(
            "stat_boxplot(geom = \"errorbar\", ", dodge1, "width = 0.5) + \n  ",
            "geom_boxplot(", dodge1, "notch = TRUE) + \n  "
          )
        } else {
          geom <- paste0(
            "stat_boxplot(geom = \"errorbar\", ", dodge1, "width = 0.5) + \n  ",
            "geom_boxplot(", dodge1, "outlier.colour = \"transparent\", notch = TRUE) + \n  "
          )
        }
      } else if (parms$plotType == "3") {
        geom <- paste0(
          "geom_violin(", dodge2, ") + \n  ",
          "stat_summary(fun.y = \"median\", geom = \"point\", ", dodge1, "pch = 10, size = 4) + \n  "
        )
      } else if (parms$plotType == "4") {
        geom <- paste0(
          "stat_summary(fun.y = \"mean\", geom = \"point\", ", dodge2, ") + \n  ",  
          "stat_summary(fun.data = \"mean_cl_normal\", geom = \"errorbar\", ",
            dodge1, "width = 0.1, fun.args = list(conf.int = 0.95)) + \n  "
        )
      } else if (parms$plotType == "5") {
        geom <- paste(
          "stat_summary(fun.y = \"mean\", geom = \"point\", ", dodge2, ") + \n  ",  
          "stat_summary(fun.data = \"mean_cl_boot\", geom = \"errorbar\", ",
            dodge1, "width = 0.1, fun.args = list(conf.int = 0.95)) + \n  "
        )
      }

      if (parms$dataPoint == "1") {
      } else if (parms$dataPoint == "2") {
        if (length(parms$x) != 0 && length(parms$z) != 0) {
          geom <- paste0(
            geom,
            "geom_jitter(colour = \"black\", position = position_jitterdodge(jitter.width = 0.25, jitter.height = 0, dodge.width = 0.9)) + \n  "
          )
        } else {
          geom <- paste0(
            geom,
            "geom_jitter(colour = \"black\", width = 0.1, height = 0) + \n  "
          )
        }
      } else if (parms$dataPoint == "3") {
        geom <- paste0(
          geom,
          "geom_dotplot(binaxis = \"y\", stackdir = \"center\", position = position_dodge(width = 0.9)) + \n  "
        )
      }
      geom

    },

    getScale = function(parms) {
      
      if (length(parms$x) == 0 && length(parms$z) == 0) {
        scale <- "scale_x_discrete(breaks = NULL) + \n  "
      } else if (length(parms$z) != 0) {
        if (parms$plotType == "1" || parms$plotType == "2" || parms$plotType == "3") {
          if (parms$colour == "Default") {
            scale <- ""
          } else if (parms$colour == "Hue") {
            scale <- paste0("scale_fill_hue() + \n  ")
          } else if (parms$colour == "Grey") {
            scale <- paste0("scale_fill_grey() + \n  ")
          } else {
            scale <- paste0("scale_fill_brewer(palette = \"", parms$colour, "\") + \n  ")
          }
        } else {
          if (parms$colour == "Default") {
            scale <- ""
          } else if (parms$colour == "Hue") {
            scale <- paste0("scale_colour_hue() + \n  ")
          } else if (parms$colour == "Grey") {
            scale <- paste0("scale_colour_grey() + \n  ")
          } else {
            scale <- paste0("scale_colour_brewer(palette = \"", parms$colour, "\") + \n  ")
          }
        }
      } else {
        scale <- ""
      }
      scale

    },

    getCoord = function(parms) {
      
      if (parms$flipedCoordinates == "1") {
        coord <- "coord_flip() + \n  "
      } else {
        coord <- ""
      }
      coord
      
    },
    
    getZlab = function(parms) {
      
      if (length(parms$z) == 0) {
        zlab <- ""
      } else if (parms$zlab == "<auto>") {
        if (parms$plotType == "1" || parms$plotType == "2" || parms$plotType == "3") {
          zlab <- paste0("labs(fill = \"", parms$z, "\") + \n  ")
        } else if (parms$dataPoint != "1") {
          zlab <- paste0("labs(fill = \"", parms$z, "\", colour = \"", parms$z, "\") + \n  ")
        } else {
          zlab <- paste0("labs(colour = \"", parms$z, "\") + \n  ")
        }
      } else {
        if (parms$plotType == "1" || parms$plotType == "2" || parms$plotType == "3") {
          zlab <- paste0("labs(fill = \"", parms$zlab, "\") + \n  ")
        } else if (parms$dataPoint != "1") {
          zlab <- paste0("labs(fill = \"", parms$zlab, "\", colour = \"", parms$zlab, "\") + \n  ")
        } else {
          zlab <- paste0("labs(colour = \"", parms$zlab, "\") + \n  ")
        }
      }
      zlab
      
    },

    getOpts = function(parms) {

      opts <- list()
      if (length(parms$s) != 0 || length(parms$t) != 0) {
        opts <- c(opts, "panel.spacing = unit(0.3, \"lines\")")
      }

      if (length(parms$x) == 0 && length(parms$z) == 0) {
        if (parms$flipedCoordinates == "0") {
          opts <- c(opts, "axis.title.x = element_blank()", "axis.text.x = element_blank()")
        } else {
          opts <- c(opts, "axis.title.y = element_blank()", "axis.text.y = element_blank()")
        }
      }

      if (length(opts) != 0) {
        opts <- do.call(paste, c(opts, list(sep = ", ")))
        opts <- paste0(" + \n  theme(", opts, ")")
      } else {
        opts <- ""
      }
      opts

    }

  )
)



#' Wrapper Function of Box Plot Subclass
#'
#' \code{windowBox} function is a wrapper function of \code{gbox} class for the R-commander menu bar.
#'
#' @rdname plot-gbox-windowBox
#' @keywords hplot
#' @export
windowBox <- function() {

  Box <- RcmdrPlugin.KMggplot2::gbox$new()
  Box$plotWindow()

}
