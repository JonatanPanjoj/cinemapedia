import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class HumanFormats {
  static String number (double number, [int decimals = 0]){
    final formatterNumber = NumberFormat.compactCurrency(
      decimalDigits: decimals,
      symbol: '',
      locale: 'en'
    ).format(number);

    return formatterNumber;
  }

  static String shortDate( DateTime date ) { 
     initializeDateFormatting();   
    final format = DateFormat.yMMMEd('es');
    return format.format(date);
  }
}