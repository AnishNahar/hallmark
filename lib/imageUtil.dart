import 'dart:typed_data';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image_cropper/image_cropper.dart';
import 'dart:io';
//import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_picker/image_picker.dart';

class ImageHelper {
  PickedFile _pickedimage;
  Future<PickedFile> getPickedImage(ImageSource imgsource) async {
    _pickedimage = await ImagePicker().getImage(
      source: imgsource,
    );
    return _pickedimage;
  }

  Future<File> getCroppedFile(String pickedimagepath) async {
    File cropedimage = await ImageCropper.cropImage(
      sourcePath: pickedimagepath,
      aspectRatio: CropAspectRatio(ratioX: 2.6, ratioY: 2.6),
      androidUiSettings: AndroidUiSettings(
        statusBarColor: Colors.purple,
        lockAspectRatio: true,
        toolbarWidgetColor: Colors.black,
        toolbarColor: Colors.blue,
        backgroundColor: Colors.yellow,
        activeControlsWidgetColor: Colors.white,
        dimmedLayerColor: Colors.black12,
        cropFrameColor: Colors.green,
        cropGridColor: Colors.cyan,
        hideBottomControls: false,

      ),
    );
    if (cropedimage == null) {
      cropedimage = File(_pickedimage.path);
    }
    return cropedimage;
  }

  Future<bool> saveImage(String fileName, String filepath) async {
    Directory directory;
    try {
      if (Platform.isAndroid) {
        if (await _requestPermission(Permission.storage)) {
          directory = await getExternalStorageDirectory();
          String newPath = "";
          print(directory);
          List<String> paths = directory.path.split("/");
          for (int x = 1; x < paths.length; x++) {
            String folder = paths[x];
            if (folder != "Android") {
              newPath += "/" + folder;
            } else {
              break;
            }
          }
          newPath = newPath + "/hallmarkcardgenerator";
          directory = Directory(newPath);
        } else {
          return false;
        }
      } else {
        if (await _requestPermission(Permission.photos)) {
          directory = await getTemporaryDirectory();
        } else {
          return false;
        }
      }

      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }
      if (await directory.exists()) {
        File saveFile = File(directory.path + "/${fileName}.pdf");
        await saveFile.copy(filepath);
        if (Platform.isIOS) {
          //var path=await ImageGallerySaver.saveImage(img,name:'${fileName}',isReturnImagePathOfIOS: true);
          //print(path);
        }
        if (Platform.isAndroid) {
          //var path=await ImageGallerySaver.saveImage(img,name:'${fileName}',isReturnImagePathOfIOS: false);
          print(saveFile.path);
          print(saveFile.lastModifiedSync().toString());
        }
        return true;
      }
    } catch (e) {
      print(e);
    }
    return false;
  }

  Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      if (result == PermissionStatus.granted) {
        return true;
      }
    }
    return false;
  }
}

class Utility {
  static Image imageFromBase64String(String base64String) {
    return Image.memory(
      base64Decode(base64String),
      fit: BoxFit.fill,
    );
  }

  static Uint8List dataFromBase64String(String base64String) {
    return base64Decode(base64String);
  }

  static String base64String(Uint8List data) {
    return base64Encode(data);
  }
}
