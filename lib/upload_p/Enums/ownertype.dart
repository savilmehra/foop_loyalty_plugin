enum OWNERTYPE_ENUM { PERSON, BUSINESS }

extension OWNERTYPEEXTENSION on OWNERTYPE_ENUM {
  String get type {
    switch (this) {
      case OWNERTYPE_ENUM.PERSON:
        {
          return 'person';
        }
      case OWNERTYPE_ENUM.BUSINESS:
        {
          return 'business';
        }
      default:
        {
          return 'person';
        }
    }
  }
}
