(TeX-add-style-hook
 "epi_chapter"
 (lambda ()
   (TeX-run-style-hooks
    "./Slides/QuoteArrow1969"
    "./Slides/QuoteSimon1984"
    "./Slides/QuoteShiller2017"
    "./Slides/QuoteInception2010"
    "./Slides/FullFledgedEE"
    "./Slides/QuoteBrowningHansenHeckman1999"
    "./Slides/FigureParker"
    "./Tables/SIDynCS"
    "./Tables/SIDynTrans"
    "subparts/shiller_pound"
    "subparts/tech_diffusion"
    "subparts/finance"
    "subparts/macro_expectation"
    "subparts/empirical_evidence"
    "subparts/contagion_bank_run"
    "subparts/non-econ"
    "subparts/future_directions"
    "subparts/conclusion")
   (TeX-add-symbols
    "bdkhouseholdFull"
    "bdkhouseholdShort"
    "dmwinflationexpectationFull"
    "dmwinflationexpectationShort"
    "kpshousingexpectationFull"
    "kpshousingexpectationShort"
    "bvbayesianlearningFull"
    "bvbayesianlearningShort"
    "thankstext"
    "owner"
    "REMARK")
   (LaTeX-add-labels
    "chap1"
    "chap1:sec1"
    "motivation-and-context"
    "EpiExpHet"
    "subsec:epiNet"
    "subsec:ExpTribes"
    "fig:parker"
    "what-insights-can-the-epidemiological-framework-offer"
    "subsec:epi_framework"
    "table:SIDyn"
    "table:SIDynTrans"
    "subsubsec:AdaptingTheModel"
    "sec:literature"
    "fig:graph_mixer")
   (LaTeX-add-bibliographies
    "reference"))
 :latex)

