import 'package:fl_componentes/providers/register_form_provider.dart';
import 'package:fl_componentes/services/auth_service.dart';
import 'package:fl_componentes/services/notifications_service.dart';
import 'package:fl_componentes/ui/input_decorations.dart';
import 'package:fl_componentes/widgets/CardContiner.dart';
import 'package:fl_componentes/widgets/auth_background.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

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
                    const SizedBox(height: 10),
                    Text('Registro', style: Theme.of(context).textTheme.headlineMedium),
                    const SizedBox(height: 30),
                    ChangeNotifierProvider(
                      create: (_) => RegisterFormProvider(),
                      child: const _RegisterForm(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50),
              TextButton(
                onPressed: () => Navigator.pushReplacementNamed(context, 'login'),
                child: const Text('Ya tienes una cuenta? Inicia sesión'),
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}

class _RegisterForm extends StatelessWidget {
  const _RegisterForm();
  //const _RegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    final registerForm = Provider.of<RegisterFormProvider>(context);
    final authService = Provider.of<AuthService>(context, listen: false);

    return Form(
      key: registerForm.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          TextFormField(
            autocorrect: false,
            decoration: InputDecorations.authInputDecoration(
              hintText: 'John Doe',
              labelText: 'Nombre',
              prefixIcon: Icons.person,
            ),
            onChanged: (value) => registerForm.nombre = value,
            validator: (value) =>
                (value != null && value.isNotEmpty) ? null : 'El nombre es obligatorio',
          ),
          const SizedBox(height: 30),
          TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecorations.authInputDecoration(
              hintText: 'correo@ejemplo.com',
              labelText: 'Correo',
              prefixIcon: Icons.alternate_email,
            ),
            onChanged: (value) => registerForm.correo = value,
            validator: (value) {
              final pattern =
                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
              final regExp = RegExp(pattern);
              return regExp.hasMatch(value ?? '') ? null : 'Correo no válido';
            },
          ),
          const SizedBox(height: 30),
          TextFormField(
            autocorrect: false,
            obscureText: true,
            decoration: InputDecorations.authInputDecoration(
              hintText: '*****',
              labelText: 'Contraseña',
              prefixIcon: Icons.lock_outline,
            ),
            onChanged: (value) => registerForm.password = value,
            validator: (value) => (value != null && value.length >= 6)
                ? null
                : 'La contraseña debe tener mínimo 6 caracteres',
          ),
          const SizedBox(height: 30),
          MaterialButton(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            disabledColor: Colors.grey,
            elevation: 0,
            color: Colors.deepPurple,
            onPressed: registerForm.isLoading
            ? null
            : () async {
                FocusScope.of(context).unfocus();

                if (!registerForm.isValidForm()) return;

                registerForm.isLoading = true;

                final String? errorMessage = await authService.createUserLocal(
                  registerForm.nombre,
                  registerForm.correo,
                  registerForm.password,
    
                );

                if (errorMessage == null) {
                  NotificationsService.showSnackbar('Usuario creado correctamente');
                  Navigator.pushReplacementNamed(context, 'login');
                } else {
                  NotificationsService.showSnackbar(errorMessage);
                  registerForm.isLoading = false;
                }
      },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
              child: registerForm.isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text('Crear cuenta', style: TextStyle(color: Colors.white)),
            ),


          ),
        ],
      ),
    );
  }
}
