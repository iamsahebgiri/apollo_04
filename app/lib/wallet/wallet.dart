import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class Wallet extends StatefulWidget {
  const Wallet({Key? key}) : super(key: key);

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  final qrKey = GlobalKey(debugLabel: 'QR');
  // QRViewController? controller;
  // Barcode? result;
  // @override
  // void reassemble() {
  //   super.reassemble();
  //   if (Platform.isAndroid) {
  //     controller!.pauseCamera();
  //   } else if (Platform.isIOS) {
  //     controller!.resumeCamera();
  //   }
  // }

  // @override
  // void dispose() {
  //   controller?.dispose();
  //   super.dispose();
  // }

  bool isqr = false;
  final billingAccountId = "krishna@ghumo";

  @override
  Widget build(BuildContext context) {
    Future _qrScanner() async {
      var cameraStatus = await Permission.camera.status;
      if (cameraStatus.isGranted) {
        String? qrData = await scanner.scan();
        print(qrData);
      } else {
        var isgrant = await Permission.camera.request();
        if (isgrant.isGranted) {
          String? qrData = await scanner.scan();
          print(qrData);
        }
      }
    }

    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
              child: Container(
            color: Colors.white10,
          )),
          Positioned(
            top: 0,
            bottom: 500,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.blue,
            ),
          ),
          Positioned(
              top: 0,
              bottom: 650,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 30.0,
                ),
              )),
          const Positioned(
            top: 70.0,
            left: 150.0,
            child: Text(
              "My Account",
              style: TextStyle(
                fontSize: 25.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Positioned(
            top: 100,
            bottom: 300,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(16.0),
                  ),
                ),
                child: QrImage(
                  data: billingAccountId,
                  version: QrVersions.auto,
                  size: 200.0,
                ),
              ),
            ),
          ),
          Positioned(
              left: 120,
              top: 520,
              bottom: 100,
              child: Column(
                children: [
                  const Text(
                    "Current Balance ",
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    "100 GT",
                    style: TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _qrScanner();
                    },
                    child: const Text("Accept Payment"),
                  ),
                ],
              )),
        ],
      ),
    );
  }

  // void onQRViewCreated(QRViewController controll) {
  //   setState(() {
  //     controller = controller;
  //   });
  // }
}
