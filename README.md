# foop_loyalty_plugin

A loyalty management tool

## Getting Started

This project is a starting point for a Flutter
[plug-in package](https://flutter.dev/developing-packages/),
a specialized package that includes platform-specific implementation code for
Android and/or iOS.

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.



Note: add responsive_framework: ^0.1.7

void main() {
runApp( MainApp());
setupRewardsLocator();
}



class MainApp extends StatefulWidget {

static Future<void> setLocale(BuildContext context, Locale locale) async {
MyApp state = context.findAncestorStateOfType<MyApp>()!;
state.setLocale(locale);
}

MyApp createState() => MyApp();
}



class MyApp extends State<MainApp> {

Locale? _locale;
void setLocale(Locale locale) {
setState(() {
_locale = locale;
});
}

@override
initState() {
super.initState();
if (_locale == null) {
setLocale(const Locale("en",
"IN"));
}
}
@override
Widget build(BuildContext context) {
SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
statusBarColor: HexColor(AppColors.appColorTransparent),
statusBarBrightness: Brightness.dark,
statusBarIconBrightness: Brightness.dark));


    return MaterialApp(
      home:  MyHomePage(),
      builder: (context, widget) => ResponsiveWrapper.builder(
        BouncingScrollWrapper.builder(context, widget!),
        maxWidth: 1200,
        minWidth: 450,
        defaultScale: true,
        breakpoints: [
          ResponsiveBreakpoint.resize(450, name: MOBILE),
          ResponsiveBreakpoint.autoScale(800, name: TABLET),
          ResponsiveBreakpoint.autoScale(1000, name: TABLET),
          ResponsiveBreakpoint.resize(1200, name: DESKTOP),
          ResponsiveBreakpoint.autoScale(2460, name: "4K"),
        ],
        background: Container(
          color: HexColor(AppColors.appColorBackground),
        ),
      ),
      locale: _locale,
      themeMode: ThemeMode.light,
      supportedLocales: const [
        Locale("en", "US"),
        Locale("hi", "IN"),
        Locale("ta", "IN"),
        Locale("te", "IN"),
        Locale("ur", "IN"),
      ],
      localizationsDelegates: const [
        AppLocalizations.delegate,

      ],
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale!.languageCode &&
              supportedLocale.countryCode == locale.countryCode) {
            return supportedLocale;
          }
        }
        return supportedLocales.first;
      },
      debugShowCheckedModeBanner: false,
    );


}
}

class MyHomePage extends StatefulWidget {


@override
State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

@override
Widget build(BuildContext context) {

    return Scaffold(

      body: BlocProvider(
        create: (_) => CubitMain(),
        child:

        ManageRewardsPage(
          appLanguageCode: "en",
          dateFormat: 'dd-MMM-yyyy',
          timeFormat: "HH:mm",
          baseUrlWithoutHttp: "test.foop.com",
          googleTranslationKey: "google key",
          businessId: 1638510830197,
          userImage: "/media/person/profile/1638510631340/1646897564696_2927.jpg",
          userName: "Tara R Shah",
          userId: 1638510631340,
          token: "token",
          baseUrl:"https://test.foop.com",
        ),
      ),

    );
}
}
