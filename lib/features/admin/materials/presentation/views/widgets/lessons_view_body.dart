import 'package:atm_app/core/widgets/loading_widget.dart';
import 'package:atm_app/features/admin/materials/domain/entities/subjects_entity.dart';
import 'package:atm_app/features/admin/materials/presentation/manager/fetch_lessons_cubit/fetch_lessons_cubit.dart';
import 'package:atm_app/features/admin/materials/presentation/views/widgets/custom_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/lesson_entity.dart';
import '../../manager/add_lesson_cubit/add_lesson_cubit.dart';

class LessonsViewBody extends StatefulWidget {
  final SubjectsEntity subjectsEntity;
  const LessonsViewBody({super.key, required this.subjectsEntity});

  @override
  State<LessonsViewBody> createState() => _LessonsViewBodyState();
}

class _LessonsViewBodyState extends State<LessonsViewBody> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final versionID = _getVersionID();
    BlocProvider.of<FetchLessonsCubit>(context).fetchLessons(
        subjectID: widget.subjectsEntity.id!, versionID: versionID);
  }

  _getVersionID() {
    final versionID = context.read<AddLessonCubit>().versionID;
    return versionID!;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FetchLessonsCubit, FetchLessonsState>(
      builder: (context, state) {
        if (state is FetchLessonsSuccess) {
          return LessonsListView(lessons: state.lessons);
        } else if (state is FetchLessonsLoading) {
          return const LoadingWidget();
        } else if (state is FetchLessonsFailure) {
          return ErrorWidget(state.errMessage);
        }
        return Container();
      },
    );
  }
}

class LessonsListView extends StatelessWidget {
  final List<LessonEntity> lessons;
  const LessonsListView({super.key, required this.lessons});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: lessons.length,
        itemBuilder: (context, index) {
          return CustomCard(entity: lessons[index]);
        });
  }
}


import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart'; // Package for PDF viewing
import 'package:video_player/video_player.dart'; // Package for video playing

// Assuming you have a Lesson class that defines the content of the lesson
class Lesson {
  final String type; // 'video', 'image', 'pdf', or 'text'
  final String content; // The textual content of the lesson
  final String mediaUrl; // URL for video, image, or PDF file

  Lesson({required this.type, required this.content, required this.mediaUrl});
}

class LessonContentWidget extends StatefulWidget {
  final Lesson lesson;

  const LessonContentWidget({super.key, required this.lesson});

  @override
  _LessonContentWidgetState createState() => _LessonContentWidgetState();
}

class _LessonContentWidgetState extends State<LessonContentWidget> {
  late VideoPlayerController _videoController;
  bool _isVideoInitialized = false;

  @override
  void initState() {
    super.initState();
    if (widget.lesson.type == 'video') {
      _initializeVideoPlayer();
    }
  }

  @override
  void dispose() {
    if (_isVideoInitialized) {
      _videoController.dispose();
    }
    super.dispose();
  }

  void _initializeVideoPlayer() {
    _videoController = VideoPlayerController.network(widget.lesson.mediaUrl)
      ..initialize().then((_) {
        setState(() {
          _isVideoInitialized = true;
        });
        _videoController.play();
      });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.lesson.type == 'video') ...[
          if (_isVideoInitialized)
            SizedBox(
              width: double.infinity,
              child: VideoPlayer(_videoController),
            ),
          const SizedBox(height: 10),
        ] else if (widget.lesson.type == 'image') ...[
          Image.network(widget.lesson.mediaUrl),
          const SizedBox(height: 10),
        ] else if (widget.lesson.type == 'pdf') ...[
          // Display a placeholder image or thumbnail for the PDF
          Image.network(widget.lesson.mediaUrl),
          const SizedBox(height: 10),
          Text('PDF Title: ${widget.lesson.mediaUrl}', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 10),
          // Display the PDF (you might use a PDF package for viewing the content)
          SizedBox(
            height: 200, // Height for PDF viewer
            child: PDFView(
              filePath: widget.lesson.mediaUrl, // File path or URL of the PDF
            ),
          ),
        ] else if (widget.lesson.type == 'text') ...[
          Text(widget.lesson.content, style: Theme.of(context).textTheme.bodyLarge),
        ],
        // Always show the content below the media (text content)
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            widget.lesson.content,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
      ],
    );
  }
}
