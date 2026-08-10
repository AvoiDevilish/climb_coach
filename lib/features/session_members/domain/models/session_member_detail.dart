class SessionMemberDetail {


  final String id;

  final String athleteId;

  final String firstName;

  final String lastName;

  final String memberType;

  final bool isActive;



  const SessionMemberDetail({

    required this.id,

    required this.athleteId,

    required this.firstName,

    required this.lastName,

    required this.memberType,

    required this.isActive,

  });



  String get fullName =>
      '$firstName $lastName';

}