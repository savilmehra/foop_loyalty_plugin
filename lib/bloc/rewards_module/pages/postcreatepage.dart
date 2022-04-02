import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


import 'package:flutter/cupertino.dart';
import 'package:html/parser.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:foop_loyalty_plugin/NetworkFile/calls.dart';
import 'package:foop_loyalty_plugin/models/postcreate.dart';
import 'package:foop_loyalty_plugin/models/postlist.dart';
import 'package:foop_loyalty_plugin/utils/appAttachmentComponent.dart';
import 'package:foop_loyalty_plugin/utils/appAvatar.dart';
import 'package:foop_loyalty_plugin/utils/app_buttons.dart';
import 'package:foop_loyalty_plugin/utils/basicInfo.dart';
import 'package:foop_loyalty_plugin/utils/colors.dart';
import 'package:foop_loyalty_plugin/utils/custom_app_bar.dart';
import 'package:foop_loyalty_plugin/utils/customcard.dart';
import 'package:foop_loyalty_plugin/utils/hexColors.dart';
import 'package:foop_loyalty_plugin/utils/localization.dart';
import 'package:foop_loyalty_plugin/utils/locator.dart';
import 'package:foop_loyalty_plugin/utils/resolutionenums.dart';
import 'package:foop_loyalty_plugin/utils/serviceTypeEnums.dart';
import 'package:foop_loyalty_plugin/utils/someCommonMixins.dart';
import 'package:foop_loyalty_plugin/utils/text_styling.dart';
import 'package:foop_loyalty_plugin/utils/toast_builder.dart';
import 'package:foop_loyalty_plugin/utils/utility_class.dart';
import 'package:foop_loyalty_plugin/utils/wordcounterchecker.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// This the page used to create all types of posts
/// General Feed Post
/// Blog Post
/// Notice/Circular post
/// News Post
/// Questions answer post
/// Polls and voting post
// ignore: must_be_immutable
class PostCreatePage extends StatefulWidget {
  String? type;
  String? question;
  int? postId;
  final bool isWelcomeMessage;
  String? text;

  final String? contentData;
  final bool isEdit;
  final Function? callBack;
  final String? titleLesson;
  final String? topicName;
  final List<Media>? mediaFromEdit;
  final int? lessonNumber;

  PostCreatePage(
      {this.type,
      this.question,
      this.postId,
      this.text,
      this.mediaFromEdit,
      this.titleLesson,

      this.callBack,
      this.topicName,

      this.isEdit = false,
      this.lessonNumber,
      this.isWelcomeMessage = false,
      this.contentData});

  @override
  _PostCreatePage createState() => _PostCreatePage(
      type: type,
      question: question,
      postId: postId,
      text: text,
      lessonNumber: lessonNumber ?? 1);
}

class _PostCreatePage extends State<PostCreatePage> with CommonMixins {
  String? title, subTitle, weblink;
  late TextStyleElements styleElements;
  String? type = 'feed';
  String? text;
  bool isSavingDraft = false;
  final titleController = TextEditingController();
  final SharedPreferences prefs = locatorRewards<SharedPreferences>();
  String? _selectedColor = AppColors.information;
  String? question;
  int? postId;
  String? questionContent;
  String urlPreview = "";
  BasicInfo? basicInfo = BasicInfo();
  String? postOwnerType;
  String? image_url;

  bool isLessonAlreadyAdded = false;
  int? postOwnerTypeId;
  List<String> mentions = [];
  List<String> keywords = [];
  int wordCount = 0;
  int wordLimit = 200;
  BuildContext? ctx;
  final avatarKey = GlobalKey<appAvatarState>();

  GlobalKey<WordCounterCheckerState> wordCounterKey = GlobalKey();
  int lessonNumber;

  _PostCreatePage({
    this.type,
    this.question,
    this.postId,
    this.text,
    this.lessonNumber = 1,
  });

  TextEditingController subtitleController = TextEditingController();

  final HtmlEditorController _controller = HtmlEditorController();

  final FocusNode _focusNode = FocusNode();
  GlobalKey<appAttachmentsState> attachmentKey = GlobalKey();

  final formKey = GlobalKey<FormState>();
  List<MediaDetails> mediaList = [];



