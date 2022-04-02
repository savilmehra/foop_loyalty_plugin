import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart';
import 'package:html/parser.dart' as htmlparser;
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:foop_loyalty_plugin/utils/colors.dart';
import 'package:foop_loyalty_plugin/utils/hexColors.dart';
import 'package:url_launcher/url_launcher.dart';

class AppHtmlViewer extends StatefulWidget {
  final String? sourceString;
  final bool? isDetailPage;
  final bool? isNewsPage;
  final bool? isNoticeCard;
  final String? searchHighlightWord;
  final bool isEmail;

  AppHtmlViewer(
      {required Key? key,
        this.sourceString,
        this.isNewsPage,
        this.isDetailPage,
        this.searchHighlightWord,
        this.isEmail = false,
        this.isNoticeCard})
      : super(key: key);

  @override
  AppHtmlViewerState createState() => AppHtmlViewerState();
}

class AppHtmlViewerState extends State<AppHtmlViewer> {
  // bool isLoading= true;
  bool showHtmlViewer = false;
  late QuillController _controller;
  final HtmlEditorController htmlController = HtmlEditorController();
  late dom.Document document;
  @override
  void initState() {
    isDeltas();
    document = htmlparser.parse(widget.sourceString!);
    super.initState();
  }

  void highLightSearchText(String? value) {
    setState(() {
      widget.searchHighlightWord != value;
    });
  }

  @override
  Widget build(BuildContext context) {
    String? search = widget.searchHighlightWord ?? null;
    try {
      Document doc = Document.fromJson(jsonDecode(widget.sourceString!));
      _controller = QuillController(
          document: doc, selection: TextSelection.collapsed(offset: 0));
      if (widget.searchHighlightWord != null) {
        var string = _controller.plainTextEditingValue.text;
        var regex = RegExp(widget.searchHighlightWord!, caseSensitive: false);
        var matches = regex
            .allMatches(string)
            .toList(); /*string.allMatches("highly").toList();*/
        for (Match match in matches) {
          _controller.formatText(match.start, match.end - match.start,
              BackgroundAttribute("#FFFF00"));
        }
      }
      if (!widget.isDetailPage!) {
        int ln = _controller.document.toPlainText().length;
        if (widget.isNoticeCard != null && widget.isNoticeCard!) {
          if (ln > 100) {
            _controller.document.delete(99, ln - 100);
            _controller.document
                .insert(_controller.document.toPlainText().length - 1, "...");
          }
        } else {
          if (!(widget.isNewsPage != null && widget.isNewsPage!)) {
            if (ln > 165) {
              _controller.document.delete(164, ln - 165);
              _controller.document
                  .insert(_controller.document.toPlainText().length - 1, "...");
            }
          }
        }
      }
      setState(() {});
    } catch (onError) {
      showHtmlViewer = true;
      print(onError);
    }
    // return !isLoading?Builder(
    //   builder: (BuildContext context) {
    return showHtmlViewer
        ? getHtmlViewer(search)
        : AbsorbPointer(child: getQuillViewer());
    // },
    // ):PreloadingViewParagraph();
  }

  Widget getQuillViewer() {
    var defaultStyles = DefaultStyles.getInstance(context);
    /*    var htmlEditor=HtmlEditor(
       controller: htmlController,
       htmlEditorOptions: HtmlEditorOptions(

           shouldEnsureVisible: true,
           spellCheck: false,
           autoAdjustHeight:false,
           adjustHeightForKeyboard: false


         //initialText: "<p>text content initial, if any</p>",
       ),

       callbacks: Callbacks(

           onInit: () {
             if(widget.sourceString!=null && widget.sourceString!.isNotEmpty) {
            htmlController.insertHtml(widget.sourceString!);

            if(widget.searchHighlightWord!=null&& widget.sourceString!.isNotEmpty)
              {
                document = htmlparser.parse( widget.sourceString!);
                document.body?.innerHtml=document.body?.innerHtml.replaceAll(widget.searchHighlightWord!, "savil")??"";
              }
          }
        },

   ),
     );*/
    var editor = QuillEditor(
      // maxHeight:
      // (widget.isNoticeCard != null && widget.isNoticeCard) ? 150 : null,
        controller: _controller,
        focusNode: FocusNode(),
        scrollController: ScrollController(),
        scrollable: (widget.isNoticeCard != null && widget.isNoticeCard!)
            ? true
            : false,
        //   scrollable: true,
        enableInteractiveSelection: false,
        padding: EdgeInsets.only(left: 8),
        autoFocus: false,
        readOnly: true,
        expands: false,
        onLaunchUrl: _launchURL,
        customStyles: defaultStyles.merge(DefaultStyles(
            quote: getCustomBlockStyle(defaultStyles.quote!),
            indent: getCustomBlockStyle(defaultStyles.indent!),
            align: getCustomBlockStyle(defaultStyles.align!),
            h1: getCustomBlockStyle(defaultStyles.h1!),
            h2: getCustomBlockStyle(defaultStyles.h2!),
            h3: getCustomBlockStyle(defaultStyles.h3!),
            code: getCustomBlockStyle(defaultStyles.code!),
            // lists: getCustomBlockStyle(defaultStyles.lists!),
            paragraph: DefaultTextBlockStyle(
                defaultStyles.paragraph!.style.copyWith(
                    fontSize: 20, color: HexColor(AppColors.appColorBlack65)),
                defaultStyles.paragraph!.verticalSpacing,
                defaultStyles.paragraph!.lineSpacing,
                defaultStyles.paragraph!.decoration))));
    return (widget.isNoticeCard != null && widget.isNoticeCard!)
        ? editor
        : editor;
  }

  Widget getHtmlViewer(String? search) {
    return SizedBox(
      child: HtmlWidget(
        search != null
            ? document.body?.innerHtml
            .replaceAll(search, "<mark>$search</mark>") ??
            ""
            : getData(widget.sourceString!),
        onTapUrl: (url) => _launchURL(url),
        textStyle:
        TextStyle(fontSize: 20, color: HexColor(AppColors.appColorBlack65)),
      ),
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  String getData(String? meta) {
    if (meta != null) {
      if (!widget.isDetailPage!) {
        if (widget.isNewsPage != null && widget.isNewsPage!) {
          // if (meta.length > 350) {
          //   return meta.substring(0, 350) + '....';
          // } else {
          return meta;
          // }
        } else {
          if (widget.isNoticeCard != null && widget.isNoticeCard!) {
            if (meta.length > 100) {
              // print("notice eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee");
              // return meta.substring(0, 100) + '....';
              return meta;
            } else {
              return meta;
            }
          } else {
            if (meta.length > 165) {
              if (widget.isEmail) {
                return meta.substring(0, 100) + '....';
              } else {
                return _parseHtmlString(meta) ?? "";
              }
            } else {
              return meta;
            }
          }
        }
      } else {
        return meta;
      }
    } else {
      return '';
    }
  }

  String? _parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    final String? parsedString =
        parse(document.body!.text).documentElement?.text;
    if (parsedString!.length > 165)
      return (parsedString.substring(0, 150)) + '....';
    else
      return parsedString;
  }

  void isDeltas() {
    try {
      jsonDecode(widget.sourceString!);
    } catch (e) {
      showHtmlViewer = true;
    }
  }

  DefaultTextBlockStyle getCustomBlockStyle(
      DefaultTextBlockStyle defaultStyles) {
    return DefaultTextBlockStyle(
        defaultStyles.style
            .copyWith(color: HexColor(AppColors.appColorBlack65)),
        defaultStyles.verticalSpacing,
        defaultStyles.lineSpacing,
        defaultStyles.decoration);
  }
}
