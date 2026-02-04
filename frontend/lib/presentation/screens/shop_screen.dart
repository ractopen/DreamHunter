import 'package:flutter/material.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shop'),
      ),
      body: ListView(
        children: const [
          ListTile(
            leading: Icon(Icons.monetization_on),
            title: Text('100 Coins'),
            subtitle: Text('\$0.99'),
            trailing: ElevatedButton(
              onPressed: null, // No functionality yet
              child: Text('Buy'),
            ),
          ),
          ListTile(
            leading: Icon(Icons.monetization_on),
            title: Text('500 Coins'),
            subtitle: Text('\$4.99'),
            trailing: ElevatedButton(
              onPressed: null, // No functionality yet
              child: Text('Buy'),
            ),
          ),
          ListTile(
            leading: Icon(Icons.monetization_on),
            title: Text('1000 Coins'),
            subtitle: Text('\$9.99'),
            trailing: ElevatedButton(
              onPressed: null, // No functionality yet
              child: Text('Buy'),
            ),
          ),
        ],
      ),
    );
  }
}
