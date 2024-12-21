class CartModel {
  String productId;
  int quantity;

  CartModel({required this.productId, required this.quantity});

  Map<String, dynamic> toJson() {
    return {'productId': productId, 'quantity': quantity};
  }

  static CartModel fromJson(Map<String, dynamic> json) {
    return CartModel(productId: json['productId'], quantity: json['quantity']);
  }
}