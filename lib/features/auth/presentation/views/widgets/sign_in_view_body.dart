import 'package:atm_app/features/auth/presentation/views/widgets/sign_in_button_bloc_builder.dart';
import 'package:flutter/material.dart';

class SignInViewBody extends StatelessWidget {
  const SignInViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SignInButtonBlocBuilder(),
    );
  }
}
