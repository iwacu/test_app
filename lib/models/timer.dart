class Timerr {
  final int? id;
  final int taskId;
  final String startTime;
  final int hour;
  final int minutes;
  final int seconds;

  Timerr({
    this.id,
    required this.hour,
    required this.minutes,
    required this.startTime,
    required this.seconds,
    required this.taskId,
  });

  factory Timerr.fromMap(Map<String, dynamic> json) => new Timerr(
        id: json['id'],
        taskId: json['task'],
        startTime: json['start_time'],
        hour: json['h'],
        minutes: json['m'],
        seconds: json['s'],
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'task': taskId,
      'start_time': startTime,
      'h': hour,
      'm': minutes,
      's': seconds,
    };
  }
}
