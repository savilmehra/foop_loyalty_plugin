import 'main_state.dart';

class LoadingState extends MainState {}

class LoadingStatePagination extends MainState {
  List<dynamic> list = [];
  bool isFirstFetch;

  LoadingStatePagination({required this.list, this.isFirstFetch = true});

  List<dynamic> getList() => list;
}

class Loaded extends MainState {
  int? cash;
  int? coins;

  int? giftCash;
  int? giftCoin;
  int? startEpoch;
  int? endEpoch;
  int? redemptionPercentage;
  int? redemptionCoins;
  bool isLastPage;
  List<dynamic> list;
  dynamic selectedItem;

  Loaded(
      {required this.list,
      this.isLastPage = false,
      this.selectedItem,
      this.giftCash,
      this.giftCoin,
      this.startEpoch,
      this.endEpoch,
      this.coins,
      this.cash,
      this.redemptionPercentage,
      this.redemptionCoins});

  List<dynamic> getList() => list;
}

class LoadedWithData extends MainState {
  dynamic data;

  LoadedWithData({required this.data});

  dynamic getData() => data;
}

class ErrorState extends MainState {}

class RefreshPage extends MainState {}

class Empty extends MainState {}

class LoadedBankDetails extends MainState {
  dynamic bankData;
  dynamic gstData;
  dynamic address;

  LoadedBankDetails({required this.bankData, this.gstData, this.address});

  dynamic getBankData() => bankData;

  dynamic getGstData() => gstData;
}
