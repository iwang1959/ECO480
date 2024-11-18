cls
clear all
// Part a
use HW2a.dta

gen race = .1 if black == 0 & hispan == 0
replace race = 0 if black == 1 | hispan == 1
tabulate race
tabstat narr86 qemp86 inc86 tottime, by(race) statistics(mean sd) columns(statistics)

regress narr86 pcnv avgsen tottime ptime86 qemp86


predict residuals, residuals
gen sq_resid = residuals^2
summarize sq_resid
scalar RSS = r(sum)
scalar n = _N
scalar k = 6
scalar sd_squared = RSS / (n - k)
summarize avgsen
scalar MEANavgsen = r(mean)
gen SqDevavgsen = (avgsen - MEANavgsen)^2
summarize SqDevavgsen
scalar S_XX_avgsen = r(sum)
scalar SE_avgsen = sqrt(sd_squared / S_XX_avgsen)
display SE_avgsen

scalar beta_avgsen = _b[avgsen]
scalar SE_avgsen = .00459489
scalar t_value = invttail(n - k, 0.025)
scalar CI_lower = beta_avgsen - (t_value * SE_avgsen)
scalar CI_upper = beta_avgsen + (t_value * SE_avgsen)
display "[" CI_lower ", " CI_upper "]"

rvfplot

gen avgsen2 = avgsen^2
regress narr86 pcnv avgsen avgsen2 tottime ptime86 qemp86

regress narr86 pcnv avgsen avgsen2 ptime86 qemp86 inc86 race tottime, vce(robust)

/* Answer for part a */
// Part b
use HW2b.dta


bysort train: summarize age educ black married lre74 lre75 lre78
regress lre78 train

display e(rmse)^2
egen meanTrain = mean(train)
gen train_diff = train - meanTrain
display sum(train_diff^2)
local mse = e(rmse)^2
local ss_train = sum(train_diff^2)
display sqrt(`mse' / `ss_train')

regress lre78 train re74 re75 educ age black hisp

gen minor = (black == 1 | hisp == 1)
gen minor_train = minor * train
regress lre78 train re74 re75 educ age black hisp minor minor_train

regress lre78 train re74 re75 educ age black hisp unem74 unem75



/* Answer for part b */
