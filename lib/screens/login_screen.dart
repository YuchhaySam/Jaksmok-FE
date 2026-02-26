import 'package:flutter/material.dart';
import 'package:jaksmok_fe/extensions/snackbar_extension.dart';
import 'package:jaksmok_fe/extensions/theme_extension.dart';
import 'package:jaksmok_fe/screens/home_screen.dart';
import 'package:jaksmok_fe/services/api_service.dart';
import 'package:jaksmok_fe/widgets/custom_text_field.dart';
import 'package:jaksmok_fe/widgets/primary_button.dart';

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
  bool _isLoading = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        PrimaryButton(
                          onPressed: () => _handleLogin(),
                          isLoading: _isLoading,
                          buttonText: 'Login',
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
    );
  }

  Future<void> _handleLogin() async {
    final username = _usernameController.text.trim();
    final password = _passwordController.text;

    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });
    try {
      final isLogin = await ApiService.login(username, password);
      if (!mounted) return;
      if (!isLogin) {
        context.showSnackBar('Invalid credential', true);
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
        context.showSnackBar('Login successfully', false);
      }
    } catch (err) {
      context.showSnackBar('Something went wrong', true);
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}
