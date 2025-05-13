import 'package:flutter/material.dart';
import 'package:pokexplorer/core/constants/app_const.dart';
import 'package:toastification/toastification.dart';

ToastificationItem myToast(BuildContext context, String msg) {
  toastification.dismissAll();
  return toastification.show(
    icon: Image.asset(POKEBALL_PNG, width: 20, height: 20),
    title: SizedBox(
        width: MediaQuery.sizeOf(context).width * 0.9,
        child: Text(
          msg,
          maxLines: 3,
          style: Theme.of(context).textTheme.labelSmall,
        )),
    closeOnClick: false,
    context: context,
    pauseOnHover: false,
    showIcon: true,
    alignment: Alignment.bottomCenter,
    showProgressBar: false,
    style: ToastificationStyle.flat,
    autoCloseDuration: const Duration(seconds: 2),
  );
}
