// ignore: file_names
import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkConnect {
  // Check Network Connection
  Future<String> checkNetwork() async {
    var checkNetwork = await Connectivity().checkConnectivity();

    if (checkNetwork == ConnectivityResult.none) {
      return '';
    } else if (checkNetwork == ConnectivityResult.mobile) {
      return 'mobile';
    } else if (checkNetwork == ConnectivityResult.wifi) {
      return 'wifi';
    }

    return '';
  }
}
