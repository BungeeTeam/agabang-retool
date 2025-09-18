function filterDataByText(data, input) {
  const keywordInput = input.trim().toLowerCase();

  // 품번으로 간주: 공백이 없고 영문+숫자 조합 (예: ab1234)
  const isCodeLike = /^[a-z0-9]+$/i.test(keywordInput) && !/\s/.test(keywordInput);
  const isSpaced = keywordInput.includes(' ');

  // 검색 키워드 구성
  const keywords = (isSpaced || isCodeLike)
    ? [keywordInput]                     // 공백 있거나 품번이면 전체 매칭용
    : keywordInput.split('');           // 붙여쓴 일반 키워드는 글자 단위

  const fullMatchCheck = keywordInput.replace(/\s+/g, '');

  return data.filter(row => {
    const target = row.full_text.toLowerCase();

    // 케이스별 포함 여부 판단
    const allIncludes = keywords.every(word => target.includes(word));
    const wholeMatch = target.includes(fullMatchCheck);
    const codeMatch = isCodeLike && target.includes(keywordInput); // 품번 정확히 포함되면 OK

    return allIncludes || wholeMatch || codeMatch;
  });
}

const itemData = {{ formatDataAsArray(groupByBizCd.value) }}


const result = filterDataByText(itemData, {{search_text.value}}) //allWordsRegex({{search_text.value}})

console.log(result)

return result