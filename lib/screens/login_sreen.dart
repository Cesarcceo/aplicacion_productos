import 'package:aplicacion_productos/widgets/widgets.dart';
import 'package:flutter/material.dart';


class LoginScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthBackground(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 250),
              CardContainer(
                child: Column(
                  children: [
                    const SizedBox(height: 10,),
                    Text('Login', style: Theme.of(context).textTheme.headlineMedium),
                    const SizedBox(height: 30,),

                    Text('Formulario'),

                  ],
                ),
              ),
            ],
          ),
        ) 
      ),
    );
  }
}