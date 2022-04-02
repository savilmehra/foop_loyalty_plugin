

import 'dart:async';

import 'package:flutter/material.dart';

typedef ItemBuilder= Widget Function(dynamic itemData,int index);

typedef Item= dynamic Function(dynamic itemData);
class PaginatorListView  extends StatelessWidget
{

 final  bool isLoading ;
  final ScrollController  scrollController;
  final  List<dynamic>list ;

  final ItemBuilder itemBuilder;

   PaginatorListView({Key? key,required this.list,required this.itemBuilder,required this.scrollController,required this.isLoading}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    
    
    return   ListView.separated(
      controller: scrollController,
      itemBuilder: (context, index) {
        if (index < list.length)
          return _itemBuilder(list[index],index);
        else {
          Timer(Duration(milliseconds: 30), () {
            scrollController
                .jumpTo(scrollController.position.maxScrollExtent);
          });

          return _loadingIndicator();
        }
      },
      separatorBuilder: (context, index) {
        return Divider(
          color: Colors.grey[400],
        );
      },
      itemCount: list.length + (isLoading ? 1 : 0),
    );
  }

  Widget _loadingIndicator() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(child: CircularProgressIndicator()),
    );
  }


  Widget _itemBuilder(dynamic data,int index) {
    return itemBuilder(data,index);
  }
}