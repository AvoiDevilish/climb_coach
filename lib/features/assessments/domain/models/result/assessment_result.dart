class AssessmentResult {

  final String assessmentId;

  final String? athleteId;

  final DateTime createdAt;

  final Map<String, dynamic> values;


  const AssessmentResult({

    required this.assessmentId,

    this.athleteId,

    required this.createdAt,

    required this.values,

  });


  AssessmentResult copyWith({

    String? assessmentId,

    String? athleteId,

    DateTime? createdAt,

    Map<String, dynamic>? values,

  }) {

    return AssessmentResult(

      assessmentId:
          assessmentId ?? this.assessmentId,

      athleteId:
          athleteId ?? this.athleteId,

      createdAt:
          createdAt ?? this.createdAt,

      values:
          values ?? this.values,

    );

  }

}