import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  static Future<PermissionStatus> checkPermissionStatus(
    Permission permission,
  ) async {
    return permission.status;
  }

  static Future<PermissionStatus> requestPermission(
    Permission permission,
  ) async {
    return permission.request();
  }

  static Future<bool> hasPermission(Permission permission) async {
    final status = await checkPermissionStatus(permission);
    return status == PermissionStatus.granted;
  }

  static Future<bool> requestAndCheckPermission(Permission permission) async {
    final status = await requestPermission(permission);
    return status == PermissionStatus.granted;
  }
}
