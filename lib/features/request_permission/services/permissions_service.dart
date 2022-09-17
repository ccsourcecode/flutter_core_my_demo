import 'package:permission_handler/permission_handler.dart';

class PermissionsService {
  Future<void> requestPermission(Permission permission) async {
    final status = await permission.request();
  }
}
