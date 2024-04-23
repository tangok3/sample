clear all 
set more off

import delimited "C:\Users\nakazono\Downloads\00_2019_2020_商品マスター.csv"

rename janコード     jan_code
rename jan名称     jan_name
rename メーカーコード   maker_code
rename メーカー名称   maker_name
rename 大分類コード   category_dai_code
rename 大分類名称    category_dai_name
rename 中分類コード   category_tyu_code
rename 中分類名称   category_tyu_name
rename 品目コード     hinmoku_code
rename 品目名称     hinmoku_name

g temp_capacity = jan_name
replace temp_capacity = subinstr(temp_capacity, " ", "", .)

foreach x in ｱ ｲ ｳ ｴ ｵ ｶ ｷ ｸ ｹ ｺ ｻ ｼ ｽ ｾ ｿ ﾀ ﾁ ﾂ ﾃ ﾄ ﾅ ﾆ ﾇ ﾈ ﾉ ﾊ ﾋ ﾌ ﾍ ﾎ ﾏ ﾐ ﾑ ﾒ ﾓ ﾔ ﾕ ﾖ ﾗ ﾘ ﾙ ﾚ ﾛ ﾜ ｦ ﾝ ｧ ｨ ｩ ｪ ｫ ｯ ｬ ｭ ｮ ｰ ｶﾞ ｷﾞ ｸﾞ ｹﾞ ｺﾞ ｻﾞ ｼﾞ ｽﾞ ｾﾞ ｿﾞ ﾀﾞ ﾁﾞ ﾂﾞ ﾃﾞ ﾄﾞ ﾊﾞ ﾋﾞ ﾌﾞ ﾍﾞ ﾎﾞ ﾊﾟ ﾋﾟ ﾌﾟ ﾍﾟ ﾎﾟ ｳﾞ ﾞ ﾟ - # ･ A B C D E F H I J K N O P Q R S T U V W X Y Z {

	replace jan_name_new = subinstr(jan_name_new, "`x'", "", .)
	
}