class TicketDetails {
  final String trainNo;
  final String trainName;
  final String Orign;
  final String Destination;
  final List<String> timeFromTO;
  final String Date;
  final String firstName;
  final String lastName;
  final String mobileNo;
  final String PassengerCount;
  final List<String> SeatNumbers;
  final String Price;
  final String email;
  final String NIC;
  final String classType;

  TicketDetails({
    required this.classType,
    required this.trainNo,
    required this.trainName,
    required this.Orign,
    required this.Destination,
    required this.timeFromTO,
    required this.Date,
    required this.firstName,
    required this.lastName,
    required this.mobileNo,
    required this.PassengerCount,
    required this.SeatNumbers,
    required this.Price,
    required this.email,
    required this.NIC
  });

  String ticketDetailsToString(TicketDetails details) {
    String timeFromTo = details.timeFromTO
        .join(', '); // Join the list elements with a comma and space

    String seatNumbers = details.SeatNumbers.join(
        ', '); // Join the list elements with a comma and space

    String detailsString = '''
    Train No: ${details.trainNo}
    Train Name: ${details.trainName}
    Origin: ${details.Orign}
    Destination: ${details.Destination}
    Time: $timeFromTo
    Date: ${details.Date}
    FisrtName : ${details.firstName}
    LastName: ${details.lastName}
    email: ${details.email}
    NIC: ${details.NIC}
    Mobile No: ${details.mobileNo}
    Passenger Count: ${details.PassengerCount}
    Seat Numbers: $seatNumbers
    Price: ${details.Price}
  ''';

    return detailsString;
  }
}
