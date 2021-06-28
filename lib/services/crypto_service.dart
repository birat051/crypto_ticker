import 'package:crypto_ticker/utilities/crypto_list.dart';
import 'package:finance_quote/finance_quote.dart';
import 'package:flutter/foundation.dart';

class Coin {
  final String price;
  final DateTime dateTime;
  Coin(
      this.price,
      this.dateTime,
      );
}
class CryptoService extends ChangeNotifier{
  int i;
  List<String> price=[];
  List<String> volume=[];
  List<String> rank=[];
  List<String> maxSupply=[];
  List<String> percChange=[];
  List<String> marketCap=[];
  Future<void> getCryptoQuotes() async{
    final Map<String, Map<String, dynamic>> cryptoQuoteRaw =
    await FinanceQuote.getRawData(
        quoteProvider: QuoteProvider.coincap,
        symbols: kcrypto_name);
    this.price=[];
    this.volume=[];
    this.rank=[];
    this.maxSupply=[];
    this.percChange=[];
    for(i=0;i<kcrypto_name.length;i++) {
    //  print(cryptoQuoteRaw[kcrypto_name[i]]);
      this.price.add(cryptoQuoteRaw[kcrypto_name[i]]['priceUsd'].toString());
      this.volume.add(cryptoQuoteRaw[kcrypto_name[i]]['volumeUsd24Hr'].toString());
      this.rank.add(cryptoQuoteRaw[kcrypto_name[i]]['rank'].toString());
      this.percChange.add(cryptoQuoteRaw[kcrypto_name[i]]['changePercent24Hr'].toString());
      this.marketCap.add(cryptoQuoteRaw[kcrypto_name[i]]['marketCapUsd'].toString());
      if(cryptoQuoteRaw[kcrypto_name[i]]['maxSupply']==null)
        this.maxSupply.add('NA');
      else
        this.maxSupply.add(cryptoQuoteRaw[kcrypto_name[i]]['maxSupply'].toString());
    }
    notifyListeners();
  }
}