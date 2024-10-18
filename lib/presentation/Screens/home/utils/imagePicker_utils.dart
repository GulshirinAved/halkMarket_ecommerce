import 'package:device_info_plus/device_info_plus.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io' show Platform;

import 'package:permission_handler/permission_handler.dart';

class ImagepickerUtils {
  final ImagePicker _picker = ImagePicker();
  Future<XFile?> pickImageFromGallary() async {
    bool allowed = await galeryPermission();
    if (allowed == true) {
      await storagePermission();

      try {
        final XFile? file =
            await _picker.pickImage(source: ImageSource.gallery);
        return file;
      } catch (e) {
        print('$e error occured while picking galery image');
      }
    }
    allowed = await galeryPermission();
    return null;
  }

  Future<bool> galeryPermission() async {
    if (Platform.isAndroid) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      final status = await Permission.storage.request();
      switch (androidInfo.version.sdkInt) {
        case <= 32:
          switch (status) {
            case PermissionStatus.granted:
              return true;
            case PermissionStatus.denied:
              await Permission.storage.request();
              return false;
            case PermissionStatus.permanentlyDenied:
              await openAppSettings();
              return false;
            default:
              return false;
          }
        case >= 33:
          final galery = await Permission.photos.request();
          switch (galery) {
            case PermissionStatus.granted:
              return true;
            case PermissionStatus.denied:
              await Permission.photos.request();
              return false;
            case PermissionStatus.permanentlyDenied:
              await openAppSettings();
              return false;
            default:
              return false;
          }
        default:
          return false;
      }
    } else if (Platform.isIOS) {
      final status = await Permission.storage.request();
      switch (status) {
        case PermissionStatus.granted:
          return true;
        case PermissionStatus.denied:
          await Permission.storage.request();
          return false;
        case PermissionStatus.permanentlyDenied:
          await openAppSettings();
          return false;
        default:
          return false;
      }
    } else {
      return false;
    }
  }

  Future<bool> storagePermission() async {
    if (Platform.isAndroid) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      final status = await Permission.storage.request();
      switch (androidInfo.version.sdkInt) {
        case <= 32:
          switch (status) {
            case PermissionStatus.granted:
              return true;
            case PermissionStatus.denied:
              await Permission.storage.request();
              return false;
            case PermissionStatus.permanentlyDenied:
              await openAppSettings();
              return false;
            default:
              return false;
          }
        case >= 33:
          final storage = await Permission.manageExternalStorage.request();
          switch (storage) {
            case PermissionStatus.granted:
              return true;
            case PermissionStatus.denied:
              await Permission.manageExternalStorage.request();
              return false;
            case PermissionStatus.permanentlyDenied:
              openAppSettings();
              return false;
            default:
              return false;
          }
        default:
          return false;
      }
    } else if (Platform.isIOS) {
      final status = await Permission.storage.request();
      switch (status) {
        case PermissionStatus.granted:
          return true;
        case PermissionStatus.denied:
          await Permission.storage.request();
          return false;
        case PermissionStatus.permanentlyDenied:
          openAppSettings();
          return false;
        default:
          return false;
      }
    } else {
      return false;
    }
  }
}
