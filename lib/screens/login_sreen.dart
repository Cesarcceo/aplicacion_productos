import 'package:aplicacion_productos/ui/input_decorations.dart';
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
                    _LoginForm(),
                  ],
                ),
              ),

              const SizedBox(height: 50),
              const Text('cear nueva cuaeta', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 50),
            ],
          ),
        ) 
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: inputDecorations.authInputDecorations(
                hintText: 'email',
                labelText: 'Correo electronico',
                prefixIcon: Icons.alternate_email_sharp
              ),
              validator: (value){
                String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                  RegExp regExp  = new RegExp(pattern);
                  return regExp.hasMatch(value??'')
                    ? null 
                    : 'Ingrese un correo valido';
              },
            ),
            const SizedBox(height: 30),
            TextFormField(
              obscureText: true,
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: inputDecorations.authInputDecorations(
                hintText: '*******',
                labelText: 'Contraseña',
                prefixIcon: Icons.lock_outline,                
              ),
              validator: (value){
                if(value!=null && value.length>= 6) return null;
                  return 'La contraseña deve contener minimo 6 caracteres';
              },
            ),
            const SizedBox(height: 30),
            MaterialButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              disabledColor: Colors.grey,
              elevation: 0,
              color: Colors.deepPurple,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                child: const Text('Ingresar', style: TextStyle(color: Colors.white)),
              ),
              onPressed: (){}
            ),
          ],
        ),
      ),
    );
  }
}