clear all
set more off


*D:\OneDrive\ドキュメント\00_all\sci\prg
global data "D:\attention\2024\data"
global tex  "D:\attention\2024\tex"

cd ${data}

u 00_20240306,clear

fre year  // 2013～2023まで

g sex = QE9 // 1：男性　2：女性
g edu = QE19
g edu_h = 1 if edu >= 6 & edu <= 7 & edu != .
g edu_l = 1 if edu <= 5 & edu != .
g inc = QE22 //　世帯年収
g inc_h = 1 if inc >= 4 & inc <= 5 & inc != .
g inc_l = 1 if inc <= 3 & inc != .
// g age = QE6
g age_o55 = 1 if age >= 8 & age != .
g age_u55 = 1 if age <= 7 & age != .

keep if year <= 2021

// binscatter l_attention_CPI lag_pi if L1.pi < 10 & L1.pi > -10 & lag_cons > 10, line(connect) rd(0)
// binscatter l_attention_CPI lag_pi if L1.pi < 10 & L1.pi > -10 & lag_cons > 10, line(qfit) rd(0)
binscatter l_attention_CPI pi if pi < 10 & pi > -10 & cons > 10, ms(ehuge) line(qfit) rd(0) xtitle(Inflation rates (%)) ytitle(ln (Attention to CPI)) 
stop
// help binscatter
// binscatter l_attention_com pi if pi < 10 & pi > -10 & cons > 10, line(qfit) rd(0)

stop

foreach i in "attention_CPI" "attention_com" {
	
	sum `i',d
	local mean_1 : di %8.2fc r(mean)
    local sd_1   : di %8.2fc r(sd)
    local N_1    : di %8.0fc r(N)

	sum `i' if sex == 1,d
	local mean_2 : di %8.2fc r(mean)
    local sd_2   : di %8.2fc r(sd)
    local N_2    : di %8.0fc r(N)

	sum `i' if sex == 2,d
	local mean_3 : di %8.2fc r(mean)
    local sd_3   : di %8.2fc r(sd)
    local N_3    : di %8.0fc r(N)

	sum `i' if edu_l == 1,d
	local mean_4 : di %8.2fc r(mean)
    local sd_4   : di %8.2fc r(sd)
    local N_4    : di %8.0fc r(N)
	
	sum `i' if edu_h == 1,d
	local mean_5 : di %8.2fc r(mean)
    local sd_5   : di %8.2fc r(sd)
    local N_5    : di %8.0fc r(N)
	
	sum `i' if inc_l == 1,d
	local mean_6 : di %8.2fc r(mean)
    local sd_6   : di %8.2fc r(sd)
    local N_6    : di %8.0fc r(N)
	
	sum `i' if inc_h == 1,d
	local mean_7 : di %8.2fc r(mean)
    local sd_7   : di %8.2fc r(sd)
    local N_7    : di %8.0fc r(N)
	
	sum `i' if age_u55 == 1,d
	local mean_8 : di %8.2fc r(mean)
    local sd_8   : di %8.2fc r(sd)
    local N_8    : di %8.0fc r(N)
	
	sum `i' if age_o55 == 1,d
	local mean_9 : di %8.2fc r(mean)
    local sd_9   : di %8.2fc r(sd)
    local N_9    : di %8.0fc r(N)
	
	
	cd ${tex}

    texdoc init "sum_20240306_`i'.tex", replace force
    tex \documentclass[dvipdfmx,12pt]{article}
    
    tex \begin{document}
    
    tex \begin{table}[!htp]
    tex \centering
    tex \caption{Basic statistics of consumer's attention}
    tex \begin{tabular}{lccccccc}
    tex \hline
    tex \hline
    tex \\[-4pt]
    tex                  & Mean     & SD    & Observations \\
    tex \hline\\
    tex All              & `mean_1' & `sd_1' & `N_1' \\[5pt]
    tex Male           & `mean_2' & `sd_2' & `N_2' \\
    tex Female             & `mean_3' & `sd_3' & `N_3' \\[5pt]
    tex Non-college grad & `mean_4' & `sd_4' & `N_4' \\
    tex College grad     & `mean_5' & `sd_5' & `N_5' \\[5pt]
    tex Low income       & `mean_6' & `sd_6' & `N_6' \\
    tex High income      & `mean_7' & `sd_7' & `N_7' \\[5pt]
    tex Age under 50     & `mean_8' & `sd_8' & `N_8' \\
    tex Age over 50      & `mean_9' & `sd_9' & `N_9' \\[5pt]
    tex \\[3pt]
    tex \hline
    tex \hline
    tex \end{tabular}
    tex \end{table}
    
    tex \end{document}
    texdoc close

}



