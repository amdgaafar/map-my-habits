import 'package:objectbox/objectbox.dart';

@Entity()
class Habit {
  @Id()
  int id;

  @Property()
  String? title;

  @Property()
  String? description;

  Habit({
    this.id = 0,
    required this.title,
    required this.description,
  });
}
