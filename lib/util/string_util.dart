String everyWordToUpperCase(String str) {
  return str
      .trim()
      .split(' ')
      .map((word) => '${word[0].toUpperCase()}${word.substring(1)}').join(' ')
      .toString();
}
