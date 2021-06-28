import 'package:flutter/material.dart';
import 'package:crypto_ticker/utilities/constants.dart';

class ShowDetails extends StatelessWidget {
  final String parameter;
  final String numericparam;
  ShowDetails(this.parameter, this.numericparam);
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(parameter, style: kparamTextStyle),
        SizedBox(width: 10,),
        Text(
          numericparam,
          style: TextStyle(
            fontFamily: 'PT Sans',
            fontSize: 25,
            fontWeight: FontWeight.w200,
            color: kRecieveColor,
          ),
        )
      ],
    );
  }
}
