clear

browse
 
sum
 
des

replace hrswk = . if hrswk == 98

browse

gen weeks_worked = wkslyr

table hrswk

summarize hrswk wkslyr earn

histogram hrswk

histogram hrswk, width(10)

histogram hrswk if gender == "M", width(10)

histogram hrswk if gender == "F", width(10)

histogram hrswk if gender == "M", width(10)

browse

gen lnhourwage = log(earn / hrswk * wkslyr)

summarize lnhourwage

drop if lnhourwage < 0

summarize lnhourwage, detail

tabulate nbamemg gender, summarize(lnhourwage)

reg lnhourwage educ if gender == "M"

reg lnhourwage educ if gender == "F"

gen ptlexper = age - educ

gen ptlexper_sq = ptlexper^2

reg lnhourwage educ ptlexper ptlexper_sq if gender == "M"

reg lnhourwage educ ptlexper ptlexper_sq if gender == "F"
