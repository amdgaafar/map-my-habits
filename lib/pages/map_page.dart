import 'package:flutter/material.dart';
import 'package:map_my_habits/models/habit.dart';
import 'package:map_my_habits/objectbox.g.dart';
import 'package:simple_heatmap_calendar/simple_heatmap_calendar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MapPage> createState() => _MapPage();
}

class _MapPage extends State<MapPage> {
  late Store _store;

  Map<DateTime, num> daysChecked = {};

  @override
  void initState() {
    super.initState();
    getApplicationDocumentsDirectory().then((dir) {
      _store = Store(
        getObjectBoxModel(),
        directory: join(dir.path, 'objectbox'),
      );
      _fetchHabitRecords();
    });
  }

  @override
  void dispose() {
    _store.close();
    super.dispose();
  }

  Future<void> _fetchHabitRecords() async {
    final box = _store.box<HabitRecord>();
    final records = box.getAll();
    setState(() {
      daysChecked.addAll({
        for (var record in records)
          DateTime(record.date.year, record.date.month, record.date.day):
              record.isDone ? 30 : 0,
      });
    });
    print(daysChecked);
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            color: Colors.white.withOpacity(0.9),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: HeatmapCalendar<num>(
                startDate: DateTime(2023, 12, 1),
                endedDate: DateTime(2024, 1, 31),
                firstDay: DateTime.monday,
                colorMap: {
                  0: theme.primaryColor.withOpacity(0.2),
                  1: theme.primaryColor.withOpacity(0.4),
                  2: theme.primaryColor.withOpacity(0.6),
                  3: theme.primaryColor.withOpacity(0.8),
                  4: theme.primaryColor,
                },
                selectedMap: daysChecked,
                cellSize: const Size.square(26),
                colorTipCellSize: const Size.square(12.0),
                style: const HeatmapCalendarStyle.defaults(
                  cellValueFontSize: 6.0,
                  cellRadius: BorderRadius.all(Radius.circular(4.0)),
                  weekLabelValueFontSize: 12.0,
                  monthLabelFontSize: 12.0,
                ),
                layoutParameters: const HeatmapLayoutParameters.defaults(
                  monthLabelPosition: CalendarMonthLabelPosition.top,
                  weekLabelPosition: CalendarWeekLabelPosition.right,
                  colorTipPosition: CalendarColorTipPosition.bottom,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
