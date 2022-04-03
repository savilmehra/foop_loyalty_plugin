import 'dart:io';


import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foop_loyalty_plugin/models/imageuploadrequestandresponse.dart';
import 'package:foop_loyalty_plugin/models/loyaltyPayload.dart';
import 'package:foop_loyalty_plugin/models/loyalty_list_response.dart';
import 'package:foop_loyalty_plugin/upload_p/Enums/contexttype.dart';
import 'package:foop_loyalty_plugin/upload_p/Enums/ownertype.dart';
import 'package:foop_loyalty_plugin/upload_p/Enums/subcontexttype.dart';
import 'package:foop_loyalty_plugin/upload_p/GlobalUploadFilePkg.dart';
import 'package:foop_loyalty_plugin/utils/basicInfo.dart';
import 'package:foop_loyalty_plugin/utils/colors.dart';
import 'package:foop_loyalty_plugin/utils/common_helpdesk_sheet.dart';
import 'package:foop_loyalty_plugin/utils/hexColors.dart';
import 'package:foop_loyalty_plugin/utils/imagepickerAndCropper.dart';
import 'package:foop_loyalty_plugin/utils/localization.dart';
import 'package:foop_loyalty_plugin/utils/locator.dart';
import 'package:foop_loyalty_plugin/utils/someCommonMixins.dart';
import 'package:foop_loyalty_plugin/utils/text_styling.dart';
import 'package:foop_loyalty_plugin/utils/toast_builder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateLoyaltySheet extends StatefulWidget {
  final EdgeInsets padding;
  final LoyaltyItem? item;
  final Function(LoyaltyCreatePayload) doneCallback;
  final bool isEdit;

  UpdateLoyaltySheet({required this.padding, this.item,required this.doneCallback,required this.isEdit});

  @override
  UpdateLoyaltySheetState createState() => UpdateLoyaltySheetState(isEdit: isEdit);
}

