double findPrice(double price, double discount) {
  final discountPrice = (price * discount) / 100;

  return price - discountPrice;
}

// .. for date
String findTimeAgo(DateTime dateTime) {
  final difference = DateTime.now().difference(dateTime);

  if (difference.inDays >= 365) {
    final int year = difference.inDays ~/ 365;
    return '$year year{${year > 1 ? 's' : ''}} ago';
  } else if (difference.inDays >= 30) {
    final int month = difference.inDays ~/ 30;
    return '$month month${month > 1 ? 's' : ''} ago';
  } else if (difference.inDays >= 1) {
    final int day = difference.inDays;
    return '$day day${day > 1 ? 's' : ''} ago';
  } else if (difference.inHours >= 1) {
    final int hour = difference.inHours;
    return '$hour hour${hour > 1 ? 's' : ''} ago';
  } else if (difference.inMinutes >= 1) {
    final int minute = difference.inMinutes;
    return '$minute minute${minute > 1 ? 's' : ''} ago';
  } else {
    return 'Just now';
  }
}