  ///Text editing controllers for the text fields in this page
  TextEditingController editingController1 = TextEditingController();
  TextEditingController editingController2 = TextEditingController();
  TextEditingController editingController3 = TextEditingController();
  TextEditingController editingController4 = TextEditingController();
  int optionsCount = 2;

  bool isAssignmentDetails = false;
  PostCreatePayload? detailsPayload;

  /// method to initialize shared preferences and pre-build load time data
  void setPref() {

    postOwnerTypeId =basicInfo!.userId;
    postOwnerType = 'person';
    image_url ="";
  }

  /// this method is used to load preloaded into the fields
  getSharedData() async {
    if (text != null && text!.isNotEmpty) {
      _controller.insertText(text!);
    }

    if (widget.mediaFromEdit != null && widget.mediaFromEdit!.isNotEmpty) {
      await Future.forEach(widget.mediaFromEdit!, (dynamic item) async {
        MediaDetails mediaDetails = MediaDetails();
        mediaDetails.mediaUrl = item.mediaUrl;
        mediaDetails.mediaType = item.mediaType;
        mediaDetails.mediaThumbnailUrl = item.mediaThumbnailUrl;

        mediaList.add(mediaDetails);
        setState(() {
          attachmentKey.currentState!.mediaList = mediaList;
        });
      });
    }
  }

  @override
  initState() {
    setPref();
    super.initState();
    addControllerListener();

    WidgetsBinding.instance!.addPostFrameCallback((_) {

      getSharedData();


if(type!="answer")
      FocusScope.of(context).requestFocus(_focusNode);

    });

    if (type == "news") {
      setState(() {
        wordLimit = 60;
      });
    }
  }

  void addControllerListener() {}



  /// After sending the content this method is used to clear the content
  void clearData() async {
    title = null;
    titleController.clear();
    _controller.clear();
    FocusScope.of(context).unfocus();
    attachmentKey.currentState!.mediaList.clear();
    _focusNode.unfocus();

    addControllerListener();
    setState(() {});
  }

  // ignore: missing_return
  Future<bool>? _onBackPressed() {
    Navigator.pop(context);
    return new Future(() => false);
  }

