import 'dart:convert';
import 'dart:io';


import 'package:cached_network_image/cached_network_image.dart';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foop_loyalty_plugin/models/imageuploadrequestandresponse.dart';
import 'package:foop_loyalty_plugin/models/postcreate.dart';
import 'package:foop_loyalty_plugin/upload_p/GlobalUploadFilePkg.dart';
import 'package:foop_loyalty_plugin/utils/text_styling.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'basicInfo.dart';
import 'camera_module/camera_page.dart';
import 'circle_button.dart';
import 'colors.dart';
import 'common_helpdesk_sheet.dart';
import 'contexttype.dart';
import 'hexColors.dart';
import 'imagepickerAndCropper.dart';
import 'localization.dart';
import 'locator.dart';
import 'ownertype.dart';

import 'package:path/path.dart' as p;

// ignore: must_be_immutable
class appAttachments extends StatefulWidget {
  Function(String?)? mentionCallback;
  Function(String)? hashTagCallback;
  bool isHashTagVisible;
  bool isMentionVisible;
  Function ? itemPickedCallBack;
  bool hideMedia;
  bool isImageVisible;
  bool isVideoVisible;

  appAttachments(Key key,{this.mentionCallback,this.hashTagCallback,this.isHashTagVisible= true, this.isMentionVisible= true,this.itemPickedCallBack,this.hideMedia=false,this.isImageVisible= true,this.isVideoVisible= true}):super(key: key);
  @override
  appAttachmentsState createState() => appAttachmentsState();
}

class appAttachmentsState extends State<appAttachments> {
  List<MediaDetails> mediaList = [];
  late TextStyleElements styleElements;
  SharedPreferences? prefs;

  TextEditingController typeAheadControllerMention =TextEditingController();
  TextEditingController typeAheadControllerHashTag =TextEditingController();
  bool isMentionActive = false;
  bool isHashTagActive = false;
  List<String?> _listOfHashTags = [];
  BasicInfo? basicInfo = BasicInfo();
  List<String?> get  getListOfTags => _listOfHashTags;

