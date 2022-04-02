import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foop_loyalty_plugin/NetworkFile/calls.dart';
import 'package:foop_loyalty_plugin/bloc/states/main_state.dart';
import 'package:foop_loyalty_plugin/bloc/states/states.dart';
import 'package:foop_loyalty_plugin/models/welcomeMessagesListResponse.dart';
import 'package:foop_loyalty_plugin/utils/basicInfo.dart';

typedef Item = dynamic Function(dynamic itemData);

class CubitMain extends Cubit<MainState> {
  CubitMain() : super(LoadingState());
  int page = 1;
  BasicInfo? basicInfo = BasicInfo();

  Future<void> createPost(String body, String refresh, BuildContext ctx) async {
    var res = await Calls().call(body, ctx, basicInfo!.CREATE_WELCOME_MESSAGE);
    var data = WelcomeMessagesListResponse.fromJson(res);
    if (data.statusCode == basicInfo!.statusCode) {
      emit(LoadingState());
      getWelcomeMessagesData(refresh, ctx);
    }
  }

  Future<void> getWelcomeMessagesData(String body, BuildContext ctx) async {
    var res = await Calls().call(body, ctx, basicInfo!.WELCOME_MESSAGE_LIST);
    var data = WelcomeMessagesListResponse.fromJson(res);
    if (data.statusCode == basicInfo!.statusCode) {
      data.rows != null && data.rows!.isNotEmpty
          ? emit(Loaded(list: data.rows!))
          : emit(Empty());
    } else {
      emit(ErrorState());
    }
  }

  Future<void> updateSelectedItem(bool isSelected, int indexUpdate) async {
    final currentState = state;
    var list = <dynamic>[];
    var isLastPage = false;
    var selectedItem;
    if (currentState is Loaded) {
      list = currentState.list;
      isLastPage = currentState.isLastPage;
      selectedItem = currentState.selectedItem;
      if (selectedItem != null) {
        var index = list.indexWhere((element) => element.isSelected = true);
        if (index != -1) list[index].isSelected = false;
      }

      list[indexUpdate].isSelected = isSelected;

      emit(Loaded(
          list: list,
          isLastPage: isLastPage,
          selectedItem: isSelected ? list[indexUpdate] : null));
    }
  }

  Future<void> updateCashCoins(int cash, int coins) async {
    final currentState = state;
    if (currentState is Loaded) {
      emit(Loaded(
          list: currentState.list,
          isLastPage:currentState.isLastPage,
          selectedItem: currentState.selectedItem,
          cash: cash,
          coins: coins));
    }
  }

  Future<void> updateDiscountCouponDeatails(int percentage, int coins) async {
    final currentState = state;

    if (currentState is Loaded) {
      emit(Loaded(
          list: currentState.list,
          isLastPage:currentState.isLastPage,
          selectedItem: currentState.selectedItem,
          cash: currentState.cash,
          coins: currentState.coins,
          redemptionPercentage: percentage,
          redemptionCoins: coins));
    }
  }

  Future<void> search(
      String body, BuildContext ctx, String url, Item getItem) async {
    final currentState = state;
    var selectedItem;
    if (currentState is Loaded) {
      selectedItem = currentState.selectedItem;
    }
    var res = await Calls().call(body, ctx, url);
    var data = getItem(res);
    if (data.statusCode == basicInfo!.statusCode && data.rows != null) {
      if (selectedItem != null) {
        var index =
            data.rows!.indexWhere((element) => element.id == selectedItem.id);
        if (index != -1) data.rows![index].isSelected = true;
      }
      data.rows != null && data.rows!.isNotEmpty
          ? emit(Loaded(
              list: data.rows ?? [],
              isLastPage: data.rows!.length == data.total,
              selectedItem: selectedItem))
          : emit(Empty());
    }
  }

  Future<void> loadPage(
      String body, BuildContext ctx, String url, Item getItem) async {
    if (state is LoadingStatePagination) return;
    final currentState = state;
    var selectedItem;
    var oldList = <dynamic>[];
    if (currentState is Loaded) {
      if (page != 1) {
        oldList = currentState.list;
      }
      selectedItem = currentState.selectedItem;
    }
    emit(LoadingStatePagination(list: oldList, isFirstFetch: page == 1));
    var res = await Calls().call(body, ctx, url);
    var data = getItem(res);
    if (data.statusCode == basicInfo!.statusCode && data.rows != null) {
      if (selectedItem != null) {
        var index =
            data.rows!.indexWhere((element) => element.id == selectedItem.id);
        if (index != -1) {
          data.rows![index].isSelected = true;
        }
      }

      final posts = (state as LoadingStatePagination).list;
      posts
          .addAll(data.rows != null && data.rows!.isNotEmpty ? data.rows! : []);
      page++;
      posts.isNotEmpty
          ? emit(Loaded(
              list: posts,
              isLastPage: posts.length == data.total,
              selectedItem: selectedItem))
          : emit(Empty());
    }
  }
}
