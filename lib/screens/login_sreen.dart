import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'package:aplicacion_productos/services/services.dart';
import 'package:aplicacion_productos/providers/login_form_provier.dart';
import 'package:aplicacion_productos/ui/input_decorations.dart';
import 'package:aplicacion_productos/widgets/widgets.dart';


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
                    const SizedBox(height: 30),

                    ChangeNotifierProvider(
                      create: (_) => LoginFormProvider(),
                      child: _LoginForm(),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 50),
              TextButton(
                onPressed: () => Navigator.pushReplacementNamed(context, 'register'), 
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(Colors.indigo.withOpacity(0.1)),
                  shape: MaterialStateProperty.all(StadiumBorder()),
                ),
                child: const Text('Crear nueva usuario', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
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

    final loginForm = Provider.of<LoginFormProvider>(context);
  
    return Form(
      key: loginForm.formkey,
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
            onChanged: (value) => loginForm.email=value,
            validator: (value){
              String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                RegExp regExp  = RegExp(pattern);
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
            onChanged: (value) => loginForm.password=value,
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
            onPressed: loginForm.isLoading ? null :() async {
    
              FocusScope.of(context).unfocus();
              final authService = Provider.of<AuthService>(context,listen: false);
    
              if(!loginForm.isValidForm())return;
    
              loginForm.isLoading=true;

              final String? errorMessage = await authService.login(loginForm.email, loginForm.password);
              if ( errorMessage == null){
                // ignore: use_build_context_synchronously
                Navigator.pushReplacementNamed(context, 'home');
              } else {
                print( errorMessage );
              loginForm.isLoading=false;
              }
              // ignore: use_build_context_synchronously
              Navigator.pushReplacementNamed(context, 'home');
    
            },
    
    
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
              child: Text(
                loginForm.isLoading
                ? 'Cargando'
                : 'Ingresar', 
                style: const TextStyle(color: Colors.white),
              ),
            )
          ),
        ],
      ),
    );
  }
}