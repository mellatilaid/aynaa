import 'package:atm_app/core/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/common/versions/presentation/manager/delete_version_cubit/delete_version_cubit.dart';

class ThreeDotsMenu extends StatelessWidget {
  final List<PopupMenuEntry<String>> popItems;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const ThreeDotsMenu(
      {super.key,
      required this.onDelete,
      required this.onEdit,
      required this.popItems});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      elevation: 5,
      splashRadius: 5,
      onSelected: (value) {
        if (value == 'تعديل') {
          onEdit();
        } else if (value == 'حذف') {
          onDelete();
        }
      },
      itemBuilder: (context) => popItems,
      child: const Icon(Icons.more_vert), // Three dots icon
    );
  }
}

class DeleteVersionBuilder extends StatelessWidget {
  const DeleteVersionBuilder({
    super.key,
    required this.onDelete,
  });

  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DeleteVersionCubit, DeleteVersionState>(
      builder: (context, state) {
        if (state is DeleteVersionLoading) {
          return const LoadingWidget();
        }
        return IconButton(
          onPressed: onDelete,
          icon: const Icon(
            Icons.delete,
            color: Colors.red,
          ),
        );
      },
    );
  }
}

PopupMenuItem<String> genericPopUpMenuItem<B extends StateStreamable<S>, S>({
  required String value,
  required Widget icon,
}) {
  return PopupMenuItem(
    value: value,
    child: Row(
      children: [
        icon,
        const SizedBox(width: 8),
        Text(value),
      ],
    ),
  );
}
