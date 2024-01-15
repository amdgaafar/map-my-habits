import 'package:objectbox/objectbox.dart';

@Entity()
class Habit {
  @Id()
  int id;

  @Property()
  String? title;

  @Property()
  String? description;

  @Backlink()
  final habitRecords = ToMany<HabitRecord>();

  Habit({
    this.id = 0,
    required this.title,
    required this.description,
  });
}

@Entity()
class HabitRecord {
  @Id()
  int id;

  @Property()
  DateTime date;

  @Property()
  bool isDone;

  final habit = ToOne<Habit>();

  HabitRecord({
    this.id = 0,
    required this.date,
    required this.isDone,
    Habit? habit,
  }) {
    this.habit.target = habit;
  }
}
