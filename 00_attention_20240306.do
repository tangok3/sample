clear all
set more off


*D:\OneDrive\ドキュメント\00_all\sci\prg

use "D:\OneDrive\Nagase\SCI\inf_e.dta" , replace

g year = 2015 if wave == 1
replace year = 2016 if wave == 2
replace year = 2016 if wave == 3
replace year = 2016 if wave == 4
replace year = 2016 if wave == 5
replace year = 2017 if wave == 6
replace year = 2017 if wave == 7
replace year = 2017 if wave == 8
replace year = 2017 if wave == 9
replace year = 2018 if wave == 10
replace year = 2018 if wave == 11
replace year = 2018 if wave == 12
replace year = 2018 if wave == 13
replace year = 2019 if wave == 14
replace year = 2019 if wave == 15
replace year = 2019 if wave == 16
replace year = 2019 if wave == 17
replace year = 2020 if wave == 18
replace year = 2020 if wave == 19
replace year = 2020 if wave == 20
replace year = 2020 if wave == 21
replace year = 2021 if wave == 22
replace year = 2021 if wave == 23
replace year = 2021 if wave == 24
replace year = 2021 if wave == 25
replace year = 2022 if wave == 26
replace year = 2022 if wave == 27
replace year = 2022 if wave == 28
replace year = 2022 if wave == 29
replace year = 2023 if wave == 30
replace year = 2023 if wave == 31
replace year = 2023 if wave == 32
replace year = 2023 if wave == 33



g month = 10 if wave == 1
replace month = 1 if wave == 2
replace month = 4 if wave == 3
replace month = 7 if wave == 4
replace month = 10 if wave == 5
replace month = 1 if wave == 6
replace month = 4 if wave == 7
replace month = 7 if wave == 8
replace month = 10 if wave == 9
replace month = 1 if wave == 10
replace month = 4 if wave == 11
replace month = 7 if wave == 12
replace month = 10 if wave == 13
replace month = 1 if wave == 14
replace month = 4 if wave == 15
replace month = 7 if wave == 16
replace month = 10 if wave == 17
replace month = 1 if wave == 18
replace month = 4 if wave == 19
replace month = 7 if wave == 20
replace month = 10 if wave == 21
replace month = 1 if wave == 22
replace month = 4 if wave == 23
replace month = 7 if wave == 24
replace month = 10 if wave == 25
replace month = 1 if wave == 26
replace month = 4 if wave == 27
replace month = 7 if wave == 28
replace month = 10 if wave == 29
replace month = 1 if wave == 30
replace month = 4 if wave == 31
replace month = 7 if wave == 32
replace month = 10 if wave == 33

g m_code = sample_ID
drop sample_ID

egen id = group(m_code)
drop if id == .
drop id

merge 1:1 m_code year month using "D:\OneDrive\Nagase\SCI\inflation_rates\quarterly_inf\inf_2013_2020_Q.dta" 

drop _merge 
merge 1:1 m_code year month using "D:\OneDrive\ドキュメント\00_all\00_Tango\060_金森さん_Inflation_at_Household\050_Analysis\make_data\visit_2015_2020_q"

keep if month == 1 | month == 4 | month == 7 | month == 10

egen id = group(m_code)

xtset id wave

g attention_CPI = 365 if Q2_4 == 1
replace attention_CPI = 4.5 * ( 365 / 7 ) if Q2_4 == 2
replace attention_CPI = 2.5 * ( 365 / 7 ) if Q2_4 == 3
replace attention_CPI = 1 * ( 365 / 7 ) if Q2_4 == 4
replace attention_CPI = 5 * ( 12 ) if Q2_4 == 5
replace attention_CPI = 2.5 * ( 12 ) if Q2_4 == 6
replace attention_CPI = 1 * ( 12 ) if Q2_4 == 7
replace attention_CPI = 4 if Q2_4 == 8
replace attention_CPI = 2 if Q2_4 == 9
replace attention_CPI = 1 if Q2_4 == 10
replace attention_CPI = 0.1 if Q2_4 == 11
replace attention_CPI = 0.01 if Q2_4 == 12

