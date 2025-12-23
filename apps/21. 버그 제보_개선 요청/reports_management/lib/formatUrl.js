const _url = url.href 

console.log(_url)

function getBaseUrl(url) {
  const formIndex = url.indexOf('/form');
  if (formIndex === -1) {
    return url; // '/form'이 없으면 원본 URL 반환
  }
  return url.substring(0, formIndex);
}

const result = getBaseUrl(
  _url)

return result