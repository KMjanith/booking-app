class Item {
  final String firstName;
  final String lastName;
  final String mobile;
  final String email;
  final String NIC;
  final dynamic password;

  Item(
      {required this.firstName,
      required this.NIC,
      required this.lastName,
      required this.mobile,
      required this.email,
      required this.password});

  // Convert to JSON for API request
  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      "mobile": mobile,
      "email": email,
      "NIC" : NIC,
      "password": password
    };
  }
}
