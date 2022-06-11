# tp_model_reply_to_tw

Code for Endress, A.D. & Johnson, S.P. (2022). Hebbian, correlational learning provides a memory-less mechanism for Statistical Learning irrespective of implementational choices: Reply to Tovar and Westermann (2022)

# Simulations with Tovar & Westerman's model
Tovar & Westerman's code is available at https://osf.io/6jzg3/Readme.md. 


* TW\_hebb\_ltd\_forget.m Adaptation of Tovar & Westerman's model with different decay types (immediate, as in Tovar and Westerman and none), and the possibility to disable thresholding. 
* run\_simulation.m  Function that creates various artificial languages (e.g., Saffran et al., 1996) and trains and tests TW's model on this language
* run\_simulation\_wrapper.m Wrapper to launch run\simulation.m with different parameters. The output is saved in tw\_weights.mat and analyzed in the R files below.
* tw\_weights.mat Output of run\_simulation\_wrapper.m


# Simulations with Endress & Johnson's model
Endress & Johnson's model is available at http://doi.org/10. 25383/city.11359376. 


tp\_model\_reply_tw.Rmd Script containing a first draft of the paper, analyzing the output of Tovar & Westerman's model and recording weights in Endress & Johnson's model.


