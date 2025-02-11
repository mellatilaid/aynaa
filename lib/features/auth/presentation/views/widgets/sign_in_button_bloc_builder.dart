import 'package:atm_app/core/const/remote_db_const.dart';
import 'package:atm_app/core/utils/app_route.dart';
import 'package:atm_app/core/utils/set_up_service_locator.dart';
import 'package:atm_app/core/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/helper/enums.dart';
import '../../../../../core/widgets/custom_action_button.dart';
import '../../manager/sign_in_cubit/sign_in_cubit.dart';

class SignInButtonBlocBuilder extends StatelessWidget {
  const SignInButtonBlocBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInCubit, SignInState>(
      listener: (context, state) {
        // TODO: implement listener
        if (state is SignInSuccuss) {
          if (state.userEntity.role == kAdminRole) {
            setUpServiceLocator(userRole: UserRole.admin);
            context.pushReplacement(AppRouter.adminNavBarView);
          } else if (state.userEntity.role == kUserRole) {
            setUpServiceLocator(userRole: UserRole.student);
            context.pushReplacement(AppRouter.adminHomeView);
          }
        }
      },
      builder: (context, state) {
        if (state is SignInLoading) {
          return const LoadingWidget();
        } else if (state is SignInFailure) {
          return ErrorWidget(state.errMessage);
        }

        return CustomActionButton(
          onPressed: () {
            BlocProvider.of<SignInCubit>(context).signInWithGoogle();
          },
          icon: const FaIcon(FontAwesomeIcons.google),
          label: 'sing in with google',
        );
      },
    );
  }
}
