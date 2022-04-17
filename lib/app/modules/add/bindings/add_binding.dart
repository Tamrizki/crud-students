import 'package:crud_firebase/app/modules/add/controllers/add_controller.dart';
import 'package:get/instance_manager.dart';

class AddBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddController>(
      () => AddController(),
    );
  }
}
