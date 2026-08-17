class AthleteHistoryItem {
  final String sessionId;
  final String sessionTitle;

  final String date;
  final String startTime;
  final String endTime;

  final int? weekday;

  final String memberType;
  final String? membershipNote;

  final String? attendanceType;
  final String? attendanceStatus;
  final String? attendanceNote;

  final DateTime? joinedAt;

  const AthleteHistoryItem({
    required this.sessionId,
    required this.sessionTitle,
    required this.date,
    required this.startTime,
    required this.endTime,
    this.weekday,
    required this.memberType,
    this.membershipNote,
    this.attendanceType,
    this.attendanceStatus,
    this.attendanceNote,
    this.joinedAt,
  });
}