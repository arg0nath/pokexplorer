import 'package:flutter/material.dart';
import 'package:pokexplorer/core/common/extensions/context_ext.dart';
import 'package:pokexplorer/core/common/res/app_assets.dart';
import 'package:toastification/toastification.dart';

ToastificationItem showPokeToast(BuildContext context, String msg) {
  toastification.dismissAll();
  return toastification.show(
    icon: Image.asset(AppAssets.pokeballPng, width: 20, height: 20),
    title: SizedBox(
        width: context.width * 0.9,
        child: Text(
          msg,
          maxLines: 3,
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
