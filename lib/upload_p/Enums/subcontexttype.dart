enum SUBCONTEXTTYPE_ENUM {
  SUBJECT,
  CLASS,
  CLUB,
  SPORTS,
  WORK,
  FACILITIES,
  ROOM
}

extension SUBCONTEXTTYPEEXTENSION on SUBCONTEXTTYPE_ENUM {
  String get type {
    switch (this) {
      case SUBCONTEXTTYPE_ENUM.SUBJECT:
        {
          return 'subject';
        }
      case SUBCONTEXTTYPE_ENUM.CLASS:
        {
          return 'class';
        }
      case SUBCONTEXTTYPE_ENUM.CLUB:
        {
          return 'club';
        }
      case SUBCONTEXTTYPE_ENUM.SPORTS:
        {
          return 'sports';
        }
      case SUBCONTEXTTYPE_ENUM.WORK:
        {
          return 'work';
        }

      case SUBCONTEXTTYPE_ENUM.FACILITIES:
        {
          return 'facilities';
        }
      case SUBCONTEXTTYPE_ENUM.ROOM:
        {
          return 'room';
        }
      default:
        {
          return 'work';
        }
    }
  }
}
