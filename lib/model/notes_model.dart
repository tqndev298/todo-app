// ignore_for_file: public_member_api_docs, sort_constructors_first
class Note {
  String id;
  String subtitle;
  String title;
  String time;
  int image;
  bool isDone;
  Note({
    required this.id,
    required this.subtitle,
    required this.title,
    required this.time,
    required this.image,
    required this.isDone,
  });
}
