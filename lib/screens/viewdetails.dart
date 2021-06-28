import 'package:crypto_ticker/services/crypto_service.dart';
import 'package:flutter/material.dart';
import 'package:crypto_ticker/utilities/constants.dart';
import 'package:provider/provider.dart';
import 'dart:collection';
import 'package:intl/intl.dart' as intl;
import 'package:syncfusion_flutter_charts/charts.dart';
import 'dart:async';
import 'package:crypto_ticker/components/showdetails.dart';

class ViewDetails extends StatefulWidget {
  final String cryptoName;
  final int index;
  ViewDetails(this.cryptoName, this.index);
  @override
  _ViewDetailsState createState() => _ViewDetailsState();
}

class _ViewDetailsState extends State<ViewDetails> {
  Queue<Coin> queue = Queue();
  bool isLoading = true;
  var _timer;
  double price1;
  String price;
  var dynamictime;
  Future<void> setPrice() async {
    await Provider.of<CryptoService>(context, listen: false).getCryptoQuotes();
    if (mounted) {
      setState(() {
        isLoading = false;
        String _newPrice = Provider.of<CryptoService>(context, listen: false)
            .price[widget.index];
        print('New Price is: $_newPrice');
        dynamictime = DateTime.now();
        print('Time is : $dynamictime');
        queue.add(Coin(_newPrice, dynamictime));
      });
    }
    if (queue.length > 100) {
      queue.removeFirst();
    }
  }

  @override
  void initState() {
    super.initState();
    dynamictime = DateTime.now();
    const oneSec = const Duration(seconds: 2);
    _timer = Timer.periodic(oneSec, (Timer t) => setPrice());
  }

  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(gradient: kgradient),
        ),
        title: Center(
          child: Text(widget.cryptoName, style: TextStyle(fontFamily: 'Oswald',
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: kRecieveColor),
          ),
        ),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
              color: kRecieveColor,
            ))
          : Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(gradient: kgradient),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 5,
                      child: SfCartesianChart(
                        enableAxisAnimation: true,
                        primaryXAxis: DateTimeAxis(
                          dateFormat: intl.DateFormat.Hms(),
                          intervalType: DateTimeIntervalType.seconds,
                          desiredIntervals: 5,
                          axisLine: AxisLine(width: 2, color: Colors.green),
                        majorTickLines: MajorTickLines(color: Colors.transparent),
                            labelStyle: TextStyle(color: kRecieveColor),
                          majorGridLines: MajorGridLines(width: 0),
                        ),
                        primaryYAxis: NumericAxis(
                            majorGridLines: MajorGridLines(width: 0),
                            numberFormat: intl.NumberFormat('##,###.00'),
                          desiredIntervals: 5,
                          decimalPlaces: 5,
                          axisLine: AxisLine(width: 2, color: Colors.green),
                          majorTickLines:
                              MajorTickLines(color: Colors.transparent),
                          labelStyle: TextStyle(color: kRecieveColor)
                        ),
                        plotAreaBorderColor: Colors.white.withOpacity(0.2),
                        plotAreaBorderWidth: 0.2,
                        series: <LineSeries<Coin, DateTime>>[
                          LineSeries<Coin, DateTime>(
                            animationDuration: 1,
                            width: 2,
                            color: Theme.of(context).primaryColor,
                            dataSource: queue.toList(),
                            xValueMapper: (Coin coin, _) => coin.dateTime,
                            yValueMapper: (Coin coin, _) =>
                                double.parse(coin.price),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child:
                      ShowDetails(
                          'Market Cap:',(double.parse(Provider.of<CryptoService>(context).marketCap[widget.index])/1000000000).toStringAsFixed(8)+' B \$',),
                    ),
                    Expanded(
                        flex: 1,
                        child: ShowDetails(
                            'Rank:',
                            Provider.of<CryptoService>(context)
                                .rank[widget.index])),
                    Expanded(
                        flex: 1,
                        child: ShowDetails(
                            'Max Supply:',
                            Provider.of<CryptoService>(context)
                                .maxSupply[widget.index]=='NA'? Provider.of<CryptoService>(context)
                                .maxSupply[widget.index]: Provider.of<CryptoService>(context)
                                .maxSupply[widget.index]
                                .split('.')[0])),
                    Expanded(
                        flex: 1,
                        child: ShowDetails(
                          'Volume:',
                          Provider.of<CryptoService>(context)
                              .volume[widget.index]
                              .split('.')[0],
                        )),
                    Expanded(
                        flex: 1,
                        child: ShowDetails(
                            '24 Hr % change:',
                            Provider.of<CryptoService>(context)
                                .percChange[widget.index]
                                .replaceRange(
                                    4,
                                    Provider.of<CryptoService>(context)
                                        .percChange[widget.index]
                                        .length,
                                    ''))),
                  ],
                ),
              ),
            ),
    );
  }
}
