import 'package:atm_app/features/auth/presentation/manager/sign_out_cubit/sign_out_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../core/utils/app_route.dart';

class SignOutButtonBlocBuilder extends StatelessWidget {
  const SignOutButtonBlocBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignOutCubit, SignOutState>(
      listener: (context, state) {
        if (state is SignOutSuccuss) {
          context.pushReplacement(AppRouter.signInView);
        }
      },
      builder: (context, state) {
        return IconButton(
          onPressed: () {
            BlocProvider.of<SignOutCubit>(context).signOut();
          },
          icon: const Icon(Icons.logout),
        );
      },
    );
  }
}