  @override
  Widget build(BuildContext context) {
    styleElements = TextStyleElements(context);
    return  Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            Visibility(
              visible: mediaList.length>0 && !widget.hideMedia,
              child: Container(
                width: double.infinity,
                height: 72,
                child: ListView.builder(
                  itemCount: mediaList.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      height: 72,
                      width: 72,
                      padding: const EdgeInsets.only(
                          left: 4, right: 4, bottom: 4, top: 4),
                      child: Stack(
                        children: [
                          Align(
                              alignment: Alignment.bottomLeft,
                              child: SizedBox(
                                height: 56,
                                width: 56,
                                child: Stack(
                                  children: [
                                    // mediaList[index].mediaType == 'video'?
                                    //     appVideoView(
                                    //       onFullPage: false,
                                    //       mediaUrl: Config.BASE_URL+mediaList[index].mediaThumbnailUrl,
                                    //     )
                                    //     :
                                    CachedNetworkImage(
                                      height: 56,
                                      width: 56,
                                      imageUrl: mediaList[index].mediaUrl??"",
                                      fit: BoxFit.cover,
                                    ),
                                    Visibility(
                                      visible: mediaList[index].mediaType == 'video',
                                      child: Container(
                                        child: Center(
                                            child:Icon(Icons.play_circle_outline_outlined,color:HexColor(AppColors.appMainColor)
                                            )
                                        ),
                                      ),
                                    ),
                                    Visibility(
                                      visible: checkFileMimeType(mediaList[index].mediaType),
                                      child: Container(
                                        child: Center(
                                            child:Icon(Icons.file_copy_outlined,color:HexColor(AppColors.appMainColor)
                                            )
                                        ),
                                      ),
                                    )

                                  ],
                                ),
                              )
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    mediaList.removeAt(index);
                                  });
                                },
                                child: Container(
                                  height: 18,
                                  width: 18,
                                  child: Image.asset('packages/loyalty_foop/assets/appimages/cancel.png',fit: BoxFit.cover,
                                  ),
                                )
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            // SingleChildScrollView(
            //   scrollDirection: Axis.horizontal,
            //   child: Row(
            //       children: [
            //
            //   ),
            // ),

            Visibility(
                visible: _listOfHashTags.length>0,
                child: Container(
                  height: 50,
                  padding: EdgeInsets.only(top: 8,bottom: 8,left:8 ,right: 8),
                  alignment: Alignment.centerLeft,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: _listOfHashTags.length,
                    padding: EdgeInsets.only(left: 8,right: 8),
                    itemBuilder: (BuildContext context, int index) {
                      return Flexible(
                        child: Chip(
                          label: Text(_listOfHashTags[index]!),
                          padding: EdgeInsets.all(8),
                          onDeleted: (){
                            setState(() {
                              _listOfHashTags.removeAt(index);
                            });
                          },
                        ),
                      );
                    },),
                )
            ),





            Card(
              elevation: 0,
              child: Row(
                children: [
                  Visibility(
                    visible: widget.isMentionVisible,
                    child: IconButton(
                      icon: Text(  AppLocalizations.of(context)!.translate('at_the_rate'),style: styleElements.headline6ThemeScalable(context).copyWith(
                          color: HexColor(AppColors.appColorBlack35)
                      ),),
                      onPressed: (){
                        setState(() {
                          if(isMentionActive){
                            isMentionActive = !isMentionActive;
                          }else{
                            isMentionActive =!isMentionActive;
                            isHashTagActive = false;
                          }
                        });
                      },
                    ),
                  ),
                  Visibility(
                    visible: widget.isHashTagVisible,
                    child: IconButton(
                      icon: Text(  AppLocalizations.of(context)!.translate('hash'),style: styleElements.headline6ThemeScalable(context).copyWith(
                          color: HexColor(AppColors.appColorBlack35)
                      ),),
                      onPressed: (){
                        setState(() {
                          if(isHashTagActive){
                            isHashTagActive = !isHashTagActive;
                          }else{
                            isHashTagActive =!isHashTagActive;
                            isMentionActive = false;
                          }
                        });
                      },
                    ),
                  ),
                  Spacer(),
                  // IconButton(
                  //     icon: Icon(Icons.file_copy_outlined,color: HexColor(AppColors.appColorBlack35),),
                  //     onPressed: () {
                  //       fileUploader();
                  //     }
                  // ),
                 /* IconButton(
                      icon: Icon(Icons.file_copy_outlined,color: HexColor(AppColors.appColorBlack35),),
                      onPressed: () {
                        fileUploader();
                      }
                  ),*/
                Visibility(
                    visible: widget.isImageVisible,
                    child: CircleButton(
                        onTap: () {
                          unFocusKeypad();
                          if (mediaList.length <= 10) {
                            _showPhotoPickerSelectionSheet((value) {
                              imagePicker(value);
                            });
                          }
                        },
                        size: 30,
                        iconsize: 20,
                        color: HexColor(AppColors.blueApp),
                        iconData: Icons.image)),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 8.0),
                  child: Visibility(
                      visible: widget.isVideoVisible,
                      child: CircleButton(
                          onTap: () {


                            if (mediaList.length <= 10) {

                              unFocusKeypad();
                              _showPhotoPickerSelectionSheet((value) {
                                videoPicker(value);
                              });
                            }

                          },
                          size: 30,
                          iconsize: 20,
                          color: HexColor(AppColors.blueApp),
                          iconData: Icons.videocam_outlined
                      )



                    ),
                  ),
                  /*  Visibility(
                    visible: false,
                    child: IconButton(
                        icon: Icon(Icons.upload_file,color: HexColor(AppColors.appColorBlack35)),
                        onPressed: () async {
                          FilePickerResult result = await FilePicker.platform.pickFiles(
                            type: FileType.custom,
                            allowedExtensions: [ 'pdf', 'doc','txt','xlsx','xlsm','xls','csv'],
                          );
                          if(result != null) {
                            File file = File(result.files.single.path);
                            PlatformFile f = result.files.first;
                            fileUploader(file,f.extension);
                          } else {
                            // User canceled the picker
                          }
                        }
                    ),
                  )*/
                ],
              ),
            )
          ],
        ),
      );

  }


  void _showPhotoPickerSelectionSheet(Function(String) callback) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
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
                      AppLocalizations.of(context)!.translate('select_an_option'),
                    style: styleElements
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
                      margin: EdgeInsets.only(top: 18, bottom: 18),
                      width: MediaQuery.of(context).size.width / 4,
                      child: GestureDetector(
                        onTap: () {
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
                                    color:
                                        HexColor(AppColors.appColorBackground)),
                                child: const Center(
                                  child: SizedBox(
                                      width: 24,
                                      height: 24,
                                      child:
                                          Icon(Icons.photo_library_outlined)),
                                ),
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              Text(
                                "Gallery",
                                style: styleElements
                                    .captionThemeScalable(context)
                                    .copyWith(
                                        color: HexColor(
                                            AppColors.appColorBlack65)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 18, bottom: 18),
                      width: MediaQuery.of(context).size.width / 4,
                      child: GestureDetector(
                        onTap: () {
                          unFocusKeypad();

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
                                    color:
                                        HexColor(AppColors.appColorBackground)),
                                child: const Center(
                                  child: SizedBox(
                                      width: 24,
                                      height: 24,
                                      child: Icon(Icons.camera_alt_outlined)),
                                ),
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              Text(
                                "Camera",
                                style: styleElements
                                    .captionThemeScalable(context)
                                    .copyWith(
                                        color: HexColor(
                                            AppColors.appColorBlack65)),
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
   prefs ??= await SharedPreferences.getInstance();
    if(type=="gallery"){
      pickedFile = await ImagePickerAndCropperUtil().pickImage(context);

    }else{
      final cameras = await availableCameras();
      var reult = await Navigator.push(context,
          MaterialPageRoute(builder: (context) => Camera(cameras: cameras,type: "camera",)));
      File p = File(reult["result"]);
      pickedFile = await ImagePickerAndCropperUtil().cropFileMulti(context, p);
   }
    // File pickedFile = await ImagePickerAndCropperUtil().pickImage(context);
    // var croppedFile = await ImagePickerAndCropperUtil().cropFile(
    //     context, pickedFile);
    if (pickedFile != null) {

      var contentType =

      ImagePickerAndCropperUtil().getMimeandContentType(
          pickedFile.path);

      await UploadFile(


          baseUrl: basicInfo!.baseUrl,
          context: context,
          token: prefs!.getString("token"),
          contextId: '',

          networkCallBack: () async { },
          contextType: CONTEXTTYPE_ENUM.FEED.type,
          ownerId:basicInfo!.userId.toString(),
          ownerType: OWNERTYPE_ENUM.PERSON.type,
          file: pickedFile,
          subContextId: "",
          subContextType: "",
          onProgressCallback: (int value){

          },
          mimeType: contentType[1],
          contentType: contentType[0])
          .uploadFile()
          .then((value) async {

        var imageResponse = ImageUpdateResponse.fromJson(value);
        print (jsonEncode(imageResponse));
        if(imageResponse.statusCode == basicInfo!.statusCode) {
          addImage(
              imageResponse.rows!.fileUrl, imageResponse.rows!.fileThumbnailUrl,
              "image");

        }else{
       }
      }).catchError((onError) async {
    });
    }else{

    }
  }
  void fileUploader() async {
    File? pickedFile;
    prefs ??= await SharedPreferences.getInstance();
    pickedFile = await ImagePickerAndCropperUtil().pickFiles(context);
    if (pickedFile != null) {

      var contentType = ImagePickerAndCropperUtil().getMimeandContentType(pickedFile.path);
      await UploadFile(
          baseUrl: basicInfo!.baseUrl,
          context: context,
          token: prefs!.getString("token"),
          contextId: '',
          networkCallBack: () async {

          },
          contextType: CONTEXTTYPE_ENUM.FEED.type,
          ownerId: basicInfo!.userId.toString(),
          ownerType: OWNERTYPE_ENUM.PERSON.type,
          onProgressCallback: (int value){

          },
          file: pickedFile,
          subContextId: "",
          subContextType: "",
          mimeType: contentType[1],
          contentType: contentType[0])
          .uploadFile()
          .then((value) async {


        var imageResponse = ImageUpdateResponse.fromJson(value);

        if(imageResponse.statusCode ==  basicInfo!.statusCode) {


         addImage(
              imageResponse.rows!.fileUrl, imageResponse.rows!.fileThumbnailUrl,
             getExtension(context, pickedFile!.path));
        }
      }).catchError((onError) async {
     });
    }else{
    }
  }
  void videoPicker(String type) async {
    File? pickedFile;
    prefs = await SharedPreferences.getInstance();
    if(type=="gallery"){
      pickedFile = await ImagePickerAndCropperUtil().pickVideo(context);
    }else{
      pickedFile = await ImagePickerAndCropperUtil().pickVideoCamera(context);
   }

    // File pickedFile = await ImagePickerAndCropperUtil().pickImage(context);
    // var croppedFile = await ImagePickerAndCropperUtil().cropFile(
    //     context, pickedFile);
    if (pickedFile != null) {
      int sizeInBytes = pickedFile.lengthSync();
      double sizeInMb = sizeInBytes / (1024 * 1024);
      if(sizeInMb>100){
    }else {

        var contentType = ImagePickerAndCropperUtil().getMimeandContentType(
            pickedFile.path);
        await UploadFile(
            baseUrl:  basicInfo!.baseUrl,
            context: context,
            networkCallBack: () async {

            },
            token: prefs!.getString("token"),
            contextId: '',
            contextType: CONTEXTTYPE_ENUM.FEED.type,
            ownerId:  basicInfo!.userId.toString(),
            ownerType: OWNERTYPE_ENUM.PERSON.type,
            file: pickedFile,
            subContextId: "",
            subContextType: "",
            onProgressCallback: (int progress) {

            },
            mimeType: contentType[1],
            contentType: contentType[0])
            .uploadFile()
            .then((value) async {
          var imageResponse = ImageUpdateResponse.fromJson(value);

          if (imageResponse.statusCode ==  basicInfo!.statusCode) {
            addImage(
                imageResponse.rows!.fileUrl,
                imageResponse.rows!.fileThumbnailUrl,
                "video");

          }
        }).catchError((onError) async {
      });
      }
    }else{
    }
  }
  void addImage(String? mediaUrl,String? mediaThumbnailUrl, String mediaType) {
    setState(() {

      mediaList.add(MediaDetails(mediaType: mediaType, mediaUrl: mediaUrl,mediaThumbnailUrl: mediaThumbnailUrl));
      if(widget.itemPickedCallBack!=null) {

        widget.itemPickedCallBack!();
      }
    });
  }

  int getcount() {
    return mediaList.length;
  }
  @override
  void initState() {

    super.initState();
  }

  /*  uploadSharedImages(List<SharedMediaFile> sharedFiles)
    async {
      for(var item in widget.sharedFiles )
      {
        uploadFiles(item.path,"image");
      }

    }*/



    uploadFiles(String path, String type)
    async {
      File pickedFile=new File(path);
      prefs ??= await SharedPreferences.getInstance();

     {

        var contentType =ImagePickerAndCropperUtil().getMimeandContentType(pickedFile.path);
        await UploadFile(
            baseUrl:  basicInfo!.baseUrl,
            context: context,
            token: prefs!.getString("token"),
      contextId: '',
            networkCallBack: () async {
             // await pr.hide();
            },
      contextType: CONTEXTTYPE_ENUM.FEED.type,
      ownerId:  basicInfo!.userId.toString(),
      ownerType: OWNERTYPE_ENUM.PERSON.type,
      onProgressCallback: (int value){

      },
      file: pickedFile,
      subContextId: "",
      subContextType: "",
      mimeType: contentType[1],
      contentType: contentType[0])
          .uploadFile()
          .then((value) async {

    var imageResponse = ImageUpdateResponse.fromJson(value);

    addImage(imageResponse.rows!.fileUrl, imageResponse.rows!.fileThumbnailUrl, "image");
    }).catchError((onError) async {

    });
    }
    }


  bool checkFileMimeType(String? mimeType) {
    return (mimeType == 'pdf' ||
        mimeType == 'ppt' ||
        mimeType == 'pptx' ||
        mimeType == 'docx' ||
        mimeType == 'doc' ||
        mimeType == 'jpg' ||
        mimeType == 'png' ||
        mimeType == 'jpeg' ||
        mimeType == 'mp4' ||
        mimeType == 'xlsx' ||
        mimeType == 'xls');
  }

  String getExtension(BuildContext context, String path, [int level = 1]) {

    return p.context.extension(path, level).substring(1);
  }
    void unFocusKeypad()
    {

      SystemChannels.textInput.invokeMethod('TextInput.hide');
      if(Platform.isIOS)
        hideKeyboardIos(context);
    }

  void hideKeyboardIos(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }
  }

