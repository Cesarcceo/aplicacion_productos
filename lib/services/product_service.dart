import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:aplicacion_productos/models/models.dart';

class ProductsService extends ChangeNotifier{
  final String _baseUrl='capacitacion-flotter-default-rtdb.firebaseio.com';
  final List<Product> products=[];
  bool isLoading=true;

  ProductsService(){
    LoadProducts();

  }

  Future<List<Product>> LoadProducts () async {
    isLoading=true;
    notifyListeners();

    final url=Uri.https(_baseUrl, 'products.json');
    final resp =await http.get(url);

    final Map<String, dynamic> productsMap=json.decode(resp.body);

    productsMap.forEach((key, value) {
      final tempProduct = Product.fromMap(value);
      tempProduct.id=key;
      products.add(tempProduct);
    });

    isLoading=false;
    notifyListeners();

  return products;
  }
}