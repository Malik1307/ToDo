import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:to_do/color.dart';
import 'package:to_do/cubit.dart';
import 'package:to_do/observer.dart';
import 'package:to_do/state.dart';
import 'package:intl/intl.dart';

void main() {
  Bloc.observer = MyBlocObserver();

  runApp(MaterialApp(
      theme: ThemeData(
          appBarTheme: const AppBarTheme(backgroundColor: Color(0xff1B2E3C))),
      debugShowCheckedModeBanner: false,
      home: todo()));
}

Widget buildtask(Map task, context) {
  final DateFormat format = DateFormat('d-M-yyyy');

  String timeNow_string = format.format(DateTime.now());
  String taskTime_string = task['datetime'];

  DateTime parseDate(String dateString) {
    return format.parse(dateString);
  }

  DateTime timeNow = parseDate(timeNow_string);
  DateTime taskTime = parseDate(taskTime_string);

  Duration difference = taskTime.difference(timeNow);

  return Dismissible(
      key: Key(task["id"].toString()),
      onDismissed: (direction) {
        ToDO_Cubit.get(context).delete_database(id: task['id']);
      },
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: AnimatedContainer(
          duration: const Duration(seconds: 1),
          curve: Curves.easeInOut,
          child: const Icon(
            Icons.delete,
            color: Colors.white,
          ),
        ),
      ),
      child: InkWell(
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('ToDo'),
                content: Text(
                  '${task['title']}',
                  style: TextStyle(fontSize: 20),
                ),
                // actions: <Widget>[

                //   TextButton(
                //     child: Text('OK'),
                //     onPressed: () {
                //       // Perform any action here
                //       Navigator.of(context).pop();
                //     },
                //   ),
                // ],
              );
            },
          );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Row(
            // mainAxisSize: MainAxisSize.max,

            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                width: 85,
                height: 85,
                child: CircleAvatar(
                  radius: 40,
                  backgroundColor: task['status'] == 'New'
                      ? c
                      : task['status'] == 'Done'
                          ? Colors.green[700]
                          : Colors.grey[600],
                  child: task['status'] == "New"
                      ? Text(
                          circule(difference.inDays),
                          style: TextStyle(
                            color: difference.inDays < 0
                                ? Colors.red
                                : Colors.grey,
                          ),
                          textAlign: TextAlign.center,
                        )
                      : Text(
                          '${task['status']}',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              // SizedBox(height: 40,),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  task['status'] == 'Done'
                      ? SizedBox(
                          height: 40,
                          width: 120,
                          child: Text(
                            '${task['title']}',
                            // maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                letterSpacing: 1.52,
                                fontWeight: FontWeight.w500,
                                decoration: TextDecoration.lineThrough),
                          ),
                        )
                      : SizedBox(
                          height: 40,
                          width: 120,
                          child: Text(
                            '${task['title']}',
                            // maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                letterSpacing: 1.52,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    '${task['data']}',
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey[100],
                        letterSpacing: 1.52),
                  ),
                ],
              ),

              const SizedBox(
                width: 30,
              ),

              IconButton(
                onPressed: () {
                  ToDO_Cubit.get(context)
                      .update_databse(stat: "Done", id: task['id']);
                },
                icon: const Icon(
                  Icons.check_box_rounded,
                  color: Color.fromARGB(255, 21, 119, 24),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              IconButton(
                  onPressed: () {
                    ToDO_Cubit.get(context)
                        .update_databse(stat: "Archeived", id: task['id']);
                  },
                  icon: const Icon(
                    Icons.archive,
                    color: Colors.black,
                  )),
            ],
          ),
        ),
      ));
}

Widget buildPage(List<Map> task) {
  return task.isEmpty
      ? const Center(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 252,
              ),
              Icon(
                Icons.block,
                size: 80,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "No Tasks To Display",
                style: TextStyle(color: Colors.black, fontSize: 20),
              )
            ],
          ),
        )
      : ListView.separated(
          itemBuilder: (context, index) =>
              buildtask(task.reversed.toList()[index], context),
          itemCount: task.length,
          separatorBuilder: (context, index) => Container(
            margin: const EdgeInsetsDirectional.only(start: 20),
            height: 1,
            width: double.infinity,
            color: Colors.grey[300],
          ),
        );
}

// DateTime _parseCustomDate(String dateStr) {
//   // Split the custom date format string
//   List<String> parts = dateStr.split('-');
//   String weekday = parts[0];
//   int month = int.parse(parts[1]);

//   // Find the current year
//   int currentYear = DateTime.now().year;

//   // Parse the weekday to find the first occurrence of the specified day in the specified month
//   DateTime baseDate = DateTime(currentYear, month, 1);
//   while (DateFormat('EEEE').format(baseDate) != weekday) {
//     baseDate = baseDate.add(const Duration(days: 1));
//   }

//   return baseDate;
// }

String circule(int day) {
  if (day == 0)
    return "Today";
  else if (day == 1)
    return "Tomorrow";
  else if (day > 1 && day < 15)
    return "In $day Days";
  else if (day >= 15)
    return "In ${day / 7} Weeks";
  else {
    return "Missed Task";
  }
}
