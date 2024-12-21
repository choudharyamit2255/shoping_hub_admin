import 'package:flutter/material.dart';
import 'package:shoping_hub_admin/profile/model/shipping_address.dart';

class AddShippingAddressScreen extends StatefulWidget {
  const AddShippingAddressScreen({super.key});

  @override
  State<AddShippingAddressScreen> createState() => _AddShippingAddressScreenState();
}

class _AddShippingAddressScreenState extends State<AddShippingAddressScreen> {
  final formKey = GlobalKey<FormState>();
  final  streetController = TextEditingController();
  final  cityController = TextEditingController();
  final  stateController = TextEditingController();
  final  postalCodeController = TextEditingController();
  final  countryController = TextEditingController();


  void saveAddress() {
    if (formKey.currentState!.validate()) {
      ShippingAddress shippingAddress = ShippingAddress(
        street: streetController.text,
        city: cityController.text,
        state: stateController.text,
        postalCode: postalCodeController.text,
        country : countryController.text,

      );

      Navigator.pop(context,shippingAddress);
      




    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add delivery Address'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: streetController,
                  decoration: const InputDecoration(
                    labelText: 'Street',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your street';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: cityController,
                  decoration: const InputDecoration(
                    labelText: 'City',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your city';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: stateController,
                  decoration: const InputDecoration(
                    labelText: 'State',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your state';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: postalCodeController,
                  decoration: const InputDecoration(
                    labelText: 'Postal Code',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your postal code';
                    }


                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: countryController,
                  decoration: const InputDecoration(
                    labelText: 'Country',
                    border: OutlineInputBorder(),
                  ),


                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your country';
                    }
                    return null;
                  },
                ),
                ElevatedButton(
                  onPressed: saveAddress,
                  child: const Text('Save Address'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}




