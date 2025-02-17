class QuestionEntity {
  final String entityID;
  final String question;
  final String answer;
  final List<String> options;

  QuestionEntity(
      {required this.entityID,
      required this.question,
      required this.answer,
      required this.options});
}
