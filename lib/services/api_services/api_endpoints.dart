class ApiEndpoints {
  //~~~~~~~~~~~Base URL~~~~~~~~~~~~~~~~~~~~~~~~~//
  static String baseUrl = "https://nimbus-api-vtoz.onrender.com/api/v1";

  //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
  // cities url
  static String citiesUrl = "$baseUrl/cities?page=1&limit=8";
  static String loginUrl = "$baseUrl/auth/login";
  static String registerUrl = "$baseUrl/auth/register";
}
