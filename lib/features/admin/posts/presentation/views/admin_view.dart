import 'package:atm_app/core/services/supabase_DB.dart';
import 'package:atm_app/features/admin/posts/data/repos/post_repo_impl.dart';
import 'package:atm_app/features/admin/posts/domain/entities/post_entity.dart';
import 'package:atm_app/features/admin/posts/domain/use_cases/add_post_use_case.dart';
import 'package:atm_app/features/admin/posts/presentation/manager/add_post_cubit/add_post_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminView extends StatelessWidget {
  const AdminView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddPostCubit(
        addPostUseCase: AddPostUseCase(
          postsRepo: PostRepoImpl(dataBase: SupabaseDb()),
        ),
      ),
      child: const Scaffold(
        body: AdminViewBody(),
      ),
    );
  }
}

class AdminViewBody extends StatefulWidget {
  const AdminViewBody({super.key});

  @override
  State<AdminViewBody> createState() => _AdminViewBodyState();
}

class _AdminViewBodyState extends State<AdminViewBody> {
  final titleController = TextEditingController();
  final contentController = TextEditingController(
      text:
          "'mn if it’s set to UUID typeQuery Filter Issue: If you’re filtering by id in a query with something like .eq('id', '500')this will fail because Supabase/PostgreSQL expects the value to be in a UUID format for UUID columns.'");

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    titleController.dispose();
    contentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: titleController,
            ),
            const SizedBox(
              height: 16,
            ),
            BlocBuilder<AddPostCubit, AddPostState>(
              builder: (context, state) {
                if (state is AddPostLoading) {
                  return const CircularProgressIndicator();
                } else if (state is AddPostFailure) {
                  return ErrorWidget(state.errMessage);
                }
                return ElevatedButton(
                    onPressed: () {
                      final PostEntity post = PostEntity(
                        title: titleController.text,
                        content: contentController.text,
                        postID: "123e4567-e89b-12d3-a456-426614174000",
                        timeStamp: DateTime.now().toString(),
                      );
                      BlocProvider.of<AddPostCubit>(context)
                          .addPost(post: post);
                    },
                    child: const Text('add post'));
              },
            ),
          ],
        ),
      ),
    );
  }
}
