import 'package:get/get.dart';
import './paypal_services.dart';
import '../home/home_controller.dart';

class PaypalController extends GetxController {

  final _homeController = Get.find<HomeController>(); 

  String? checkoutUrl;
  String? executeUrl;
  String? accessToken;
  PaypalServices services = PaypalServices();
  
  // you can change default currency according to your need
  Map<dynamic,dynamic> defaultCurrency = {"symbol": "USD ", "decimalDigits": 2, "symbolBeforeTheNumber": true, "currency": "USD"};

  bool isEnableShipping = false;
  bool isEnableAddress = false;

  String returnURL = 'return.example.com';
  String cancelURL= 'cancel.example.com';

  @override
  onInit() async{
    super.onInit();
    Future.delayed(Duration.zero, () async {
      try{
        accessToken = await services.getAccessToken();

        final transactions = getOrderParams();
        final res =
            await services.createPaypalPayment(transactions, accessToken);
        if (res != null) {
            checkoutUrl = res["approvalUrl"];
            executeUrl = res["executeUrl"];
            update();
          }
      } catch(e){
        final snackBar = GetSnackBar(
          message: e.toString(),
          isDismissible: true,
          duration: const Duration(seconds: 2),
        );
        Get.showSnackbar(snackBar);
      }
    });
  }

  String itemName = 'Housekeeping Services';
  int quantity = 1;

  Map<String, dynamic> getOrderParams() {
    String totalAmount = _homeController.generateTotal().toString();
    List items = [
      {
        "name": itemName,
        "quantity": quantity,
        "price": totalAmount,
        "currency": defaultCurrency["currency"]
      }
    ];


    // checkout invoice details
    // String totalAmount = totalAmount;
    // String subTotalAmount = _homeController.totalAmount.toString();
    String shippingCost = '0';
    int shippingDiscountCost = 0;

    Map<String, dynamic> temp = {
      "intent": "sale",
      "payer": {"payment_method": "paypal"},
      "transactions": [
        {
          "amount": {
            "total": totalAmount,
            "currency": defaultCurrency["currency"],
            "details": {
              "subtotal": totalAmount,
              "shipping": shippingCost,
              "shipping_discount":
                  ((-1.0) * shippingDiscountCost).toString()
            }
          },
          "description": "The payment transaction description.",
          "payment_options": {
            "allowed_payment_method": "INSTANT_FUNDING_SOURCE"
          },
          "item_list": {
            "items": items,
          }
        }
      ],
      "note_to_payer": "Contact us for any questions on your order.",
      "redirect_urls": {
        "return_url": returnURL,
        "cancel_url": cancelURL
      }
    };
    return temp;
  }

}