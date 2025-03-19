double findPrice(double price, double discount) {
  final discountPrice = (price * discount) / 100;

  return price - discountPrice;
}

// .. for date
String findDateAgo(DateTime dateTime) {
  final difference = DateTime.now().difference(dateTime);

  if (difference.inDays > 365) {
    final years = (difference.inDays / 365).floor();
    return '$years year${years > 1 ? 's' : ''} ago';
  } else if (difference.inDays > 30) {
    final months = (difference.inDays / 30).floor();
    return '$months month${months > 1 ? 's' : ''} ago';
  } else if (difference.inDays > 0) {
    final days = difference.inDays;
    return '$days day${days > 1 ? 's' : ''} ago';
  } else if (difference.inHours > 0) {
    final hours = difference.inHours;
    return '$hours hour${hours > 1 ? 's' : ''} ago';
  } else if (difference.inMinutes > 0) {
    final minutes = difference.inMinutes;
    return '$minutes minute${minutes > 1 ? 's' : ''} ago';
  } else {
    return 'Just Now';
  }
}
