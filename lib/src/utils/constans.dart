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

Map<String, String> BID_STATUSES = {
  "CONSERVATION": "conservation",
  "APPROVED_BY_CARRIER": "approved_by_carrier",
  "APPROVED": "approved",
  "REJECTED": "rejected"
};
