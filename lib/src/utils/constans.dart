import 'package:swingo/src/models/match_status.dart';
import 'package:swingo/src/models/packet_size.dart';

final double swFlingVelocity = 2.0;

List<PacketSize> PACKET_SIZES = [
  PacketSize(id: "XSMALL", name: 'Xsmall'),
  PacketSize(id: "SMALL", name: 'Small'),
  PacketSize(id: "MEDIUM", name: 'Medium'),
  PacketSize(id: "LARGE", name: 'Large'),
  PacketSize(id: "XLARGE", name: 'Xlarge'),
];

Map<String, String> ORDER_OWNER_TYPES = {
  "CARRIER": "CARRIER",
  "SENDER": "SENDER"
};

Map<String, MatchStatus> MATCH_STATUSES = {
  "INITIATED": new MatchStatus(
    status: 'Initiated',
    senderText: 'Waiting Carrier Decision',
    carrierText: 'Accept Offer',
    stepIndex: 0,
  ),
  "CARRIER_APPROVED": new MatchStatus(
    status: 'Carrier Approved',
    senderText: 'Accept Offer',
    carrierText: 'Waiting Sender Decision',
    stepIndex: 1,
  ),
  "REJECTED": new MatchStatus(
    status: 'Rejected',
    senderText: 'Rejected',
    carrierText: 'Rejected',
    stepIndex: 1,
  ),
  "WAITING_FOR_PAYMENT": new MatchStatus(
    status: 'Waiting For Payment',
    senderText: 'Make Payment',
    carrierText: 'Waiting Sender To Make Payment',
    stepIndex: 2,
  ),
  "PAYMENT_PASSED_FOR_ON_ON_DELIVERY": new MatchStatus(
    status: 'Payment Passed for On Delivery',
    senderText: 'Waiting Carrier To Check Box',
    carrierText: 'Accept Check Box',
    stepIndex: 3,
  ),
  "PAYMENT_DONE": new MatchStatus(
    status: 'Payment Done',
    senderText: 'Waiting Carrier To Check Box',
    carrierText: 'Accept Check Box',
    stepIndex: 3,
  ),
  "BOX_CHECK_FAILED": new MatchStatus(
    status: 'Box Check Failed',
    senderText: 'Rejected',
    carrierText: 'Rejected',
    stepIndex: 4,
  ),
  "BOX_CHECK_PASSED": new MatchStatus(
    status: 'Box Check Passed',
    senderText: 'Waiting Carrier To Demand Safety Code',
    carrierText: 'Demand Safety Code',
    stepIndex: 4,
  ),
  "PACKET_TAKING_CODE_SENT": new MatchStatus(
    status: 'Packet Taking Code Sent',
    senderText: 'Share Safety Code In Your Mail',
    carrierText: 'Enter Safety Code Given By Sender',
    stepIndex: 5,
  ),
  "ON_WAY": new MatchStatus(
    status: 'On Way',
    senderText: 'Waiting Carrier To Demand Safety Code',
    carrierText: 'Demand Safety Code',
    stepIndex: 6,
  ),
  "PACKET_DELIVERY_CODE_SENT": new MatchStatus(
    status: 'Packet Delivery Code Sent',
    senderText: 'Share Safety Code In Your Mail',
    carrierText: 'Enter Safety Code Given By Sender',
    stepIndex: 7,
  ),
  "FINISHED": new MatchStatus(
    status: 'Finished',
    senderText: 'Finished',
    carrierText: 'Finished',
    stepIndex: 8,
  ),
};
