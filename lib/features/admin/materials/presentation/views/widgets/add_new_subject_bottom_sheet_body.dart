import 'package:atm_app/features/admin/materials/presentation/views/widgets/add_new_subject_button_bloc_builder.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/widgets/invisibla_text_field.dart';

class AddImageNoteBottomSheetBody extends StatefulWidget {
  const AddImageNoteBottomSheetBody({super.key});

  @override
  State<AddImageNoteBottomSheetBody> createState() =>
      _AddImageNoteBottomSheetBodyState();
}

class _AddImageNoteBottomSheetBodyState
    extends State<AddImageNoteBottomSheetBody> {
  final TextEditingController _subjectTitleController = TextEditingController();

  String? imageNotePath;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _subjectTitleController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 28,
        left: 16,
        right: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            /*SizedBox(
              height: 330,
              width: double.infinity,
              child: Card(
                elevation: 10,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: (imageNotePath != null)
                      ? Image.file(
                          File(imageNotePath!),
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          'assets/210.png',
                          fit: BoxFit.cover,
                        ),
                ),
              ),
            ),
            const SizedBox(height: 16),*/
            InvisibleTextField(
              controller: _subjectTitleController,
              hintText: 'Image Title',
              textStyle: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            /*CustomTextButton(
              title: 'Choose Image',
              onPressed: () async {
                final imagePath = await _imagePicker(
                  context: context,
                  imageSource: ImageSource.gallery,
                );
                //if iamgePath var not null then set state to display
                //picked image to the user immedietly
                if (imagePath != null) {
                  setState(() {
                    imageNotePath = imagePath;
                  });
                }
              },
            ),
            CustomTextButton(
              title: 'Take Image',
              onPressed: () async {
                final imagePath = await _imagePicker(
                  context: context,
                  imageSource: ImageSource.camera,
                );
                if (imagePath != null) {
                  setState(() {
                    imageNotePath = imagePath;
                  });
                }
              },
            ),*/
            const SizedBox(
              height: 16,
            ),
            AddNewSubjectButtonBlocBuilder(
              subjectTitleController: _subjectTitleController,
            ),
          ],
        ),
      ),
    );
  }

  /*_imagePicker(
      {required BuildContext context, required ImageSource imageSource}) async {
    final pickedImage = await ImageHelper().pickImage(
      imageSource: imageSource,
    );

    if (pickedImage != null) {
      return pickedImage.path;
    }
    return null;
  }

  //adds image to the Data base
  _addImageNoteToTheDB({
    required AddImageNoteCubit addImageNoteCubit,
    required String title,
    required String content,
  }) async {
    //save image file to local
    final String imageLocalPath =
        await LocalFileManager(filePath: imageNotePath!).saveFileToLocal();
    //assemble the received aurgument into image note model
    final ImageNoteModel imageNote = AssembleNote().assembleImageNoteEntry(
      imagePath: imageLocalPath,
      title: _imageNoteTitleController.text,
      content: _iamgeNoteContentController.text,
    );
    //add note to the hive data base
    if (!mounted) return;
    BlocProvider.of<AddImageNoteCubit>(context)
        .addImageNote(imageNote: imageNote);
  }*/
}
