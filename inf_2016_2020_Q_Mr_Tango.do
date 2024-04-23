clear all
set more off

global dir "D:\SCI\all\SCI"
global dir_data "D:\OneDrive\Nagase\SCI\inflation_rates\Q"

forvalues i=2016/2020{
	
	forvalues k=1(3)10{

	cd $dir
use a_purchase.dta, replace

*********** 2-4, 5-7, 8-10, 11-1 *********** 
*replace month = month - 1
*replace month = 12 if month == 0
********************************************

keep if ( month >= `k' & month <= `k' + 2 ) & ( year == `i' - 1 | year == `i' )

drop month



**** check if a good is purchased in both years ****
**** see the URL below ****
* http://red.ribbon.to/~asuzuki/pukiwiki/index.php?Stata
sort m_code jancode, stable
by m_code jancode: egen min_year = min(year)
by m_code jancode: egen max_year = max(year)


**** drop a good which is not purchased in both years ****
drop if min_year == max_year

drop min_year max_year




**** compute sales and unit for individual i in each year ****
sort m_code year, stable
by m_code year: egen sales = sum(sales0)
by m_code year: egen unit = sum(cons0)



**** compute average price p and weight w_nit in Diamond et al. 2020 IER on pp.254--255 ****
sort m_code year jancode, stable
by m_code year jancode: egen sales_n = sum(sales0)
by m_code year jancode: egen unit_n = sum(cons0)
by m_code year: egen cons_all = sum(cons0)

gen avg_price = sales_n / unit_n
gen p_nit = avg_price
gen q_nit = unit_n

replace sales_n = p_nit * q_nit
gen w_nit = sales_n / sales

sort m_code jancode, stable
by m_code jancode: egen sum_w = sum(w_nit)
by m_code jancode: gen temp010 = _N

replace w_nit = sum_w / temp010

drop temp010 sum_w avg_price sales_n unit_n sales unit


**** keep only the first row in each good in each year ****
sort m_code jancode year, stable
by m_code jancode year: gen temp010 = _n

drop if temp010 != 1
drop temp010


**** compute growth rate of p_nit in Diamond et al. 2020 IER on pp.254--255 ****
*sort m_code jancode year, stable
by m_code jancode: gen growth_pi = p_nit / p_nit[_n-1]


**** keep only the latest year in each good ****
*sort m_code jancode, stable
by m_code jancode: gen temp010 = _n

drop if temp010 == 1
drop temp010



**** compute individual pi ****
gen pi_n = growth_pi ^ w_nit

*sort m_code, stable
by m_code: egen prod = sum(ln(pi_n))
by m_code: gen pi = exp(prod[_N])

replace  pi = 100 * ( pi -1 )

drop prod

**** keep each individual only ****
*sort m_code, stable
by m_code: gen temp010 = _n

keep if temp010 == 1
drop temp010


*sort crossid

	cd $dir_data
*save inf`i'_Q`k'_Feb.dta, replace
save inf`i'_Q`k'_Jan.dta, replace


}
}


clear all
set more off

*cd "D:\Sci_stata\quarterly_inf\"
	cd $dir_data

forvalues i=2016/2020{
	forvalues k=1(3)10{
		use inf`i'_Q`k'_Jan
		gen month = `k'
		save inf_`i'_Q`k'_Jan, replace
	}
}


clear all
set more off

	cd $dir_data


use inf_2016_Q1_Jan.dta, replace

append using inf_2016_Q4_Jan
append using inf_2016_Q7_Jan
append using inf_2016_Q10_Jan



forvalues i=2017/2020{
	
	forvalues k=1(3)10{

		append using inf_`i'_Q`k'_Jan

	}
}

keep m_code year cons_all pi


save inf_2016_2020_Q_Jan, replace

