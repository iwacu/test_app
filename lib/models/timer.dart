class Timerr {
  final int? id;
  final int taskId;
  final int hour;
  final int minutes;
  final int seconds;

  Timerr({
    this.id,
    required this.hour,
    required this.minutes,
    required this.seconds,
    required this.taskId,
  });

  factory Timerr.fromMap(Map<String, dynamic> json) => new Timerr(
        id: json['id'],
        taskId: json['task'],
        hour: json['h'],
        minutes: json['m'],
        seconds: json['s'],
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'task': taskId,
      'h': hour,
      'm': minutes,
      's': seconds,
    };
  }
}