class UpdateLoyaltySheetState extends State<UpdateLoyaltySheet>
    with CommonMixins {
  GlobalKey<FormState> formKey = GlobalKey();
  String? loyaltyName;
  String? loyaltyDescription;

  BasicInfo? basicInfo = BasicInfo();
  SharedPreferences prefs = locatorRewards<SharedPreferences>();
  TextEditingController loyaltyNameController = TextEditingController();
  TextEditingController loyaltyDescriptionController = TextEditingController();
  bool isEdit = false;
  String? _imageUrl;
  String? _thumbnailUrl;
  UpdateLoyaltySheetState({required this.isEdit});
  TextStyleElements ? styleElements;

  @override
  void initState() {
    if(widget.item!=null){
      isEdit= true;
      loyaltyNameController.text = widget.item!.loyaltyTypeName!;
      loyaltyDescriptionController.text = widget.item!.loyaltyTypeDescription!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
     styleElements = TextStyleElements(context);
    return CommonHelpdeskSheet(
      child: Form(
        key: formKey,
        child: Padding(
          padding: widget.padding,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppLocalizations.of(context!)!
                            .translate('create_loyalty'),
                        style: styleElements!
                            .subtitle1ThemeScalable(context)
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          if(formKey.currentState!.validate()){
                            formKey.currentState!.save();
                            widget.doneCallback(
                              LoyaltyCreatePayload(
                                businessId: basicInfo!.businessId,
                                loyaltyTypeDescription: loyaltyDescription,
                                loyaltyTypeName: loyaltyName,
                                loyaltyTypeId: widget.item!=null?widget.item!.loyaltyTypeId:null,
                                imageUrl: _imageUrl!=null?_imageUrl:widget.item!=null?widget.item!.imageUrl:null,
                              )
                            );
                          }
                        },
                        child: Padding(
                          padding:
                          EdgeInsets.only(left: 8, bottom: 8, right: 16.0),
                          child: Text(
                              AppLocalizations.of(context!)!.translate('done')),
                        ),
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              GestureDetector(
                onTap: (){

                  _showPhotoPickerSelectionSheet(
                          (value) {
                        imagePicker(value);
                      });
                },
                child: Padding(
                  padding:EdgeInsets.only( left: 12, right: 12),
                  child: Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                          color: HexColor(AppColors.appColorBackground),
                          image: DecorationImage(
                              image: isEdit?CachedNetworkImageProvider(widget.item!.imageUrl!=null?basicInfo!.baseUrl+widget.item!.imageUrl!:""):(_thumbnailUrl!=null?CachedNetworkImageProvider(basicInfo!.baseUrl+_thumbnailUrl!):AssetImage('assets/appimages/grey_bg.png',)) as ImageProvider<Object>
                          )
                      ),
                      child: isEdit?widget.item!.imageUrl!=null?Text(''):Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.image_outlined),
                            Text( AppLocalizations.of(context!)!.translate('add_loyalty_image'),textAlign: TextAlign.center,)
                          ],
                        ),
                      ):_imageUrl!=null?Text(''):Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.image_outlined),
                            Text( AppLocalizations.of(context!)!.translate('add_loyalty_image'),textAlign: TextAlign.center,)
                          ],
                        ),
                      )
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12)),
                  color: HexColor(AppColors.appColorBackground),
                ),
                child: TextFormField(
                  validator: validateTextField,
                  onSaved: (value){
                    loyaltyName = value;
                  },
                  textCapitalization: TextCapitalization.sentences,
                  controller: loyaltyNameController,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(
                          left: 16, top: 16, bottom: 8, right: 16),
                      hintText:
                      AppLocalizations.of(context!)!.translate('input_text'),
                      label: Text( AppLocalizations.of(context!)!
                          .translate('input_loyalty_name'))),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12)),
                  color: HexColor(AppColors.appColorBackground),
                ),
                child: TextFormField(
                  validator: validateTextField,
                  onSaved: (value){
                    loyaltyDescription = value;
                  },
                  textCapitalization: TextCapitalization.sentences,
                  controller: loyaltyDescriptionController,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(
                          left: 16, top: 16, bottom: 8, right: 16),
                      hintText:
                      AppLocalizations.of(context!)!.translate('input_text'),
                      label: Text( AppLocalizations.of(context!)!
                          .translate('input_loyalty_des'))),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  void _showPhotoPickerSelectionSheet(Function(String) callback) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12), topRight: Radius.circular(12))),
      builder: (BuildContext context) {
        return CommonHelpdeskSheet(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppLocalizations.of(context!)!.translate('select_an_option'),
                    style: styleElements!
                        .headline6ThemeScalable(context)
                        .copyWith(fontWeight: FontWeight.bold),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 32.0, bottom: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top:18,bottom: 18),
                      width: MediaQuery.of(context).size.width/4,
                      child: GestureDetector(
                        onTap: (){
                          callback("gallery");
                          Navigator.pop(context);
                        },
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                height: 56,
                                width: 56,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: HexColor(AppColors.appColorBackground)
                                ),
                                child: Center(
                                  child: SizedBox(
                                      width: 24,
                                      height: 24,
                                      child: Icon(Icons.photo_library_outlined)),
                                ),
                              ),
                              SizedBox(height: 6,),
                              Text(
                                "Gallery",
                                style: styleElements!.captionThemeScalable(context).copyWith(
                                    color: HexColor(AppColors.appColorBlack65)
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top:18,bottom: 18),
                      width: MediaQuery.of(context).size.width/4,
                      child: GestureDetector(
                        onTap: (){
                          callback("camera");
                          Navigator.pop(context);
                        },
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                height: 56,
                                width: 56,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: HexColor(AppColors.appColorBackground)
                                ),
                                child: Center(
                                  child: SizedBox(
                                      width: 24,
                                      height: 24,
                                      child: Icon(Icons.camera_alt_outlined)),
                                ),
                              ),
                              SizedBox(height: 6,),
                              Text(
                                "Camera",
                                style: styleElements!.captionThemeScalable(context).copyWith(
                                    color: HexColor(AppColors.appColorBlack65)
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }


  void imagePicker(String type) async {
    File? pickedFile;
    var pr = ToastBuilder().setProgressDialogWithPercent(context,'Uploading Image...');
    prefs = await SharedPreferences.getInstance();
    if(type=="gallery"){
      pickedFile = await ImagePickerAndCropperUtil().pickImage(context);
    }else{
      pickedFile = await ImagePickerAndCropperUtil().pickImageCamera(context);
    }
    // File pickedFile = await ImagePickerAndCropperUtil().pickImage(context);
    var croppedFile = await ImagePickerAndCropperUtil().cropFile(
        context, pickedFile!);
    if (croppedFile != null) {
      await pr.show();
      var contentType = ImagePickerAndCropperUtil().getMimeandContentType(
          croppedFile.path);
      await UploadFile(
          baseUrl: basicInfo!.baseUrl,
          context: context,
          token: prefs.getString("token"),
          contextId: '',
          networkCallBack: () async {
            await pr.hide();
          },
          contextType: CONTEXTTYPE_ENUM.PROFILE.type,
          ownerId: basicInfo!.userId.toString(),
          ownerType: OWNERTYPE_ENUM.PERSON.type,
          file: croppedFile,
          subContextId: '',
          subContextType: SUBCONTEXTTYPE_ENUM.ROOM.type,
          mimeType: contentType[1],
          onProgressCallback: (int value){
            pr.update(progress:value.toDouble());
          },
          contentType: contentType[0])
          .uploadFile()
          .then((value) async {
        await pr.hide();
        var imageResponse = ImageUpdateResponse.fromJson(value);

        setState(() {
          _imageUrl = imageResponse.rows!.fileUrl;
          _thumbnailUrl = imageResponse.rows!.fileThumbnailUrl;
          if(isEdit) widget.item!.imageUrl=imageResponse.rows!.fileThumbnailUrl;
        });
        await pr.hide();
      }).catchError((onError) async {
        await pr.hide();

      });
    }else{
      await pr.hide();
    }
  }


}
