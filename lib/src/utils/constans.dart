import 'package:swingo/src/models/packet_size.dart';

final double swFlingVelocity = 2.0;

List<PacketSize> PACKET_SIZES = [
  PacketSize(id: "XSMALL", name: 'Xsmall'),
  PacketSize(id: "SMALL", name: 'Small'),
  PacketSize(id: "MEDIUM", name: 'Medium'),
  PacketSize(id: "LARGE", name: 'Large'),
  PacketSize(id: "XLARGE", name: 'Xlarge'),
];

Map<String, String> ORDER_OWNER_TYPES = {"CARRIER": "CARRIER", "SENDER": "SENDER"};

Map<String, String> MATCH_STATUSES = {
  "INITIATED": "Initiated",
  "CARRIER_APPROVED": "Carrier Approved",
  "REJECTED": "Rejected",
  "WAITING_FOR_PAYMENT": "Waiting For Payment",
  "PAYMENT_PASSED_FOR_ON_ON_DELIVERY": "Payment Passed for On Delivery",
  "PAYMENT_DONE": "Payment Done",
  "BOX_CHECK_FAILED": "Box Check Failed",
  "BOX_CHECK_PASSED": "Box Check Passed",
  "PACKET_TAKING_CODE_SENT": "Packet Taking Code Sent",
  "ON_WAY": "On Way",
  "PACKET_DELIVERY_CODE_SENT": "Packet Delivery Code Sent",
  "FINISHED": "Finished",
};
