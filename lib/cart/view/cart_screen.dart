import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoping_hub_admin/cart/model/cart_item.dart';
import 'package:shoping_hub_admin/cart/model/cart_model.dart';
import 'package:shoping_hub_admin/cart/provider/cart_provider.dart';
import 'package:shoping_hub_admin/order/model/order_request_model.dart';
import 'package:shoping_hub_admin/order/model/product_order_item.dart';
import 'package:shoping_hub_admin/order/provider/order_provider.dart';
import 'package:shoping_hub_admin/product/model/product_model.dart';
import 'package:shoping_hub_admin/profile/model/shipping_address.dart';
import 'package:shoping_hub_admin/profile/view/add_shipping_address_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({this.product, super.key});
  final Product? product;
  @override
  State<CartScreen> createState() => _CartScreenState();
}
class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    fetchCartItems();
    super.initState();
  }
  Future fetchCartItems() async {
    CartProvider cartProvider =
        Provider.of<CartProvider>(context, listen: false);
    await cartProvider.fetchCartItems();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Cart',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        actions: [
          IconButton(
              onPressed: () {
                fetchCartItems();
              },
              icon: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.refresh,
                  color: Colors.black,
                ),
              ))
        ],
      ),
      body: Consumer<CartProvider>(
        builder: (context, provider, child) {
          return Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: provider.cartResponse?.items?.length ?? 0,
              itemBuilder: (context, index) {
                final cartItems = provider.cartResponse!.items![index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 5,

                    child: Column(
                      children: [
                        ListTile(
                          title: Text(
                              'Product : ${cartItems.product?.name.toString() ?? '0.0'}',
                              style: const TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Text(
                            'Price: ₹${cartItems.product?.price.toString() ?? '0.0'}',
                          ),
                          trailing: IconButton(
                            onPressed: () {
                              showDeleteDialog(context, cartItems);
                            },
                            icon: const Icon(
                              Icons.delete_forever,
                              color: Colors.red,
                              size: 32,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton( style: ElevatedButton.styleFrom(shape: const CircleBorder()),
                              onPressed: () {
                                int qty = cartItems.quantity ?? 0;
                                qty--;
                                cartItems.quantity = qty;
                                final cartProvider = Provider.of<CartProvider>(
                                    context,
                                    listen: false);
                                cartProvider.updateCartQuantity(CartModel(
                                    productId: cartItems.product?.id ?? '',
                                    quantity: qty));
                              },
                              child: const Icon(Icons.remove),
                            ),
                            Text(cartItems.quantity.toString()),
                            ElevatedButton( style: ElevatedButton.styleFrom(shape: const CircleBorder()),
                              onPressed: () {
                                int qty = cartItems.quantity ?? 0;
                                qty++;
                                cartItems.quantity = qty;
                                provider.updateCartQuantity(CartModel(
                                    productId: cartItems.product!.id ?? '',
                                    quantity: qty));
                              },
                              child: const Icon(Icons.add),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
      bottomNavigationBar: Consumer<CartProvider>(
        builder: (context, provider, child) {
          return BottomAppBar(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: SizedBox(
                    height: 55,
                    child: SingleChildScrollView(
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Total: ₹${provider.cartResponse?.subtotal?.toStringAsFixed(2) ?? '0.00'}',
                            style: const TextStyle(
                                fontSize: 13, fontWeight: FontWeight.w800),
                          ),
                          Text(
                            'Discount: ₹${provider.cartResponse?.totalDiscount?.toStringAsFixed(2) ?? '0.00'}',
                            style: const TextStyle(
                                fontSize: 16, color: Colors.green),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: SizedBox(
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () async {
                        ShippingAddress? shippingAddress = await Navigator.push(
                            context, MaterialPageRoute(builder: (context) {
                          return const AddShippingAddressScreen();
                        }));
                        placeOrder(shippingAddress, context);
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor: Colors.yellow[700],
                      ),
                      child: const Text(
                        'Place Order',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future placeOrder(ShippingAddress? shippingAddress, BuildContext context) async{
    if (shippingAddress != null) {
      final orderProvider = Provider.of<OrderProvider>(context, listen: false);
    final cartProvider = Provider.of<CartProvider>(context,listen: false);
      List<CartItems> cartItems = cartProvider.cartResponse?.items??[];
      List<OrderProductItem> orderProductItemList = [];
     for(int i=0;i<cartItems.length;i++){
       CartItems cartItem = cartItems[i];
       Product? product = cartItem.product;
       if(product!=null){
       OrderProductItem orderProductItem = OrderProductItem(
           product: product.id!,
         name: product.name,
         price: product.price,
         quantity: cartItem.quantity!,
         discountAmount: product.discountAmount??0,
         totalPrice: cartProvider.cartResponse?.subtotal??0,



       );
       orderProductItemList.add(orderProductItem);
     }
     }
      OrderRequestModel orderRequestModel = OrderRequestModel(shippingAddress: shippingAddress, items: orderProductItemList );
     await orderProvider.orderPlace(orderRequestModel);
  await  cartProvider.clearCart();
  await cartProvider.fetchCartItems();
    }
  }

  void showDeleteDialog(BuildContext context, CartItems cartItem) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Delete',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          content: Text(
            'Are you sure you want '
            'to delete this product: ${cartItem.product?.name ?? ''}?',
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Cancel',
                )),
            TextButton(
              onPressed: () async{
                final cartProvider =
                    Provider.of<CartProvider>(context, listen: false);
               await cartProvider.deleteCartItem(cartItem.product?.id ?? '');
               if(context.mounted) {
                 Navigator.pop(context);
                 cartProvider.fetchCartItems();
               }
              },
              child: const Text(
                'OK',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }
}
