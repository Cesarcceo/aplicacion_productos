import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

import 'package:aplicacion_productos/providers/product_from_provider.dart';
import 'package:aplicacion_productos/services/product_service.dart';
import 'package:aplicacion_productos/ui/input_decorations.dart';
import 'package:aplicacion_productos/widgets/widgets.dart';


class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final producService = Provider.of<ProductsService>(context);

    return ChangeNotifierProvider(
      create: (_)=> ProductFormProvider(producService.selectedProduct),
      child:  _ProductsScreenBody(producService: producService)
    );
  }
}

class _ProductsScreenBody extends StatelessWidget {
  const _ProductsScreenBody({
    required this.producService,
  });

  final ProductsService producService;

  @override
  Widget build(BuildContext context) {

    final productForm =Provider.of<ProductFormProvider>(context);

    return Scaffold(
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
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
                    icon: const Icon(Icons.arrow_back, size: 40,color: Colors.white),
                  ),
                ),
                Positioned(
                  top: 60,
                  right: 20,
                  child: IconButton(
                    onPressed: () async {
                      final ImagePicker picker= ImagePicker();
                      final XFile? pickedFile = await picker.pickImage(
                        source: ImageSource.camera,
                        imageQuality: 100
                        );

                        if (pickedFile == null){
                          return;
                        }
                        print('Tenemos imagen ${ pickedFile.path}');
                        producService.updateSelectedProductImage(pickedFile.path);
                    },
                    icon: const Icon(Icons.camera_alt, size: 40,color: Colors.white),
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
          if(!productForm.isValidForm()) return;

          producService.saveOrCreateProduct(productForm.product);
        },
      ),
       );
  }
}

class _ProductForm extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final productForm=Provider.of<ProductFormProvider>(context);
    final product = productForm.product;
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        decoration: _buildBoxDecoration(),
        child: Form(
          key: productForm.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              const SizedBox(height: 30,),
              TextFormField(
                initialValue: product.name,
                onChanged: (value) => product.name = value,
                validator: (value) {
                  if (value == null || value.isEmpty ) {
                    return 'El nombre es Obligatorio';
                  }
                  return null;
                },
                decoration: inputDecorations.authInputDecorations(
                  hintText: 'Nombre del producto', 
                  labelText: 'Nombre',
                ),
      
              ),
      
              const SizedBox(height: 30,),
              TextFormField(
                initialValue: '${product.price}',
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}'))

                ],
                onChanged: (value) {
                  if(double.tryParse(value)==null){
                    product.price=0;
                  }else {
                    product.price = double.parse(value);
                  }
                },
                keyboardType: TextInputType.number,
                decoration: inputDecorations.authInputDecorations(
                  hintText: '\$150', 
                  labelText: 'precio',
                ),
      
              ),
              const SizedBox(height: 30),

              SwitchListTile(
                value: product.available, 
                title: const Text('Disponible'),
                activeColor: Colors.indigo,
                onChanged: productForm.updateAvailability
              ),
              const SizedBox(height: 30),
            ],
          ), 
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: const BorderRadius.only(bottomRight: Radius.circular(25), bottomLeft: Radius.circular(25)),
      boxShadow: [
        BoxShadow(
        color: Colors.black.withOpacity(0.05),
        offset: const Offset(0,5),
        blurRadius: 5,
        )
      ]
    );
  }
}