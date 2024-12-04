import 'package:atm_app/features/admin/materials/presentation/manager/creata_new_aynaa_version_cubit/create_new_aynaa_version_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AynaaVersionsViewBody extends StatelessWidget {
  const AynaaVersionsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateNewAynaaVersionCubit, CreateNewAynaaVersionState>(
      builder: (context, state) {
        return Container();
      },
    );
  }
}
