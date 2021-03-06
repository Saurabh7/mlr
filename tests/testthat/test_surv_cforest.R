context("surv_cforest")

test_that("surv_cforest", {
  requirePackages(c("party", "!survival"), default.method = "load")
  parset.list = list(
    list(),
    list(control = party::cforest_unbiased(mtry = 2)),
    list(control = party::cforest_unbiased(ntree = 50))
  )
  parset.list2 = list(
    list(),
    list(mtry = 2),
    list(ntree = 50)
  )

  old.predicts.list = list()

  for (i in 1:length(parset.list)) {
    parset = parset.list[[i]]
    pars = list(surv.formula, data = surv.train)
    pars = c(pars, parset)
    set.seed(getOption("mlr.debug.seed"))
    m = do.call(party::cforest, pars)
    old.predicts.list[[i]] = predict(m, newdata = surv.test)
  }

  testSimpleParsets("surv.cforest", surv.df, surv.target, surv.train.inds,
    old.predicts.list, parset.list2)
})
