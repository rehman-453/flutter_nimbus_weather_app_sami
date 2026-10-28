import 'package:get/get.dart';
import 'package:nimbus_weather_app/services/api_services/api_endpoints.dart';
import 'package:nimbus_weather_app/services/api_services/api_services.dart';

class AuthControllerNew extends GetxController {
  // made for handling loading state in the app
  RxBool isLoading = false.obs;
  RxList sampleList = [].obs;
  RxBool isRegisterLoading = false.obs;

  // made for login to user
  login(String email, String password) async {
    try {
      isLoading.value = true;
      var responseFromAPI = await ApiServices().postMethod(
        ApiEndpoints.loginUrl,
        {"email": email, "password": password},
      );
      Get.snackbar("Success", "User Logged In successfully!!");
      isLoading.value = false;
      print("Response From API " + responseFromAPI.toString());
    } catch (e) {
      isLoading.value = false;
      Get.snackbar("Error", e.toString());
    }
  }

  // made for login to user
  register(String name, String email, String password) async {
    try {
      isRegisterLoading.value = true;
      var responseFromRegisterAPI = await ApiServices().postMethod(
        ApiEndpoints.registerUrl,
        {"name": name, "email": email, "password": password},
      );
      Get.snackbar("Success", "User Register Successfully");
      isLoading.value = false;
      print("Response From API:" + responseFromRegisterAPI.toString());
    } catch (e) {
      isRegisterLoading.value = false;
      Get.snackbar("Error", e.toString());
    }
  }
}
