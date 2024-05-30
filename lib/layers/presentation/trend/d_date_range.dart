import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:urine/common/cli_common.dart';
import 'package:urine/common/common.dart';
import 'package:urine/layers/presentation/widget/style_text.dart';

/// 날짜 범위 설정가능한  다이얼로그
class DateRangeDialog extends StatefulWidget {
  final Function(DateTime?, DateTime?) onSubmit;

  const DateRangeDialog({
    super.key,
    required this.onSubmit,
  });

  @override
  State<DateRangeDialog> createState() => _DateRangeDialogState();
}

class _DateRangeDialogState extends State<DateRangeDialog> {
  DateTime? _rangeStart = DateTime.now();
  DateTime? _rangeEnd = DateTime.now();
  DateTime? _selectedDay;
  DateTime _focusedDay = DateTime.now();
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOn;

  String get cancelText => '취소';

  String get submitText => '확인';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        width: 400,
        height: 460,
        child: TableCalendar(
          formatAnimationDuration: 400.ms,
          firstDay: DateTime(2000),
          lastDay: DateTime.now(),
          rowHeight: 60,
          focusedDay: _focusedDay,
          selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
          startingDayOfWeek: StartingDayOfWeek.sunday,
          calendarStyle: getCalenderStyle(context),
          headerStyle: geHeaderStyle(context),
          headerVisible: true,
          daysOfWeekVisible: true,
          rangeStartDay: _rangeStart,
          rangeEndDay: _rangeEnd,
          rangeSelectionMode: _rangeSelectionMode,
          onDaySelected: (selectedDay, focusedDay) {
            if (!isSameDay(_selectedDay, selectedDay)) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
                _rangeStart = null; // Important to clean those
                _rangeEnd = null;
                _rangeSelectionMode = RangeSelectionMode.toggledOff;
              });
            }
          },
          onRangeSelected: (start, end, focusedDay) {
            setState(() {
              _selectedDay = null;
              _focusedDay = focusedDay;
              _rangeStart = start;
              _rangeEnd = end;
              _rangeSelectionMode = RangeSelectionMode.toggledOn;
              print('$_rangeStart / $_rangeEnd');
            });
          },
          calendarBuilders: CalendarBuilders(
            /// week head Text Style (월, 화, 수...)
            dowBuilder: (context, day) =>
                _buildWeekHeaderTestStyle(context, day),
          ),
        ),
      ),
      actionsAlignment: MainAxisAlignment.center,
      actionsPadding: const EdgeInsets.all(0.0),
      actions: <Widget>[
        Row(
          children:
          [
            /// 취소 버튼
            Expanded(
              child: SizedBox(
                height: AppConstants.buttonHeight,
                child: TextButton(
                    onPressed: () => Nav.doPop(context),
                    style: TextButton.styleFrom(
                      backgroundColor: AppColors.brightGrey,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                    child: StyleText(
                        text: cancelText, color: AppColors.blackTextColor)),
              ),
            ),

            /// 확인 버튼
            Expanded(
              child: SizedBox(
                height: AppConstants.buttonHeight,
                child: TextButton(
                    onPressed: () => {
                          widget.onSubmit(_rangeStart, _rangeEnd),
                          Nav.doPop(context),
                        },
                    style: TextButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                      backgroundColor: AppColors.primaryColor,
                    ),
                    child: StyleText(text: submitText, color: AppColors.white)),
              ),
            ),
          ],
        )
      ],
    );
  }

  HeaderStyle geHeaderStyle(BuildContext context) {
    return HeaderStyle(
      titleCentered: true,
      leftChevronVisible: false,
      rightChevronVisible: false,
      formatButtonVisible: false,
      headerMargin: const EdgeInsets.only(top: AppDim.medium, bottom: AppDim.large),
      titleTextStyle: TextStyle(
        fontSize: AppDim.fontSizeXLarge,
        color: AppColors.blackTextColor,
        fontWeight: AppDim.weightBold,
      ),
      //rightChevronIcon: Icon(Icons.chevron_right, color: AppColors.veryDarkGrey, size: AppDim.iconMedium),
    );
  }

  CalendarStyle getCalenderStyle(BuildContext context) {
    return CalendarStyle(
      outsideDaysVisible: true,
      cellMargin: AppDim.paddingXSmall,
      weekendTextStyle: const TextStyle().copyWith(color: Colors.red),
      todayDecoration: BoxDecoration(
        color: AppColors.primaryColor,
        shape: BoxShape.circle,
      ),
      todayTextStyle: const TextStyle(color: AppColors.white),
      selectedDecoration: BoxDecoration(
        color: AppColors.primaryColor,
        shape: BoxShape.circle,
      ),
      selectedTextStyle: const TextStyle(color: AppColors.white),
    );
  }

  _buildWeekHeaderTestStyle(BuildContext context, DateTime day) {
    if (day.weekday == DateTime.sunday) {
      final text = DateFormat.E().format(day);
      return Center(
        child: Text(
          text,
          style: const TextStyle(color: Colors.red),
        ),
      );
    }
    if (day.weekday == DateTime.saturday) {
      final text = DateFormat.E().format(day);
      return Center(
        child: Text(
          text,
          style: const TextStyle(color: Colors.blue),
        ),
      );
    }
  }
}
