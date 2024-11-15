import 'package:atm_app/features/auth/presentation/manager/sign_in_cubit/sign_in_cubit.dart';
import 'package:atm_app/features/auth/presentation/views/widgets/sign_in_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/utils/set_up_service_locator.dart';
import '../../domain/repos/auth_repo.dart';

final supabase = Supabase.instance.client;

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignInCubit(getit.get<AuthRepo>()),
      child: const Scaffold(
        body: SignInViewBody(),
      ),
    );
  }
}
