import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:aplicacion_productos/models/models.dart';

class ProductsService extends ChangeNotifier{
  final String _baseUrl='capacitacion-flotter-default-rtdb.firebaseio.com';
  final List<Product> products=[];
  late Product selectedProduct;

  File? newPictureFile;
  
  bool isLoading=true;
  bool isSaving=false;

  ProductsService(){
    LoadProducts();
  }

  // ignore: non_constant_identifier_names
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

  Future saveOrCreateProduct(Product product) async {
    isSaving=true;
    notifyListeners();

    if(product.id ==null ){
      // crear
      await createProduct(product);
    }else{
      // actualizar
      await updateProduct(product);
    }

    isSaving=false;
    notifyListeners();
  }

  Future<String> updateProduct(Product product) async {
    // final url=Uri.https(_baseUrl, 'products/${ product.id }.json');
    // final resp =await http.put(url, body: product.toJson()); 
    // final decodedData=resp.body;

    final index = products.indexWhere((element) => element.id == product.id);
    products[index] = product;

    return product.id!;
  }

  Future<String> createProduct(Product product) async {
    final url=Uri.https(_baseUrl, 'products.json');
    final resp =await http.post(url, body: product.toJson()); 
    final decodedData=json.decode(resp.body);

    product.id=decodedData['name'];
    products.add(product);

    return product.id!;
  }

  void updateSelectedProductImage(String path) async {

    selectedProduct.picture = path;
    newPictureFile = File.fromUri(Uri(path: path));

    notifyListeners();
  }

  Future<String?> uploadImage() async {
    if( newPictureFile == null ) return null;

    isSaving=true;
    notifyListeners();

    final url=Uri.parse('https://api.cloudinary.com/v1_1/dsezk6cge/image/upload?upload_preset=ml_defaultCesario');

    final imageUploadRequest = http.MultipartRequest('POST', url);

    final file = await http.MultipartFile.fromPath('file', newPictureFile!.path);

    imageUploadRequest.files.add(file);

    final streamResponse = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);

    if ( resp.statusCode != 200 && resp.statusCode !=201){
      print('algo salio mal');
      print( resp.body );
      return null;
    }

    newPictureFile = null;

    final decodedData = json.decode(resp.body);
    return decodedData['secure_url'];
  }
}