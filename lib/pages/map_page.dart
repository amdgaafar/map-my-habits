import 'package:flutter/material.dart';
import 'package:simple_heatmap_calendar/simple_heatmap_calendar.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MapPage> createState() => _MapPage();
}

class _MapPage extends State<MapPage> {
  final Map<DateTime, num> testSimple = {
    DateTime(2024, 1, 1): 40,
    DateTime(2024, 1, 2): 40,
    DateTime(2024, 1, 3): 40,
    DateTime(2024, 1, 8): 40,
  };

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
                endedDate: DateTime(2024, 1, 9),
                firstDay: DateTime.monday,
                colorMap: {
                  10: theme.primaryColor.withOpacity(0.2),
                  20: theme.primaryColor.withOpacity(0.4),
                  30: theme.primaryColor.withOpacity(0.6),
                  40: theme.primaryColor.withOpacity(0.8),
                  50: theme.primaryColor,
                },
                selectedMap: testSimple,
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
