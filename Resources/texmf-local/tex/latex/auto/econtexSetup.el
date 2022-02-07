(TeX-add-style-hook
 "econtexSetup"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-package-options
                     '(("hyperref" "tex4ht" "hypertexnames=false" "verbose" "unicode=true") ("geometry" "twoside" "marginparwidth=0in" "left=0.5in" "right=0.5in" "top=0.5in" "bottom=0.5in")))
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "path")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "url")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "nolinkurl")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperbaseurl")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperimage")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperref")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "href")
   (add-to-list 'LaTeX-verbatim-macros-with-delims-local "path")
   (TeX-run-style-hooks
    "tex4ht"
    "graphicx"
    "hyperref"
    "pdfcomment"
    "geometry"
    "layouts"
    "ifthen")
   (TeX-add-symbols
    '("answer" 2)
    '("handoutM" 1)
    '("handoutD" 1)
    '("handoutF" 1)
    '("handoutG" 1)
    '("handoutI" 1)
    '("handoutA" 1)
    '("handoutC" 1)
    '("CDCFigSideways" 1)
    '("CDCFig" 1)
    '("together" 1)
    "textSizeDefault"
    "abstractSizeDefault"
    "Koppa"
    "sampi"
    "cigma"
    "Cigma"
    "wideMargins"
    "titlepagefinish"
    "ushort"
    "SolvingMicroDSOPs"
    "MathFactsList"
    "Aggregation"
    "CRRALim"
    "ELogNorm"
    "ELogNormMeanOne"
    "ELogNormTimes"
    "EulersTheorem"
    "ExpEps"
    "ExpPlus"
    "FinSum"
    "FinSumMult"
    "InfSum"
    "InfSumMult"
    "LogELogNorm"
    "LogELogNormTimes"
    "LogEps"
    "LogMeanMPS"
    "MeanOne"
    "MultPlus"
    "NormTimes"
    "OverPlus"
    "SmallSmallZero"
    "SumNormsIsNorm"
    "TaylorOne"
    "TaylorTwo"
    "ifExamQuestion"
    "AnswerOrBlankSpace"
    "ifAnswers"
    "koppa"
    "footnoterule")
   (LaTeX-add-environments
    "CDCPrivate"
    "tabularTitle"))
 :latex)

