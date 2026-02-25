import 'package:flutter/material.dart';
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
  String? _requireUsername;
  String? _requirePassword;
  String? _errorMessage;
  bool _isObscureText = true;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: theme.primary,
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
                    color: theme.onPrimary,
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
                  color: theme.surfaceContainerHigh,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      CustomTextField(
                        label: 'Username',
                        controller: _usernameController,
                        error: _requireUsername,
                        isObscureText: false,
                        hintText: 'Enter username',
                      ),
                      const SizedBox(height: 20),
                      CustomTextField(
                        label: 'Password',
                        controller: _passwordController,
                        error: _requirePassword,
                        isObscureText: _isObscureText,
                        hintText: 'Enter username',
                        showPassword: () {
                          setState(() {
                            _isObscureText = !_isObscureText;
                          });
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
          ],
        ),
      ),
    );
  }

  void _handleLogin() {
    bool isFormValid = true;
    if (_usernameController.text.isEmpty) {
      setState(() {
        _requireUsername = 'Username requried';
        isFormValid = false;
      });
    }

    if (_passwordController.text.isEmpty) {
      setState(() {
        _requirePassword = 'Password requried';
        isFormValid = false;
      });
    }

    if (!isFormValid) return;
  }
}
