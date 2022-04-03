


class BasicInfo {
  late int userId;
  late int businessId;
  late String baseUrl;
  late String userName;
  late String appLanguageCode;
  late String userImage;
  late String baseUrlWithoutHttp;
  late String timeFormat;
  late String token ;
  late String dateFormat;
  late String googleTransltionKey;
  final String statusCode = "S10001";
  final String createRewards ='/api/v1/business/loyalty/program/create';
  final String welcomeMessage = '/api/v1/business/welcome/message/list';
  final String dynamicImageUrl='/api/v1/file/media/read';
  final String createPost='/api/v1/post/create';
  final  String partnerList='/api/v2/business/partner/list';
  final String mediaFiles='/api/v1/file/media/list';
  final String translate = 'https://translation.googleapis.com/language/translate/v2';
  final String loyaltyTypeAdd = '/api/v1/standard/loyaltytype/customize';
  final String loyaltyProgramList = '/api/v1/business/loyalty/program/list';
  final String loyaltyTypeList = '/api/v1/standard/loyaltyprogramtype/list';
  final String postReceiversList = '/api/v2/utility/recipienttype/list';
  final String personList = '/api/v1/standard/persontype/list';
  final String countryList = '/api/v1/business/partner/addresss/entities';

  final String loyaltyList='/api/v1/standard/loyaltytype/list';

  static final BasicInfo _instance =  BasicInfo._internal();
  BasicInfo._internal() ;
  factory BasicInfo() {
    return _instance;
  }
}