function ConvertToEnglish ($typing) {
	$base_code = 44032
	$first_code = 588
	$middle_code = 28
	$max_code = 55203
	$firsts = 'ㄱ','ㄲ','ㄴ','ㄷ','ㄸ','ㄹ','ㅁ','ㅂ','ㅃ','ㅅ','ㅆ','ㅇ','ㅈ','ㅉ','ㅊ','ㅋ','ㅌ','ㅍ','ㅎ'
	$middles = 'ㅏ','ㅐ','ㅑ','ㅒ','ㅓ','ㅔ','ㅕ','ㅖ','ㅗ','ㅘ','ㅙ','ㅚ','ㅛ','ㅜ','ㅝ','ㅞ','ㅟ','ㅠ','ㅡ','ㅢ','ㅣ'
	$lasts = 'ㄱ','ㄲ','ㄳ','ㄴ','ㄵ','ㄶ','ㄷ','ㄹ','ㄺ','ㄻ','ㄼ','ㄽ','ㄾ','ㄿ','ㅀ','ㅁ','ㅂ','ㅄ','ㅅ','ㅆ','ㅇ','ㅈ','ㅊ','ㅋ','ㅌ','ㅍ','ㅎ'
	$englishes ='r','R','rt','s','sw','sg','e','f','fr','fa','fq','ft','fx','fv','fg','a','q','qt','t','T','d','w','c','z','x','v','g','k','o','i','O','j','p','u','P','h','hk','ho','hl','y','n','nj','np','nl','b','m','ml','l'
	$table = @{}
	$index = 0;
	ForEach ($key in $lasts+$middles) {
		$table.Add($key, $englishes[$index])
		$index++
	}
	
	ForEach ($char in [char[]]$typing) {
		$code = [int]$char - $base_code
		if ($code -lt 0 -or ($max_code - $base_code) -lt $code) {
			if (' ' -eq $char) { continue }
			if (true -eq $firsts.Contains($char)) { $english+=$table[$char] }
			if (true -eq $middles.Contains($char)) { $english+=$table[$char] }
			if (true -eq $lasts.Contains($char)) { $english+=$table[$char] }
		} else {
			$english+=$table[$firsts[[Math]::Floor($code / $first_code)]]
			$english+=$table[$middles[[Math]::Floor(($code % $first_code) / $middle_code)]]
			$last = ($code % $middle_code) % $middle_code
			if ($last -gt 0) { $english+=$table[$lasts[$last - 1]] }
		}
	}
	return (,$english)
}
