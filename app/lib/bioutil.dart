
String colorForBaseText(String base) {
  switch (base) {
    case 'A':
      return 'green';
    case 'T':
      return 'blue';
    case 'C':
      return 'orange';
    case 'G':
      return 'red';
    default:
      return 'grey'; // For any other character
  }
}