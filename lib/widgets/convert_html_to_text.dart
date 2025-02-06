String removeHtmlTags(String htmlString) {
  return htmlString.replaceAll(RegExp(r'<[^>]*>'), '');
}

String convertHtmlToText(String htmlText) {
  return removeHtmlTags(htmlText);
}