g l_attention_CPI = log(attention_CPI)


g attention_com = 365 if Q2_5 == 1
replace attention_com = 4.5 * ( 365 / 7 ) if Q2_5 == 2
replace attention_com = 2.5 * ( 365 / 7 ) if Q2_5 == 3
replace attention_com = 1 * ( 365 / 7 ) if Q2_5 == 4
replace attention_com = 5 * ( 12 ) if Q2_5 == 5
replace attention_com = 2.5 * ( 12 ) if Q2_5 == 6
replace attention_com = 1 * ( 12 ) if Q2_5 == 7
replace attention_com = 4 if Q2_5 == 8
replace attention_com = 2 if Q2_5 == 9
replace attention_com = 1 if Q2_5 == 10
replace attention_com = 0.1 if Q2_5 == 11
replace attention_com = 0.01 if Q2_5 == 12


g l_attention_com = log(attention_com)

g lag_pi = L1.pi

g log_visit = log(visit_quarter)

g lag_visit = L1.log_visit


*** Gender Male = 0, Female = 1 ***
generate gender = 0 if QE9 == 1
replace gender = 1 if QE9 == 2

***  Age 20-24 = 2 , Age 25-29 = 3 , Age 30-34 = 4 , Age 35-39 = 5 , Age 40-44 = 6 , Age 45-49 = 7 , Age 50-54 = 8 , Age 55-59 = 9 , Age 60-69 = 10 , Age 70 > = 11 ***
generate age = 0 if QE6 == 2
replace age = 1 if QE6 == 3
replace age = 2 if QE6 == 4
replace age = 3 if QE6 == 5
replace age = 4 if QE6 == 6
replace age = 5 if QE6 == 7
replace age = 6 if QE6 == 8
replace age = 7 if QE6 == 9
replace age = 8 if QE6 == 10
replace age = 9 if QE6 == 11


*** Education primary & junior = 0 , Education  high = 1 , Education college of technology = 2 , Education Vocational =3 , Education junior = 4 , Education university = 5 , Education graduate = 6 ***

generate education = 0 if QE19 == 1
replace education = 1 if QE19 == 2
replace education = 2 if QE19 == 3
replace education = 3 if QE19 == 4
replace education = 4 if QE19 == 5
replace education = 5 if QE19 == 6
replace education = 6 if QE19 == 7


*** h_income <399 = 1 , Income 400~549 = 2 , Income 550~699 = 3 , Income 700~899 = 4 , Income 900 > = 5 ***

generate h_income = 0 if QE22 == 1
replace h_income = 1 if QE22 == 2
replace h_income = 2 if QE22 == 3
replace h_income = 3 if QE22 == 4
replace h_income = 4 if QE22 == 5


*** Income 400~549 = 1 , Income 550~699 = 2 , Income 700~899 = 3 , Income 900 > = 4  ***

generate income = 0 if QE17 == 1
replace income = 1 if QE17 == 2
replace income = 2 if QE17 == 3
replace income = 3 if QE17 == 4
replace income = 4 if QE17 == 5
replace income = 5 if QE17 == 6
replace income = 6 if QE17 == 7
replace income = 7 if QE17 == 8
replace income = 8 if QE17 == 9

g lag_cons = L1.cons
g abs_pi = abs(pi)
g lag_abs_pi = L1.abs_pi
g lag_sqabs_pi = (lag_pi)^2
g sq_pi = (pi)^2
g log_sq_pi = log(sq_pi)
g log_pi01 = log(-pi)
g log_pi02 = log(pi)
stop

binscatter Q2_4 pi if pi < 10 & pi > -10 & lag_cons > 20  
binscatter Q2_5 pi if pi < 10 & pi > -10 & lag_cons > 20 ,linetype(qfit)


binscatter Q2_4 pi if pi < 10 & pi > -10 & lag_cons > 20 & Q2_5 <12
binscatter Q2_5 pi if pi < 10 & pi > -10 & lag_cons > 20 & Q2_5 <12

