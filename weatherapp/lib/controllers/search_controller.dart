import 'package:get/get.dart';


// class SearchController extends GetxController{
//    static SearchController get instance => Get.find();
//   // Observable variable to track the visibility of the text field
//   var isTextFieldVisible = false.obs;

//   // Method to toggle the visibility of the text field
//   void toggleTextFieldVisibility() {
//     isTextFieldVisible.value = !isTextFieldVisible.value;
//   }
// }

class WController extends GetxController {
  static WController get instance => Get.find();
  var isTextFieldVisible = false.obs;

  void toggleTextFieldVisibility() {
    isTextFieldVisible.value = !isTextFieldVisible.value;
  }
}