import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart' as syspath;
import 'package:path/path.dart' as path;


class MyLandingScreen extends StatefulWidget {

  @override
  _MyLandingScreenState createState() => _MyLandingScreenState();
}

class _MyLandingScreenState extends State<MyLandingScreen> {

  File _pickedImage;
  File savedImage;

  void _pickImageFromCamera() async {

    final ImagePicker _picker = ImagePicker();

    final PickedFile pickedImage = await _picker.getImage(source: ImageSource.camera,
      maxHeight: 60,
      maxWidth: 60,
    );

    File tempFile = File(pickedImage.path);
    print("path ${pickedImage.path}");

    if(tempFile!=null) {
      _pickedImage = tempFile;

      setState(() {
      });

      //saving the image to device file system
      final fileName = path.basename(_pickedImage.path);
      final appDir = await syspath.getApplicationDocumentsDirectory();
      savedImage = await _pickedImage.copy('${appDir.path}/$fileName');
    }

  }


  void _pickImageFromGallery() async {
    final ImagePicker _picker = ImagePicker();

    final PickedFile pickedImage = await _picker.getImage(
        source: ImageSource.gallery);

    File tempFile = File(pickedImage.path);
    print("path ${pickedImage.path}");


    if (tempFile != null) {
      _pickedImage = tempFile;
      setState(() {});

      //saving the image to device file system
      final fileName = path.basename(_pickedImage.path);
      final appDir = await syspath.getApplicationDocumentsDirectory();
      savedImage = await _pickedImage.copy('${appDir.path}/$fileName');
    }
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Text('Image Picker Demo'),
      ),
      body: Center(
        child: Container(
          child: Column(
            children: <Widget>[
              SizedBox(height: 80),
              CircleAvatar(
                radius: 60,
                backgroundImage: _pickedImage == null ? null : FileImage(_pickedImage),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FlatButton.icon(
                    onPressed: _pickImageFromGallery,
                    icon: Icon(Icons.image,
                      color: Theme.of(context).accentColor,
                    ),
                    label: Text('Add an image from gallery',
                    style: TextStyle(
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                  ),
                ],
              ),
              SizedBox(height:20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FlatButton.icon(
                    onPressed: _pickImageFromCamera,
                    icon: Icon(
                      Icons.camera_alt,
                      color: Theme.of(context).accentColor,
                    ),
                    label: Text('Take a picture using camera',
                      style: TextStyle(
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                  )
                ],
              )

            ],
          )
        ),
      )
    );
  }
}