(TeX-add-style-hook
 "svg-math-and-subfigures"
 (lambda ()
   (LaTeX-add-environments
    '("labeling" LaTeX-env-args ["argument"] 1)))
 :latex)

