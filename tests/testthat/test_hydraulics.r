#*****************************************
#
# (C) Copyright IBM Corp. 2017
# Author: Bradley J Eck and Ernesto Arandia
#
#*****************************************/



context("ENsolveH")
test_that("func works",{
  ENopen("Net1.inp", "Net1.rpt", "")
  expect_silent( ENsolveH()) 
  ENclose()
})
test_that("returns null invisbly on success",{
  ENopen("Net1.inp", "Net1.rpt", "")
  x <- withVisible( ENsolveH() ) 
  ENclose()
  
  expect_null( x$value)
  expect_false( x$visible)
			
		})


# context("ENsaveH")
# test_that("func works",{
#   ENopen("Net1.inp", "Net1.rpt", "Net1.bin")
#   ENsolveH()
#    expect_silent( ENsaveH()) 
#   ENclose()
# })
# 
# test_that("returns null invisbly on success",{
#   ENopen("Net1.inp", "Net1.rpt", "Net1.bin")
#   ENsolveH()
#   x <- withVisible( ENsaveH() ) 
#   ENclose()
#   
#   expect_null( x$value)
#   expect_false( x$visible)
# 			
# 		})


context("ENopenH")
test_that("func works",{
  ENopen("Net1.inp", "Net1.rpt", "Net1.bin")
   expect_silent( ENopenH())
  ENclose()
})

test_that("warn if it's already open",{
  ENopen("Net1.inp", "Net1.rpt", "")	
    expect_silent(ENopenH())
    expect_true(getOpenHflag())
    expect_warning(ENopenH())
    expect_silent(ENcloseH())
  ENclose()
  expect_false(getOpenHflag())
})
test_that("returns null invisbly on success",{
  ENopen("Net1.inp", "Net1.rpt", "Net1.bin")
  x <- withVisible( ENopenH() ) 
  ENclose()
})


context("ENinitH")
test_that("func works w integer input",{
  ENopen("Net1.inp", "Net1.rpt", "Net1.bin")
  ENopenH()
  expect_silent( ENinitH( as.integer(11)))
  ENcloseH()
  ENclose()
})
test_that("func works w numeric input",{
  ENopen("Net1.inp", "Net1.rpt", "Net1.bin")
  ENopenH()
  expect_silent( ENinitH( 11))
  ENclose()
})
test_that("returns null invisbly on success",{
  ENopen("Net1.inp", "Net1.rpt", "Net1.bin")
  ENopenH()
  x <- withVisible( ENinitH( as.integer(11) ) ) 
  ENclose()
})


context("ENrunH")
test_that("func gives a warning when hydraulics are not open", {
  ENopen("Net1.inp", "Net1.rpt", "Net1.bin")
    expect_error(ENrunH(), "103")
  ENclose()
})
test_that("func warns of lack of hydraulic initialization", {
  ENopen("Net1.inp", "Net1.rpt", "Net1.bin")
    ENopenH()
      expect_warning(x <- ENrunH(), "6")
    ENcloseH()
  ENclose()
})
test_that("func works normally", {
  ENopen("Net1.inp", "Net1.rpt", "Net1.bin")
  ENopenH()
    expect_silent(ENinitH(11))
    expect_silent(x <- ENrunH())
  ENcloseH()
  ENclose()
  expect_equal(x, 0)
})


context("ENnextH")
test_that("func gives a warning when hydraulics are not open", {
  ENopen("Net1.inp", "Net1.rpt", "Net1.bin")
    expect_error(ENnextH(), "103")
  ENclose()
})
test_that("func works normally", {
  ENopen("Net1.inp", "Net1.rpt", "Net1.bin")
  ENopenH()
    ENinitH(11)
    ENrunH()
    expect_silent(x <- ENnextH())
  ENcloseH()
  ENclose()
  expect_equal(x, 3600)
})
test_that("func works normally with loop", {
  ENopen("Net1.inp", "Net1.rpt", "Net1.bin")
  t = NULL
  ENopenH()
    ENinitH(11)
    repeat {
      t <- c(t,ENrunH())
      tstep <- ENnextH()
      if (tstep == 0) {
        break
      }
    }
  ENcloseH()
  ENclose()
  expect_equal(t[c(1,7,27)], c(0,21600,86400))
})


context("ENcloseH")
test_that("func gives an error when hydraulics are not open", {
  ENopen("Net1.inp", "Net1.rpt", "Net1.bin")
    expect_warning(ENcloseH())
  ENclose()
})
