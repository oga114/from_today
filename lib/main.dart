import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('今日からあの日まで…'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_selectedDate != null)
              Text('Selected Date: ${DateFormat('yyyy-MM-dd').format(_selectedDate!)}'),
            if (_selectedDate != null)
              SizedBox(height: 20), // 選択した日と日数の表示の間にスペースを追加
            if (_selectedDate != null)
              Text(
                'Days difference: ${_calculateDaysDifference()}',
                style: TextStyle(fontSize: 2 * Theme.of(context).textTheme.headline6!.fontSize!), // フォントサイズを3倍に設定
              ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _selectDate(context),
              child: Text('Select Date'),
            ),

          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  int _calculateDaysDifference() {
    if (_selectedDate == null) {
      return 0;
    } else {
      DateTime today = DateTime.now().toLocal().subtract(Duration(hours: DateTime.now().hour, minutes: DateTime.now().minute, seconds: DateTime.now().second, milliseconds: DateTime.now().millisecond, microseconds: DateTime.now().microsecond));
      return _selectedDate!.difference(today).inDays.abs();
    }
  }
}