binscatter Q2_4 lag_pi if lag_pi < 10 & lag_pi > -10 & lag_cons > 20 & Q2_5 <12
binscatter Q2_5 lag_pi if lag_pi < 10 & lag_pi > -10 & lag_cons > 20 & Q2_5 <12

binscatter Q2_4 lag_pi if lag_pi < 10 & lag_pi > -10 & lag_cons > 20
binscatter Q2_5 lag_pi if lag_pi < 10 & lag_pi > -10 & lag_cons > 20


binscatter l_attention_CPI pi if pi < 10 & pi > -10 & cons > 10
binscatter l_attention_CPI lag_pi if pi < 10 & pi > -10 & lag_cons > 10

binscatter l_attention_com pi if pi < 10 & pi > -10 & cons > 30



binscatter l_attention_CPI pi if pi < 10 & pi > -10 & cons > 10
binscatter l_attention_CPI lag_pi if pi < 10 & pi > -10 & lag_cons > 10


binscatter l_attention_com pi if pi < 10 & pi > -10 & cons > 10
binscatter l_attention_com lag_pi if pi < 10 & pi > -10 & lag_cons > 10

binscatter l_attention_com abs_pi if pi < 10 & pi > -10 & cons > 10, line(qfit)
binscatter l_attention_com lag_abs_pi if lag_pi < 5 & lag_pi > -5 & lag_cons > 10 , line(qfit)

binscatter l_attention_CPI lag_abs_pi if lag_pi < 3 & lag_pi > -3 & lag_cons > 40 , line(qfit)
binscatter l_attention_com lag_abs_pi if lag_pi < 3 & lag_pi > -3 & lag_cons > 40, line(qfit)

binscatter l_attention_com lag_pi if lag_pi < 5 & lag_pi > -5 & lag_cons > 10 , line(qfit)

binscatter visit_quarter lag_pi if pi < 50 & pi > -50 & cons > 10

*****
scatter wage tenure, title(Normal Scatter) name(g1, replace) || qfit wage tenure, legend(off) graphregion(fcolor(white))
binscatter wage tenure, linetype(qfit) title(Bin Scatter) name(g2, replace)
graph combine g1 g2
*****

*******OK*******
binscatter abs_pi log_visit if pi < 10 & pi > -10 & cons > 20
binscatter pi log_visit if pi < 10 & pi > -10 & cons > 20
****************


ivreg2 l_attention_com gender age education income (pi = L1.pi lag_visit) if pi > -50 & pi < 50 & cons > 50
ivreg2 l_attention_com gender age education income (pi = L1.pi L1.pie1_cut lag_visit) if pi > -50 & pi < 50 & cons > 50

ivreg2 l_attention_com gender age education income (abs_pi = L1.abs_pi lag_visit) if pi > -50 & pi < 50 & cons > 50


*******OK*******
ivreg2 l_attention_CPI gender age education income (log_sq_pi = L1.sq_pi lag_visit) if pi > -10 & pi < 10 & cons > 50
ivreg2 l_attention_CPI gender age education income (log_sq_pi = L1.sq_pi lag_visit) if pi > -20 & pi < 20 & cons > 50

ivreg2 l_attention_com gender age education income (log_sq_pi = L1.sq_pi lag_visit) if pi > -10 & pi < 10 & cons > 50
ivreg2 l_attention_com gender age education income (log_sq_pi = L1.sq_pi lag_visit) if pi > -20 & pi < 20 & cons > 50


oprobit Q2_4 log_sq_pi gender age education income if pi > -10 & pi < 10 & cons > 50
oprobit Q2_4 log_sq_pi gender age education income if pi > -20 & pi < 20 & cons > 50

oprobit Q2_5 log_sq_pi gender age education income if pi > -10 & pi < 10 & cons > 50
oprobit Q2_5 log_sq_pi gender age education income if pi > -20 & pi < 20 & cons > 50

*******NG*******
ivreg2 d.l_attention_CPI gender age education income (log_sq_pi = L1.sq_pi lag_visit) if pi > -20 & pi < 20 & cons > 50
*******OK*******
ivreg2 d.l_attention_com gender age education income (log_sq_pi = L1.sq_pi lag_visit) if pi > -10 & pi < 10 & cons > 50




