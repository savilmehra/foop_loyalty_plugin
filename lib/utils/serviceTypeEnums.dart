enum SERVICE_TYPE { PERSON, BUSINESS, POST, ROOM, CLASS, SUBJECT }

extension SERVICE_TYPE_EXTENSION on SERVICE_TYPE? {
  String get type {
    switch (this) {
      case SERVICE_TYPE.PERSON:
        {
          return 'person';
        }
      case SERVICE_TYPE.BUSINESS:
        {
          return 'business';
        }
      case SERVICE_TYPE.POST:
        {
          return 'post';
        }
      case SERVICE_TYPE.ROOM:
        {
          return 'room';
        }
      case SERVICE_TYPE.CLASS:
        {
          return 'class';
        }
      case SERVICE_TYPE.SUBJECT:
        {
          return 'subject';
        }
      default:
        {
          return 'person';
        }
    }
  }
}
