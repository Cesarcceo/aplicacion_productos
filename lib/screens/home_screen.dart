import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:aplicacion_productos/services/services.dart';
import 'package:aplicacion_productos/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final productService = Provider.of<ProductsService>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('productos'),
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) => GestureDetector(
          onTap: () => Navigator.pushNamed(context, 'product'),
          child: ProductCard(),
          )
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){},
      ),
   );
  }
}