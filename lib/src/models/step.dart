class CheckpointStep {
  final int id;
  final String key;
  final String title;
  final String description;
  final String completedCondition;
  final bool carrier;
  final String illustration;
  final String url;
  final bool requiresParam;

  const CheckpointStep(
      {this.id,
      this.key,
      this.title,
      this.description,
      this.completedCondition,
      this.carrier,
      this.illustration,
      this.url,
      this.requiresParam});

  factory CheckpointStep.fromJson(Map<String, dynamic> json) {
    return CheckpointStep(
      id: json['id'],
      key: json['key'],
      title: json['title'],
      description: json['description'],
      completedCondition: json['completedCondition'],
      carrier: json['carrier'],
      illustration: json['illustration'],
      url: json['url'],
      requiresParam: json['requiresParam'],
    );
  }
}
