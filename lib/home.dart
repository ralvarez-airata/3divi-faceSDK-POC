import 'dart:async';
import 'package:face_sdk_3divi_demo/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:camera/camera.dart';
import 'package:face_sdk_3divi/face_sdk_3divi.dart';


typedef void setServiceCallback(FacerecService templ);


class HomePage extends StatefulWidget {
  final List<CameraDescription> cameras;
  final String _dataDir;
  final setServiceCallback _setService;
  final String nextRoute;

  HomePage(this.cameras, this._dataDir, this.nextRoute, this._setService);

  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _libDir = "";
  static const platform = const MethodChannel('samples.flutter.dev/facesdk');
  late FacerecService _facerecService;
  bool _loading = true;

  Future<void> getLibDir() async {
    String libDir = "None";
    try {
      final String res = await platform.invokeMethod('getNativeLibDir');
      libDir = res;
    } on PlatformException catch (e) {}
    createService(libDir);
  }

  void createService(String libdir){
    if(widget._dataDir == '' || libdir == ''){
      return;
    }
    print("DATADIR ==> ${widget._dataDir} - LIBDIR ==> $libdir");
    _facerecService = FaceSdkPlugin.createFacerecService(
        widget._dataDir + "/conf/facerec",
        widget._dataDir + "/license",
        libdir + "/" + FaceSdkPlugin.nativeLibName
    );
    setState(() {
      widget._setService(_facerecService);
      _loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getLibDir();
  }

  @override
  Widget build(BuildContext context) {
    return _loading ?
      CircularProgressIndicator():
      Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(child: const Text("Blink"), onPressed: () {
                Navigator.of(context).pushNamed(blinkRoute);
              }),
              ElevatedButton(child: const Text("Smile"), onPressed: () {
                Navigator.of(context).pushNamed(smileRoute);
              }),
              // ElevatedButton(child: const Text("Auto"), onPressed: () {
              //   Navigator.of(context).pushNamed(liveness2dRoute);
              // }),
            ]
          )
        )
      );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
