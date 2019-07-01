class CheckpointStep {
  final int id;
  final String title;
  final String carrierDescription;
  final String senderDescription;
  final String activatedCondition;
  final bool carrier;
  final String illustration;
  final String url;
  final bool requiresParam;

  const CheckpointStep(
      {this.id,
      this.title,
      this.carrierDescription,
      this.senderDescription,
      this.activatedCondition,
      this.carrier,
      this.illustration,
      this.url,
      this.requiresParam});

  factory CheckpointStep.fromJson(Map<String, dynamic> json) {
    return CheckpointStep(
      id: json['id'],
      title: json['title'],
      carrierDescription: json['carrierDescription'],
      senderDescription: json['senderDescription'],
      activatedCondition: json['activatedCondition'],
      carrier: json['carrier'],
      illustration: json['illustration'],
      url: json['url'],
      requiresParam: json['requiresParam'],
    );
  }
}
