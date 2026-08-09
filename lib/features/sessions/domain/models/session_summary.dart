class SessionSummary {

  final int capacity;

  final int activeMembers;


  const SessionSummary({

    required this.capacity,

    required this.activeMembers,

  });



  int get availableCapacity {

    return capacity - activeMembers;

  }


}