// ignore_for_file: use_build_context_synchronously

import 'package:evently/core/constants/app_images.dart';
import 'package:evently/core/constants/app_padding.dart';
import 'package:evently/core/constants/app_routes.dart';
import 'package:evently/core/extensions/responsive_size_extension.dart';
import 'package:evently/core/extensions/responsive_sized_box_extension.dart';
import 'package:evently/core/responsive/responsive_config.dart';
import 'package:evently/core/utils/firebase_exceptions.dart';
import 'package:evently/core/utils/focus_util.dart';
import 'package:evently/core/utils/dialog_utils.dart';
import 'package:evently/core/utils/toast_utils.dart';
import 'package:evently/core/utils/validations.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/models/user.dart';
import 'package:evently/providers/user_provider.dart';
import 'package:evently/services/firebase_service.dart';
import 'package:evently/ui/auth_flow/widgets/auth_withgoogle_button.dart';
import 'package:evently/ui/auth_flow/widgets/create_or_dont_have_account.dart';
import 'package:evently/ui/auth_flow/widgets/custom_button.dart';
import 'package:evently/ui/auth_flow/widgets/custom_text_form_field.dart';
import 'package:evently/ui/auth_flow/widgets/or_row.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: "Ali Ibrahim");
    _emailController = TextEditingController(text: "ali2@gmail.com");
    _passwordController = TextEditingController(text: "Password&123");
    _confirmPasswordController = TextEditingController(text: "Password&123");
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
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
                  // Register text
                  20.verticalSizedBox,
                  Text(
                    AppLocalizations.of(context)!.createYourAccount,
                    style: Theme.of(context).textTheme.labelLarge,
                  ),

                  // form fields
                  24.verticalSizedBox,
                  CustomTextFormField(
                    controller: _nameController,
                    validator: (value) =>
                        Validations().validateName(value, context),
                    labelText: AppLocalizations.of(context)!.enterYourName,
                    prefixIcon: Icons.person_outline,
                  ),
                  16.verticalSizedBox,
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
                  16.verticalSizedBox,
                  CustomTextFormField(
                    controller: _confirmPasswordController,
                    validator: (value) => Validations().validateConfirmPassword(
                      value,
                      _passwordController.text,
                      context,
                    ),
                    labelText: AppLocalizations.of(
                      context,
                    )!.confirmYourPassword,
                    prefixIcon: Icons.lock_outline,
                    suffixIcon: Icons.visibility_off_outlined,
                    isPassword: true,
                  ),

                  // Register button
                  50.verticalSizedBox,
                  CustomButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        DialogUtils.showLoadingDialog(context);
                        try {
                          final credential = await FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                                email: _emailController.text,
                                password: _passwordController.text,
                              );

                          print('The user credential is $credential');
                          await FirebaseService.addUserToFirestore(
                            UserModel(
                              name: _nameController.text,
                              email: _emailController.text,
                              uid: credential.user?.uid ?? '',
                            ),
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
                            AppLocalizations.of(
                              context,
                            )!.accountCreatedSuccessfully,
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
                    label: AppLocalizations.of(context)!.signUp,
                  ),

                  // sign up text
                  50.verticalSizedBox,
                  CreateOrDontHaveAccount(
                    text: AppLocalizations.of(context)!.alreadyHaveAnAccount,
                    textButton: AppLocalizations.of(context)!.login,
                    onTap: () {
                      Navigator.pushReplacementNamed(
                        context,
                        AppRoutes.loginView,
                      );
                    },
                  ),

                  // or
                  32.verticalSizedBox,
                  OrRow(),

                  // Register with google button
                  24.verticalSizedBox,
                  AuthWithgoogleButton(
                    label: AppLocalizations.of(context)!.signupwithgoogle,
                    toastMessage: AppLocalizations.of(
                      context,
                    )!.accountCreatedSuccessfully,
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
