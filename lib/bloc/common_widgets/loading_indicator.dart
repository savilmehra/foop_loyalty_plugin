import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget

{
  @override
  Widget build(BuildContext context) {


   return Padding(
     padding: const EdgeInsets.all(8.0),
     child: Center(child: CircularProgressIndicator()),
   );
  }
}