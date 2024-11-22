class ApiEndpoint {
  static const String baseUrl = 'https://e-commerce-server-zc33.onrender.com';
  static const String signUpUrl = '$baseUrl/api/users/register';
  static const String LoginUrl = '$baseUrl/api/users/login';

  static const String getProduct = '$baseUrl/api/products';
  static const String getCategory = '$baseUrl/api/categories';
  static const String addProduct = '$baseUrl/api/products';
  static const String deleteProduct = '$baseUrl/api/products';
  static const String addCategory = '$baseUrl/api/categories';
  static const String deleteCategory = '$baseUrl/api/categories';

}