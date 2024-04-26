import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:aplicacion_productos/services/product_service.dart';
import 'package:aplicacion_productos/ui/input_decorations.dart';
import 'package:aplicacion_productos/widgets/widgets.dart';


class ProductScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final producService = Provider.of<ProductsService>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [

            Stack(
              children: [
                ProductImage(url: producService.selectedProduct.picture),
                Positioned(
                  top: 60,
                  left: 20,
                  child: IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(Icons.arrow_back, size: 40,color: Colors.white),
                  ),
                ),
                Positioned(
                  top: 60,
                  right: 20,
                  child: IconButton(
                    onPressed: () {
                      //camara, galeria
                    },
                    icon: Icon(Icons.camera_alt, size: 40,color: Colors.white),
                  ),
                ),
              ],
            ),

            _ProductForm(),

            const SizedBox(height: 100),

          ],
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        child:const Icon(Icons.save),
        onPressed: (){

        },
      ),
   );
  }
}

class _ProductForm extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        decoration: _buildBoxDecoration(),
        child: Form(
          child: Column(
            children: [
              SizedBox(height: 30,),
              TextFormField(
                decoration: inputDecorations.authInputDecorations(
                  hintText: 'Nombre del producto', 
                  labelText: 'Nombre',
                ),
      
              ),
      
              SizedBox(height: 30,),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: inputDecorations.authInputDecorations(
                  hintText: '\$150', 
                  labelText: 'precio',
                ),
      
              ),
              SizedBox(height: 30),
              SwitchListTile(
                value: true, 
                title: Text('Disponible'),
                activeColor: Colors.indigo,
                onChanged: (value){
      
                }
              ),
              SizedBox(height: 30),
            ],
          ), 
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(bottomRight: Radius.circular(25), bottomLeft: Radius.circular(25)),
      boxShadow: [
        BoxShadow(
        color: Colors.black.withOpacity(0.05),
        offset: Offset(0,5),
        blurRadius: 5,
        )
      ]
    );
  }
}