import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutterwave_standard/core/TransactionCallBack.dart';
import 'package:flutterwave_standard/models/responses/charge_response.dart';

import 'flutterwave_in_app_browser.dart';

class StandardPaymentWidget extends StatefulWidget {
  final String webUrl;

  StandardPaymentWidget({required this.webUrl});

  @override
  _StandardPaymentWidgetAppState createState() => new _StandardPaymentWidgetAppState();
}

class _StandardPaymentWidgetAppState extends State<StandardPaymentWidget> implements TransactionCallBack {
  var options = InAppBrowserClassOptions(
    crossPlatform: InAppBrowserOptions(hideUrlBar: true, hideToolbarTop: true),
    inAppWebViewGroupOptions: InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(javaScriptEnabled: true),
    ),
  );

  @override
  void initState() {
    super.initState();
    final browser = FlutterwaveInAppBrowser(callBack: this);
    browser.openUrlRequest(urlRequest: URLRequest(url: Uri.parse(widget.webUrl)), options: options);
  }

  @override
  onTransactionComplete(ChargeResponse? chargeResponse) {
    Navigator.pop(context, chargeResponse);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * .7,
      child: Scaffold(
        body: Container(),
        backgroundColor: Colors.white,
      ),
    );
  }
}
