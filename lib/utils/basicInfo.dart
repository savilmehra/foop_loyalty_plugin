


class BasicInfo {
  late int userId;
  late int businessId;
  late String baseUrl;
  late String userName;
  late String appLanguageCode;
  late String userImage;
  late String BASE_URL_WITHOUT_HTTP;
  late String timeFormat;
  late String token ;
  late String dateFormat;
  late String GOOGLE_TRANSLATION_KEY;
  final String statusCode = "S10001";
  final String CREATE_WELCOME_MESSAGE ='/api/v1/business/welcome/message/modify';
  final String WELCOME_MESSAGE_LIST = '/api/v1/business/welcome/message/list';
  final String DYNAMIC_IMAGE_URL='/api/v1/file/media/read';
  final String CREATE_POST='/api/v1/post/create';
  final  String PARTNER_LIST='/api/v2/business/partner/list';
  final String MEDIA_FILES='/api/v1/file/media/list';
  final String TRANSLATE = 'https://translation.googleapis.com/language/translate/v2';
  final String LOYALTY_TYPE_ADD = '/api/v1/standard/loyaltytype/customize';
  final String LOYALTY_PROGRAM_LIST = '/api/v1/business/loyalty/program/list';
  final String LOYALTY_TYPE_LIST = '/api/v1/standard/loyaltyprogramtype/list';



  final String LOYALTY_LIST='/api/v1/standard/loyaltytype/list';

  static final BasicInfo _instance =  BasicInfo._internal();
  BasicInfo._internal() ;
  factory BasicInfo() {
    return _instance;
  }
}