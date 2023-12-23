import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';

class PopupBarcode {
  static void showBarcodePopup(BuildContext context, uuid) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Zeskanuj przy kasie',
                style: TextStyle(fontSize: 18.0),
              ),
              const SizedBox(height: 10.0),
              BarcodeWidget(
                barcode: Barcode.code128(),
                data: uuid,
                width: double.infinity, // Set width to fill the screen
                height: 100.0,
                color: Colors.black,
                style: const TextStyle(fontSize: 16.0),
              ),
              const SizedBox(height: 10.0),
            ],
          ),
        );
      },
    );
  }
}
