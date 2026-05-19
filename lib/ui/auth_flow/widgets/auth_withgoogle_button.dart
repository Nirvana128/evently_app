import 'package:evently/core/constants/app_images.dart';
import 'package:evently/core/constants/app_routes.dart';
import 'package:evently/core/utils/dialog_utils.dart';
import 'package:evently/core/utils/toast_utils.dart';
import 'package:evently/models/user.dart';
import 'package:evently/providers/user_provider.dart';
import 'package:evently/services/firebase_service.dart';
import 'package:evently/ui/auth_flow/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthWithgoogleButton extends StatelessWidget {
  final String label;
  final String toastMessage;
  const AuthWithgoogleButton({
    super.key,
    required this.label,
    required this.toastMessage,
  });

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      onPressed: () async {
        try {
          DialogUtils.showLoadingDialog(context);

          final credential = await FirebaseService().signInWithGoogle();

          Navigator.pop(context);

          if (credential == null) {
            return;
          }

          final userCredential = credential.user;
          print('The user credential is $userCredential');
          final newUser = userCredential != null
              ? UserModel(
                  uid: userCredential.uid,
                  email: userCredential.email ?? '',
                  name: userCredential.displayName ?? '',
                )
              : null;
          await FirebaseService.addUserToFirestore(newUser!);

          context.read<UserProvider>().updateUserData(newUser);

          ToastUtils.showSuccessToast(toastMessage, context);

          Navigator.pushReplacementNamed(context, AppRoutes.mainLayoutView);
        } catch (e) {
          Navigator.pop(context);
          if (e.toString().contains('canceled')) {
            return;
          }
          ToastUtils.showErrorToast(e.toString(), context);
          print("Error is: $e");
        }
      },
      isGoogleButton: true,
      labelWidget: Text(
        label,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      icon: Image.asset(Assets.imagesGoogle),
      backgroundColor: Theme.of(context).colorScheme.surface,
      borderSideColor: Theme.of(context).colorScheme.onSurface,
    );
  }
}
