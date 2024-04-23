clear all
set more off

global data   "C:\Users\nakazono\OneDrive\project\attention\data"

cd ${data}
import excel "cpi_base2020.xlsx", sheet("Sheet1") firstrow clear

g year  =  year(date)
g month = month(date)
g wave = ym(year,month)
format wave %tm
tsset wave

tsset wave
g       quarter = 1 if month == 1  | month == 2   | month == 3 
replace quarter = 2 if month == 4  | month == 5   | month == 6
replace quarter = 3 if month == 7  | month == 8   | month == 9 
replace quarter = 4 if month == 10 | month == 11 | month == 12 

bysort year quarter:egen mean_cpi = mean(cpi)

replace mean_cpi = mean_cpi - 100
replace mean_cpi = mean_cpi / 100

save real_cpi,replace

// g cpi2 = (ln(cpi) - ln(L12.cpi)) * 100
//
// line cpi2 date