import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:filbet/generated/assets.dart';

import 'package:get/get.dart';

class loadinngView extends StatelessWidget {
  loadinngView({super.key, this.content});

  String? content;

  @override
  Widget build(BuildContext context) {
    return _loading();
  }

  Widget _loading() {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Color(0xff335575).withOpacity(0.15),
                // color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 36,
                    height: 36,
                    child: SpinKitFadingCircle(
                      color: Colors.white,
                      size: 36.0,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    content ?? "loading".tr,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      // fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              )),
        ],
      ),
    );
  }
}
