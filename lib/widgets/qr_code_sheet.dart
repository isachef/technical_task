import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrCodeSheet extends StatelessWidget {
  final String title;
  final String code;

  const QrCodeSheet({Key? key, required this.code, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 16,
          ),
          Text(
            title,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          QrImage(
            data: code,
            version: QrVersions.auto,
            size: 182,
            gapless: true,
          ),
          const SizedBox(
            height: 24,
          ),
        ],
      ),
    );
  }
}
