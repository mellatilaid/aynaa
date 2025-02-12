/*class LessonContentWidget extends StatefulWidget {
  final LessonEntity lesson;

  const LessonContentWidget({super.key, required this.lesson});

  @override
  _LessonContentWidgetState createState() => _LessonContentWidgetState();
}

class _LessonContentWidgetState extends State<LessonContentWidget> {
  late VideoPlayerController _videoController;
  bool _isVideoInitialized = false;
  late String fileExtension;
  @override
  void initState() {
    super.initState();
    if (widget.lesson.url != null) {
      fileExtension = path.extension(widget.lesson.url ?? '');
      if (fileExtension == '.mp4') {
        _initializeVideoPlayer();
      }
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
    _videoController = VideoPlayerController.network(widget.lesson.url!)
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
        if (widget.lesson.url != null && fileExtension == '.mp4') ...[
          if (_isVideoInitialized)
            SizedBox(
              width: double.infinity,
              child: VideoPlayer(_videoController),
            ),
          const SizedBox(height: 10),
        ] else if (widget.lesson.url != null && fileExtension == '.jpg') ...[
          Image.network(widget.lesson.url!),
          const SizedBox(height: 10),
        ] /*else if (widget.lesson.url != null && fileExtension == '.pdf') ...[
          // Display a placeholder image or thumbnail for the PDF
          //  Image.network(widget.lesson.url!),
          const SizedBox(height: 10),
          Text('PDF Title: ${widget.lesson.url!}',
              style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 10),
          // Display the PDF (you might use a PDF package for viewing the content)
          SizedBox(
            height: 200, // Height for PDF viewer
            child: Text(
              widget.lesson.url!, // File path or URL of the PDF
            ),
          ),
        ]*/
        else if (widget.lesson.url == null) ...[
          Text(widget.lesson.description ?? '',
              style: Theme.of(context).textTheme.bodyLarge),
        ],
        // Always show the content below the media (text content)
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            widget.lesson.description ?? '',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
      ],
    );
  }
}*/
