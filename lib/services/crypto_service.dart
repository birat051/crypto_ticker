import 'package:crypto_ticker/utilities/crypto_list.dart';
import 'package:finance_quote/finance_quote.dart';

class CryptoService{
  int i;
  Future<void> getCryptoQuotes() async{
    final Map<String, Map<String, dynamic>> cryptoQuoteRaw =
    await FinanceQuote.getRawData(
        quoteProvider: QuoteProvider.coincap,
        symbols: kcrypto_name);
    print(kcrypto_name.length);
    for(i=0;i<kcrypto_name.length;i++) {
      price.add(cryptoQuoteRaw[kcrypto_name[i]]['priceUsd'].toString());
    }
    print(price);
  }
}