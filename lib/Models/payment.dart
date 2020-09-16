class Payment {
  final String paymentMethod;
  final String image;

  Payment({this.paymentMethod, this.image});
}

List<Payment> paymentmethods = [
  Payment(
      paymentMethod: 'Cash',
      image:
          'https://www.liberaldictionary.com/wp-content/uploads/2019/02/cash-in-3077.jpg'),
  Payment(
      paymentMethod: 'Master Card',
      image:
          'https://seeklogo.net/wp-content/uploads/2016/07/mastercard-vector-logo.png'),
  Payment(
      paymentMethod: 'Paypal',
      image:
          'https://dwglogo.com/wp-content/uploads/2016/08/PayPal_Logo_Icon.png'),
];