  @override
  Widget build(BuildContext context) {
    styleElements = TextStyleElements(context);
    this.ctx = context;
    if (type == 'lesson') {
      wordLimit = 100;
    } else if (type == 'news') {
      wordLimit = 60;
    }

    final form = Column(
      children: [
        GestureDetector(
          onTap: () {

          },
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(right: 12.0),
                child: InkWell(
                  onLongPress: () {
                    // _showSelectorBottomSheet(context);
                  },
                  child: appAvatar(
                    key: avatarKey,
                    size: 36,
                    resolution_type: RESOLUTION_TYPE.R64,
                    service_type: postOwnerType == 'person'
                        ? SERVICE_TYPE.PERSON
                        : SERVICE_TYPE.BUSINESS,
                    imageUrl: image_url,
                  ),
                ),
              ),
              Expanded(
                  child:
                  widget.isWelcomeMessage?
                  Text(
                   'You are creating welcome post',
                    style: styleElements.captionThemeScalable(context),
                  ):
                  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    (type == 'answer')
                        ? 'You are answering'
                        : 'You are creating',
                    style: styleElements.captionThemeScalable(context),
                  ),
                  (type == 'answer')
                      ? Text(
                          question!,
                          style: styleElements.subtitle1ThemeScalable(context),
                        )
                      : Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              getTitle(),
                              style:
                                  styleElements.subtitle1ThemeScalable(context),
                            ),
                            Icon(Icons.arrow_drop_down_rounded)
                          ],
                        ),
                ],
              )),
              Visibility(
                  visible: !(type == 'answer' ||
                      type == 'feed' ||
                      type == 'blog' ||
                      type == 'lesson' ||
                      type == 'celebrate'),
                  child: IconButton(
                    onPressed: () {

                    },
                    icon: Icon(Icons.note_add_outlined),
                  )),
            ],
          ),
        ),
        Expanded(child: getContentArea()),
        Visibility(
          visible: type != 'answer',
          child: appAttachments(
            attachmentKey,
            isMentionVisible: false,
            isImageVisible: type != 'celebrate',
            isVideoVisible: type != 'celebrate',
            hashTagCallback: (value) async {
              keywords.add(value);
              setState(() {
                _controller.insertText(' #' + value + ' ');
              });
            },
          ),
        ),
      ],
    );

    final result = WillPopScope(
        // ignore: missing_return
        onWillPop: () {


          return new Future(() => false);
        },
        child: SafeArea(
            child: Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: appAppBar().getCustomAppBar(context,
              centerTitle: type != 'lesson',
              actions: [

                isSavingDraft
                    ? Container(
                        margin: const EdgeInsets.only(right: 16),
                        child: Center(
                          child: SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      )
                    : appTextButton(
                        onPressed: () async {
                          if (widget.isWelcomeMessage) {
                            String html = await _controller.getText();
                            if (html.trim().isNotEmpty && title!.isNotEmpty) {

                              Navigator.of(context).pop({ "postData" : getPostPayload(
                              html,
                              title,
                              subTitle,
                              attachmentKey.currentState!.mediaList,
                              )});

                            } else {
                              if (title!.isEmpty) {
                                ToastBuilder().showToast(
                                    AppLocalizations.of(context!)!
                                        .translate("add_title"),
                                    context,
                                    HexColor(AppColors.information));
                              }

                              if (html.trim().isEmpty) {
                                ToastBuilder().showToast(
                                    AppLocalizations.of(context!)!
                                        .translate("add_content"),
                                    context,
                                    HexColor(AppColors.information));
                              }
                            }
                          }
                          },
                        child: Wrap(
                          direction: Axis.horizontal,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Text(
                              type == 'answer'
                                  ? AppLocalizations.of(context!)!
                                      .translate('submit')
                                  : AppLocalizations.of(context!)!
                                      .translate('next'),
                              style: styleElements
                                  .headline6ThemeScalableW(context)
                                  .copyWith(color: HexColor(AppColors.blueApp)),
                            ),
                            Icon(Icons.keyboard_arrow_right,
                                color: HexColor(AppColors.blueApp))
                          ],
                        ),
                        shape: CircleBorder(),
                      ),
                // Icon(Icons.keyboard_arrow_right)
              ],
              appBarTitle: getAppBarTitle(), onBackButtonPress: () {

          }),
          body: Form(
            key: formKey,
            child: appListCard(child: form),
          ),
        )));
    return result;
  }



  /// return general post type widget
  Widget buildEditor() {
    return getEditor(HexColor(AppColors.appColorWhite), "feed");
  }

  Widget getLessons() {
    return Container(
        margin: EdgeInsets.all(0),
        child: getEditor(HexColor(AppColors.appColorWhite), "lesson"));
  }

  Widget getBlogEditor() {
    return Container(
        margin: EdgeInsets.all(0),
        child: getEditor(HexColor(AppColors.appColorWhite), "blog"));
  }




  /// Common method used by almost every post-type for showing wysiwyg editor
  Widget getEditor(Color color, String name) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            name == "lesson" || name == 'answer'
                ? Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Text(
                      name == "lesson"
                          ? AppLocalizations.of(context!)!.translate(
                              'write_title',
                              arguments: {"type": lessonNumber.toString()})
                          : name == 'answer'
                              ? AppLocalizations.of(context!)!
                                  .translate('write_answer')
                              : "",
                      style: styleElements
                          .headline6ThemeScalable(context)
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                  )
                : Container(),
            Expanded(
              child: Visibility(
                visible:  name != 'answer',
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: TextFormField(
                    controller: titleController,
                    focusNode: _focusNode,
                    validator: validateTextField,
                    onChanged: (value) {
                      title = value;
                    },
                    maxLength: 120,
                    textCapitalization: TextCapitalization.sentences,
                    style: styleElements
                        .headline6ThemeScalable(context)
                        .copyWith(fontWeight: FontWeight.w600),
                    decoration: InputDecoration(
                        hintText:

                        widget.isWelcomeMessage?
                        AppLocalizations.of(context!)!
                            .translate('welcome_title'):

                        name == "lesson"
                            ? AppLocalizations.of(context!)!
                                .translate('write_title_name')
                            : name == "news"
                                ? AppLocalizations.of(context!)!
                                    .translate('write_heading_news')
                                : name == "blog"
                                    ? AppLocalizations.of(context!)!
                                        .translate('write_heading_blog')
                                    : name == "circular"
                                        ? AppLocalizations.of(context!)!
                                            .translate('write_heading_notice')
                                        : name == "feed"
                                            ? AppLocalizations.of(context!)!
                                                .translate('write_heading_feed')
                                            : "",
                        border: InputBorder.none,
                        hintStyle: styleElements
                            .headline6ThemeScalable(context)
                            .copyWith(
                                fontWeight: FontWeight.w600,
                                color: HexColor(AppColors.appColorBlack35)),
                        contentPadding: EdgeInsets.symmetric(horizontal: 16)),
                  ),
                ),
              ),
            ),
          ],
        ),
        Expanded(
          child: Container(
            color: color,
            margin: EdgeInsets.all(0),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: HtmlEditor(
                    controller: _controller,
                    htmlEditorOptions: HtmlEditorOptions(
                        hint: 'Your content here...',
                        shouldEnsureVisible: true,
                        spellCheck: false,
                        autoAdjustHeight: false,
                        adjustHeightForKeyboard: false
                        //initialText: "<p>text content initial, if any</p>",
                        ),
                    htmlToolbarOptions: HtmlToolbarOptions(
                      toolbarPosition: ToolbarPosition.belowEditor,
                      //by default
                      toolbarType: ToolbarType.nativeScrollable,

                      defaultToolbarButtons: [
                        OtherButtons(
                            help: false,
                            fullscreen: false,
                            copy: false,
                            paste: false,
                            codeview: false),
                        FontButtons(superscript: false, subscript: false),
                        ColorButtons(),
                        InsertButtons(
                            video: false,
                            audio: false,
                            table: false,
                            hr: false,
                            picture: type == "blog" ? true : false),
                        StyleButtons(),
                        ParagraphButtons(
                          textDirection: false,
                          lineHeight: false,
                          caseConverter: false,
                        )
                      ],
                      onButtonPressed: (ButtonType type, bool? status,
                          Function()? updateStatus) {
                        if (type == ButtonType.highlightColor) {
                          SystemChannels.textInput
                              .invokeMethod('TextInput.hide');
                          FocusScopeNode currentFocus = FocusScope.of(context);
                          if (!currentFocus.hasPrimaryFocus &&
                              currentFocus.focusedChild != null) {
                            FocusManager.instance.primaryFocus?.unfocus();
                          }
                        }

                        return true;
                      },
                      onDropdownChanged: (DropdownType type, dynamic changed,
                          Function(dynamic)? updateSelectedItem) {
                        return true;
                      },
                      mediaLinkInsertInterceptor:
                          (String url, InsertFileType type) {

                        return true;
                      },
                    ),
                    otherOptions: OtherOptions(
                        height: MediaQuery.of(context).size.height - 200),
                    callbacks: Callbacks(onInit: () {



                  }, onBeforeCommand: (String? currentHtml) {

                    }, onChangeContent: (String? changed) async {
                      var editingValue = await _controller.getText();
                      wordCount =
                          Utility().getWordsCountFromRegexPost(editingValue);
                      if (type == 'news' || type == 'lesson') {
                        wordCounterKey.currentState!.updateWidget(wordCount);
                      }
                    }, onChangeCodeview: (String? changed) {

                    }, onChangeSelection: (EditorSettings settings) {

                    }, onDialogShown: () {

                    }, onEnter: () {

                    }, onFocus: () {
                      _controller.editorController!.evaluateJavascript(
                          source: "document.getElementById('yourId').focus();");

                      _controller.setHint("");
                      _focusNode.unfocus();

                    }, onBlur: () {

                    }, onBlurCodeview: () {

                    },
                        //this is commented because it overrides the default Summernote handlers
                        onImageLinkInsert: (String? url) {

                    }, onImageUpload: (FileUpload file) async {

                    }, onImageUploadError: (FileUpload? file, String? base64Str,
                            UploadError error) {

                      if (file != null) {

                      }
                    }, onKeyDown: (int? keyCode) {

                    }, onKeyUp: (int? keyCode) {

                    }, onMouseDown: () {

                    }, onMouseUp: () {

                    }, onNavigationRequestMobile: (String url) {

                      return NavigationActionPolicy.ALLOW;
                    }, onPaste: () {

                    }, onScroll: () {

                    }),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                    child: Visibility(
                      visible: type == 'news' || type == 'lesson',
                      child: WordCounterChecker(
                        key: wordCounterKey,
                        currentWordCount: wordCount,
                        wordLimit: wordLimit,
                        isMinimumWords: type == 'lesson',
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// method used to get controller according to the option selected for poll
  TextEditingController _getController(int index) {
    if (index == 0) {
      return editingController1;
    } else if (index == 1) {
      return editingController2;
    } else if (index == 2) {
      return editingController3;
    } else {
      return editingController4;
    }
  }

  /// method used for adding and removing poll options
  void addRemoveOption(bool addRemove) {
    setState(() {
      if (addRemove) {
        optionsCount++;
      } else {
        optionsCount--;
      }
    });
  }

  /// This method is used to get page title String according to post type
  getAppBarTitle() {
    switch (type) {
      case 'feed':
        {

          return   widget.isWelcomeMessage?
         "Create Post Template": "Create Post";
        }

      case 'lesson':
        {
          return "Create Tutorial";
        }
      case 'blog':
        {
          return "Create Blog";
        }
      case 'qa':
        {
          return "Create Questions";
        }
      case 'notice':
        {
          return 'Create Circular';
        }
      case 'goal':
        {
          return 'Create Goals';
        }
      case 'answer':
        {
          return 'Answer';
        }
      case 'poll':
        {
          return "Create Poll";
        }
      case 'news':
        {
          return "Create Newsletter";
        }
      case 'celebrate':
        {
          return "Celebrate";
        }
      default:
        {
          return 'default';
        }
    }
  }

  /// this method is used to get title string according to the post type
  String getTitle() {
    switch (type) {
      case 'feed':
        {
          return "Feed Post";
        }
      case 'blog':
        {
          return "Blog";
        }
      case 'qa':
        {
          return "Ask Question";
        }
      case 'notice':
        {
          return 'Notice/Circular';
        }
      case 'goal':
        {
          return 'Goals';
        }
      case 'answer':
        {
          return "Answer";
        }
      case 'poll':
        {
          return "Poll";
        }
      case 'news':
        {
          return "News";
        }
      case 'lesson':
        {
          return "Tutorial";
        }
      case 'celebrate':
        {
          return "Celebrate";
        }
      default:
        {
          return 'default';
        }
    }
  }

  /// this method use to get widgets according to the post type
  Widget getContentArea() {
    switch (type) {
      case 'feed':
        {
          return buildEditor();
        }

      default:
        {
          return buildEditor();
        }
    }
  }


  /// This method return the post payload for the specified post type
  PostCreatePayload getPostPayload(String? html, String? title,
      String? subTitle, List<MediaDetails> mediaList) {
    PostCreatePayload payload = PostCreatePayload();

    payload.postId = null;
    payload.id =null;
    payload.contentMeta =
        ContentMetaCreate(meta: html, others: null, title: title);
    payload.postSubTypes = type == 'news'
        ? detailsPayload != null
            ? detailsPayload!.postSubTypes
            : null
        : null;
    payload.sourceLink =
        detailsPayload != null ? detailsPayload!.sourceLink : null;
    payload.postOwnerType = postOwnerType;
    payload.postOwnerTypeId = postOwnerTypeId;
    payload.postCreatedById = basicInfo!.userId;
    payload.postBusinessId =basicInfo!.businessId;
    payload.postType = type != null
        ? type == 'feed'
            ? 'general'
            : type
        : 'general';
    payload.postStatus = 'posted';
    payload.postCategory = 'normal';
    payload.mediaDetails = mediaList;
    payload.postMentions = mentions;
    payload.postKeywords = attachmentKey.currentState!.getListOfTags;
    if (type == 'notice') {
      payload.postColor = _selectedColor;
    }
    return payload;
  }





  void createPost(PostCreatePayload payload) async {
    if (payload.id != null) payload.postStatus = "posted";
    var body = jsonEncode(payload);
    Calls().call(body, context, basicInfo!.CREATE_POST).then((value) {
      var res = PostCreateResponse.fromJson(value);
      if (res.statusCode ==basicInfo!.statusCode) {
        Navigator.pop(context, true);
        if (widget.callBack != null) widget.callBack!();
      } else {
        ToastBuilder()
            .showToast(res.message!, context, HexColor(AppColors.information));
      }
    }).catchError((onError) {

    });
  }
}
