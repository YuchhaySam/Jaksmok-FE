import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jaksmok_fe/core/extensions/snackbar_extension.dart';
import 'package:jaksmok_fe/core/localization/locale_keys.g.dart';
import 'package:jaksmok_fe/core/themes/theme_extension.dart';
import 'package:jaksmok_fe/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:jaksmok_fe/features/auth/presentation/cubit/auth_state.dart';
import 'package:jaksmok_fe/features/auth/presentation/widgets/custom_text_field.dart';
import 'package:jaksmok_fe/features/auth/presentation/widgets/primary_button.dart';

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
                  LocaleKeys.login_title.tr(),
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
                          label: LocaleKeys.login_user_label.tr(),
                          controller: _usernameController,
                          isObscureText: false,
                          hintText: LocaleKeys.login_user_hint.tr(),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return LocaleKeys.login_user_error.tr();
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        CustomTextField(
                          label: LocaleKeys.login_password_label.tr(),
                          controller: _passwordController,
                          isObscureText: _isObscureText,
                          hintText: LocaleKeys.login_password_hint.tr(),
                          showPassword: () {
                            setState(() {
                              _isObscureText = !_isObscureText;
                            });
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return LocaleKeys.login_password_error.tr();
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 35),
                        BlocConsumer<AuthCubit, AuthState>(
                          listener: (context, state) {
                            state.maybeWhen(
                              error: (message) {
                                context.showSnackBar(message, true);
                              },
                              orElse: () {},
                            );
                          },
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
                              isLoading: state.maybeMap(
                                loading: (_) => true,
                                orElse: () => false,
                              ),
                              buttonText: LocaleKeys.login_button.tr(),
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
    );
  }
}
