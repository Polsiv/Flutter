import 'package:fl_componentes/providers/usuario_form_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:fl_componentes/ui/input_decorations.dart';
import 'package:fl_componentes/widgets/widgets.dart';

class UsuarioScreen extends StatelessWidget {
   
  const UsuarioScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: const Text('Screen de usuario')),

      //body: Center(child: Text('LoginScreen')),

      body: AuthBackground(
        
        /*
        child:Container(
          width: double.infinity,
          height: 300,
          color: Colors.red,

        )
        */ 
       
        
        child: SingleChildScrollView(

          child: Column(
            children: [

              SizedBox( height: 250 ),

              CardContainer(

                child: Column(
                  children: [

                    SizedBox( height: 10 ),
                    Text('Crear Usuario', style: Theme.of(context).textTheme.headlineMedium ),
                    SizedBox( height: 30 ),
                    
                    ChangeNotifierProvider(
                      create: ( _ ) => UsuarioFormProvider(),
                      child: _UsuarioForm()
                    )
                    

                  ],
                )


              ),

              SizedBox( height: 50 ),
              Text('Ir al login', style: TextStyle( fontSize: 18, fontWeight: FontWeight.bold ),),
              SizedBox( height: 50 ),
            ],
          ),
        )
        



      )



    );
  }
}


class _UsuarioForm extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final usuarioForm = Provider.of<UsuarioFormProvider>(context);

    return Container(
      child: Form(
        key: usuarioForm.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,

        child: Column(
          children: [
            
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.name,
              decoration: InputDecorations.authInputDecoration(
                hintText: 'John Doe',
                labelText: 'Nombre completo',
                prefixIcon: Icons.person
              ),
              onChanged: ( value ) => usuarioForm.nombre = value,
              validator: ( value ) {

                  return ( value != null && value.length >= 3 ) 
                    ? null
                    : 'El nombre debe de ser de 3 caracteres';                                    
                  
              },
            ),

            SizedBox( height: 30 ),

            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(
                hintText: 'john.doe@gmail.com',
                labelText: 'Correo electrónico',
                prefixIcon: Icons.alternate_email_rounded
              ),
              onChanged: ( value ) => usuarioForm.correo = value,
              validator: ( value ) {

                  String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                  RegExp regExp  = RegExp(pattern);
                  
                  return regExp.hasMatch(value ?? '')
                    ? null
                    : 'El valor ingresado no luce como un correo';

              },
            ),

            SizedBox( height: 30 ),

            TextFormField(
              autocorrect: false,
              obscureText: true,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(
                hintText: '*****',
                labelText: 'Contraseña',
                prefixIcon: Icons.lock_outline
              ),
              onChanged: ( value ) => usuarioForm.password = value,
              validator: ( value ) {

                  return ( value != null && value.length >= 6 ) 
                    ? null
                    : 'La contraseña debe de ser de 6 caracteres';                                    
                  
              },
            ),

            SizedBox( height: 30 ),
            

            MaterialButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              disabledColor: Colors.grey,
              elevation: 0,
              color: Colors.deepPurple,


              // ignore: sort_child_properties_last
              child: Container(
                padding: EdgeInsets.symmetric( horizontal: 80, vertical: 15),
                child: Text(
                  usuarioForm.isLoading 
                    ? 'Espere'
                    : 'Ingresar',
                  style: TextStyle( color: Colors.white ),
                )
              ),
              onPressed: usuarioForm.isLoading ? null : () async {
                
                FocusScope.of(context).unfocus();
                
                if( !usuarioForm.isValidForm() ) return;

                usuarioForm.isLoading = true;

                await Future.delayed(Duration(seconds: 2 ));

                // TODO: validar si el usuario es correcto
                usuarioForm.isLoading = false;

                //usuarioForm.validarusuario();

                Navigator.pushReplacementNamed(context, 'home');
              }
            )

          ],
        ),
      ),
    );
  }
}
