const body = {{ textArea3.value }}

let result = body
  .replace(/<img[^>]*base64[^>]*>/gi, '')
  //  .replace(/<\/?strong>|<\/?b>/g, "**")
  //  .replace(/<\/?em>|<\/?i>/g, "_")
  //  .replace(/<br\s*\/?>/g, "  \n")
  //  .replace(/<h1>(.*?)<\/h1>/g, "# $1\n")
  //  .replace(/<h2>(.*?)<\/h2>/g, "## $1\n")
  //  .replace(/<p>(.*?)<\/p>/g, "$1\n");

return result