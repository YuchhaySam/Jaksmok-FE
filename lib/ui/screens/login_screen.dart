import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jaksmok_fe/core/extensions/snackbar_extension.dart';
import 'package:jaksmok_fe/core/extensions/theme_extension.dart';
import 'package:jaksmok_fe/logic/auth/auth_cubit.dart';
import 'package:jaksmok_fe/logic/auth/auth_state.dart';
import 'package:jaksmok_fe/ui/widgets/custom_text_field.dart';
import 'package:jaksmok_fe/ui/widgets/primary_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isObscureText = true;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      listener: (context, state) {
        if (!mounted) return;
        if (state is AuthSuccess) {
          context.showSnackBar('Login success', false);
        } else if (state is AuthError) {
          context.showSnackBar(state.error, true);
        }
      },
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: context.primary,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.4,
                child: Center(
                  child: Text(
                    'WELCOME',
                    style: TextStyle(
                      color: context.onPrimary,
                      fontSize: 50,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 40,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                    color: context.surfaceContainerHigh,
                  ),
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          CustomTextField(
                            label: 'Username',
                            controller: _usernameController,
                            isObscureText: false,
                            hintText: 'Enter username',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Username is required';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          CustomTextField(
                            label: 'Password',
                            controller: _passwordController,
                            isObscureText: _isObscureText,
                            hintText: 'Enter password',
                            showPassword: () {
                              setState(() {
                                _isObscureText = !_isObscureText;
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Password is required';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 35),
                          BlocBuilder<AuthCubit, AuthState>(
                            buildWhen: (previous, current) =>
                                current is AuthLoading ||
                                previous is AuthLoading,
                            builder: (context, state) {
                              return PrimaryButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    context.read<AuthCubit>().login(
                                      _usernameController.text.trim(),
                                      _passwordController.text,
                                    );
                                  }
                                },
                                isLoading: state is AuthLoading,
                                buttonText: 'Login',
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
