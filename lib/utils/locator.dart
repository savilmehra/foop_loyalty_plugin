
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';


import 'localization.dart';

GetIt locatorRewards = GetIt.instance;

Future<void> setupRewardsLocator() async {

  locatorRewards.registerSingletonAsync(() async => await SharedPreferences.getInstance());
}
