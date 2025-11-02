import 'package:flutter/material.dart';
import 'package:flutter_in_app_pip/picture_in_picture.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VigaTest extends StatelessWidget {
  const VigaTest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text('This page will float!'),
            MaterialButton(
              child: Text('Start floating!'),
              onPressed: () {
                PictureInPicture.startPiP(
                  pipWidget: BackgroundScreen(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class BackgroundScreen extends StatelessWidget {
  const BackgroundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      height: 100.w,
      color: Colors.blueAccent,
      child: Stack(children: [
        Text("hello"),
        ElevatedButton(
          onPressed: () {
            PictureInPicture.stopPiP();
          },
          child: Text("close"),
        )
      ]),
    );
  }
}
