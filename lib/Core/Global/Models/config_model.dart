class ConfigModel {
  final String? latestVersion, allowedVersion;
  final bool? isQueueOpen;
  final DateTime? updateFinishDate;
  ConfigModel({
    this.latestVersion,
    this.allowedVersion,
    this.isQueueOpen,
    this.updateFinishDate,
  });

  factory ConfigModel.fromJson(Map data) {
    return ConfigModel(
      latestVersion: data['latest_version'],
      allowedVersion: data['allowed_version'],
      isQueueOpen: data['is_queue_open'],
      updateFinishDate: DateTime.tryParse(data['update_finish_date']),
    );
  }
  ConfigModel copyWith({
    final String? allowedVersion,
    final String? latestVersion,
    final bool? isQueueOpen,
    final DateTime? updateFinishDate,
  }) =>
      ConfigModel(
        allowedVersion: allowedVersion ?? this.allowedVersion,
        latestVersion: latestVersion ?? this.latestVersion,
        isQueueOpen: isQueueOpen ?? this.isQueueOpen,
        updateFinishDate: updateFinishDate ?? this.updateFinishDate,
      );
}
