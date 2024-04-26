import 'package:aplicacion_productos/models/models.dart';
import 'package:flutter/material.dart';

class ProductsService extends ChangeNotifier{
  final String _baseUrl='capacitacion-flotter-default-rtdb.firebaseio.com';

  final List<Product> products=[];
}