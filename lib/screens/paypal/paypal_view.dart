import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constant.dart';
import '../screens.dart';
import 'package:webview_flutter/webview_flutter.dart';


/// The view part of the [PaypalView], which will be used to
/// show the Paypal page
class PaypalView extends StatefulWidget {
  const PaypalView({ Key? key }) : super(key: key);

  @override
  State<PaypalView> createState() => _PaypalViewState();
}

class _PaypalViewState extends State<PaypalView> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  
  @override
  Widget build(BuildContext context) => GetBuilder<PaypalController>(
    builder:(_controller) => Scaffold(
      key: scaffoldKey,
      // backgroundColor: ColorsValue.backgroundColor,
       appBar: AppBar(
        backgroundColor: KPrimaryColor,
        elevation: 0,
        title: Text(
          "Paypal Payment",
          style: appBarHeading,
        ),
        centerTitle: true,
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Image.asset(
                "assets/arrow-left.png",
                height: 24,
              ),
            ),
          ],
        ),
      ),
      body: _controller.checkoutUrl == null ? const Center(child: CircularProgressIndicator()) : WebView(
        zoomEnabled: false,
          initialUrl: _controller.checkoutUrl,
          javascriptMode: JavascriptMode.unrestricted,
          navigationDelegate: (NavigationRequest request) {
            if (request.url.contains(_controller.returnURL)) {
              final uri = Uri.parse(request.url);
              final payerID = uri.queryParameters['PayerID'];
              if (payerID != null) {
                _controller.services
                    .executePayment(Uri.parse(_controller.executeUrl.toString()), payerID, _controller.accessToken)
                    .then((id) {
                  Get.back<dynamic>(
                    result: id,
                  closeOverlays: true
                );
                });
              } 
              else {
                // Navigator.of(context).pop();
                Get.back<dynamic>(
                  closeOverlays: true
                );
              }
              // Navigator.of(context).pop();
            }
            if (request.url.contains(_controller.cancelURL)) {
              Get.back<dynamic>(
                closeOverlays: true
              );

            }
            return NavigationDecision.navigate;
          },
    )
  )
  );
}