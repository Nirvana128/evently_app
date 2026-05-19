// ignore_for_file: use_build_context_synchronously

import 'package:evently/core/constants/app_images.dart';
import 'package:evently/core/constants/app_padding.dart';
import 'package:evently/core/constants/app_routes.dart';
import 'package:evently/core/extensions/responsive_size_extension.dart';
import 'package:evently/core/extensions/responsive_sized_box_extension.dart';
import 'package:evently/core/responsive/responsive_config.dart';
import 'package:evently/core/utils/dialog_utils.dart';
import 'package:evently/core/utils/firebase_exceptions.dart';
import 'package:evently/core/utils/focus_util.dart';
import 'package:evently/core/utils/toast_utils.dart';
import 'package:evently/core/utils/validations.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/models/user.dart';
import 'package:evently/providers/user_provider.dart';
import 'package:evently/ui/auth_flow/widgets/auth_withgoogle_button.dart';
import 'package:evently/ui/auth_flow/widgets/create_or_dont_have_account.dart';
import 'package:evently/ui/auth_flow/widgets/custom_button.dart';
import 'package:evently/ui/auth_flow/widgets/custom_text_form_field.dart';
import 'package:evently/ui/auth_flow/widgets/or_row.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: "ali1@gmail.com");
    _passwordController = TextEditingController(text: "Password&123");
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ResponsiveConfig.init(context);

    return GestureDetector(
      onTap: () => FocusUtil.hideKeyboard(context),
      child: Scaffold(
        appBar: AppBar(
          title: Image.asset(
            Theme.of(context).brightness == Brightness.dark
                ? Assets.imagesEventlyIconDark
                : Assets.imagesEventlyIcon,
            height: 28.height,
          ),
        ),
        body: Padding(
          padding: AppPadding.view,
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  // login text
                  20.verticalSizedBox,
                  Text(
                    AppLocalizations.of(context)!.loginToYourAccount,
                    style: Theme.of(context).textTheme.labelLarge,
                  ),

                  // form fields
                  24.verticalSizedBox,
                  CustomTextFormField(
                    controller: _emailController,
                    validator: (value) =>
                        Validations().validateEmail(value, context),
                    labelText: AppLocalizations.of(context)!.enterYourEmail,
                    prefixIcon: Icons.email_outlined,
                  ),
                  16.verticalSizedBox,
                  CustomTextFormField(
                    controller: _passwordController,
                    validator: (value) =>
                        Validations().validatePassword(value, context),
                    labelText: AppLocalizations.of(context)!.enterYourPassword,
                    prefixIcon: Icons.lock_outline,
                    suffixIcon: Icons.visibility_off_outlined,
                    isPassword: true,
                  ),

                  // forget password
                  8.verticalSizedBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.forgetPasswordView,
                          );
                        },
                        child: Text(
                          AppLocalizations.of(context)!.forgetPassword,
                          style: Theme.of(context).textTheme.titleSmall!
                              .copyWith(
                                color: Theme.of(context).colorScheme.primary,
                                decoration: TextDecoration.underline,
                                decorationThickness: 2,
                                decorationColor: Theme.of(
                                  context,
                                ).colorScheme.primary,
                              ),
                        ),
                      ),
                    ],
                  ),

                  // login button
                  50.verticalSizedBox,
                  CustomButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        DialogUtils.showLoadingDialog(context);
                        try {
                          final credential = await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                                email: _emailController.text,
                                password: _passwordController.text,
                              );
                          final userCredential = credential.user;
                          print('The user credential is $userCredential');
                          final newUser = userCredential != null
                              ? UserModel(
                                  uid: userCredential.uid,
                                  email: userCredential.email ?? '',
                                  name: userCredential.displayName ?? '',
                                )
                              : null;

                          await context.read<UserProvider>().getUserData(
                            newUser!.uid,
                          );
                          Navigator.pop(context);
                          ToastUtils.showSuccessToast(
                            AppLocalizations.of(context)!.loggedInSuccessfully,
                            context,
                          );
                          Navigator.pushReplacementNamed(
                            context,
                            AppRoutes.mainLayoutView,
                          );
                        } on FirebaseAuthException catch (e) {
                          String errorMessage =
                              FirebaseAuthExceptions.getMessage(e, context);
                          Navigator.pop(context);
                          ToastUtils.showErrorToast(errorMessage, context);
                        } catch (e) {
                          Navigator.pop(context);
                          ToastUtils.showErrorToast(e.toString(), context);
                        }
                      }
                    },
                    label: AppLocalizations.of(context)!.login,
                  ),

                  // sign up text
                  50.verticalSizedBox,
                  CreateOrDontHaveAccount(
                    text: AppLocalizations.of(context)!.dontHaveAnAccount,
                    textButton: AppLocalizations.of(context)!.signUp,
                    onTap: () {
                      Navigator.pushReplacementNamed(
                        context,
                        AppRoutes.registerView,
                      );
                    },
                  ),

                  // or
                  32.verticalSizedBox,
                  OrRow(),

                  // login with google button
                  24.verticalSizedBox,
                  AuthWithgoogleButton(
                    label: AppLocalizations.of(context)!.loginWithGoogle,
                    toastMessage: AppLocalizations.of(
                      context,
                    )!.loggedInSuccessfully,
                  ),

                  24.verticalSizedBox,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
