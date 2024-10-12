import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:to_do/AboutApp.dart';
import 'package:to_do/ArcheivedTasks.dart';
import 'package:to_do/DoneTasks.dart';
import 'package:to_do/Home.dart';
import 'package:to_do/color.dart';
import 'package:to_do/cubit.dart';
import 'package:to_do/stateCubit.dart';
import 'package:to_do/Deafults.dart';

// ignore: must_be_immutable
class todo extends StatelessWidget {
  todo({super.key});

  var title_controloler = TextEditingController();

  var Date_controloler = TextEditingController(
      text: DateFormat('d-M-yyyy').format(DateTime.now()));

  var formkey = GlobalKey<FormState>();

  final _ScaffoldMessenger = GlobalKey<ScaffoldState>();
  DateTime? time;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ToDO_Cubit()..createDatabase(),
      child: BlocConsumer<ToDO_Cubit, stateCubit>(
        builder: (context, state) {
          ToDO_Cubit cubit = ToDO_Cubit.get(context); //جوا البيلدر
          return Scaffold(
            backgroundColor: h,
            key: _ScaffoldMessenger,
            floatingActionButton: cubit.CurrentIndex == 0
                ? FloatingActionButton(
                    backgroundColor: const Color(0xffEAFCFF),
                    onPressed: () {
                      if (cubit.shownBottomSheet) {
                        if (formkey.currentState!.validate()) {
                          cubit.insertDatabase(
                            title: title_controloler.text,
                            dataform: Date_controloler.text,
                          );
                          Date_controloler.text =
                              DateFormat('d-M-yyyy').format(DateTime.now());

                          title_controloler.text = "";
                          // Date_controloler.clear();

                          Navigator.pop(context);
                          cubit.changeBottomSheet(
                              icon: Icons.edit, isshown: false);

                          // cubit. shownBottomSheet = false;
                          // cubit. floaticon = Icons.edit;
                        }
                      } else {
                        _ScaffoldMessenger.currentState!
                            .showBottomSheet(
                              (context) {
                                return Container(
                                  padding: const EdgeInsets.all(20),
                                  color: b,
                                  width: double.infinity,
                                  child: Form(
                                    key: formkey,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        DefaultForm(
                                            validate: (value) {
                                              if (value!.isEmpty) {
                                                return 'please add the title of the task';
                                              }
                                              return null;
                                            },
                                            inputType: TextInputType.text,
                                            controller: title_controloler,
                                            label: "Title",
                                            PrefIcon: Icons.title),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        // DefaultForm(
                                        //     validate: (value) {
                                        //       if (value!.isEmpty) {
                                        //         return 'please add the time of the task';
                                        //       }
                                        //       return null;
                                        //     },
                                        //     ontap: () {
                                        //       showTimePicker(
                                        //               context: context,
                                        //               initialTime:
                                        //                   TimeOfDay.now())
                                        //           .then(
                                        //         (value) {
                                        //           Time_controloler.text = value!
                                        //               .format(context)
                                        //               .toString();
                                        //         },
                                        //       );
                                        //     },
                                        //     inputType: TextInputType.none,
                                        //     controller: Time_controloler,
                                        //     label: "Time",

                                        //     PrefIcon: Icons.watch_later_outlined),
                                        // const SizedBox(
                                        //   height: 10,
                                        // ),
                                        DefaultForm(
                                            validate: (value) {
                                              if (value!.isEmpty) {
                                                return 'please add the date of the task';
                                              }
                                              return null;
                                            },
                                            ontap: () {
                                              showDatePicker(
                                                context: context,
                                                firstDate: DateTime.now(),
                                                lastDate: DateTime(2100),
                                              ).then(
                                                (value) {
                                                  // datetime = DateFormat('d-M-yyyy').format(value!);
                                                  Date_controloler.text =
                                                      DateFormat('d-M-yyyy')
                                                          .format(value!);
                                                  // time = value;
                                                },
                                              );
                                            },
                                            inputType: TextInputType.none,
                                            controller: Date_controloler,
                                            label: "Date",
                                            PrefIcon: Icons.calendar_month),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            )
                            .closed
                            .then(
                              (value) {
                                cubit.changeBottomSheet(
                                    icon: Icons.edit, isshown: false);

                                // cubit.shownBottomSheet = false;//Assign in the cubit ?

                                // // setState(() {});
                                // cubit.floaticon = Icons.edit; //اعملها بفانكشن علشان يإيميت
                              },
                            );

                        cubit.changeBottomSheet(icon: Icons.add, isshown: true);

                        // cubit.  shownBottomSheet = true;
                        // cubit.  floaticon = Icons.add;
                      }
                      // setState(() {});
                    },
                    child: Icon(
                      cubit.floatIcon,
                      color: Colors.black,
                    ),
                  )
                : null,
            bottomNavigationBar: BottomNavigationBar(
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.white38,
              backgroundColor: const Color(0xff1B2E3C),
              currentIndex: cubit.CurrentIndex,
              onTap: (value) {
                (value);
                cubit.Bottom_Navigation_Bar_index(value);

                // setState(() {});
              },
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.task_alt_rounded), label: "Done Tasks"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.archive_rounded), label: "Archeived"),
              ],
            ),
            appBar: AppBar(
                actions: [
                  PopupMenuButton<String>(
                    color: Color.fromARGB(206, 46, 44, 44),
                    icon: Icon(Icons.more_vert,
                        color: Colors.white), // Change color here

                    onSelected: (value) {
                      if (value == 'About App')
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => About_App(),
                        ));
                      // Handle the selected value
                    },
                    itemBuilder: (BuildContext context) {
                      return {'About App'}.map((String choice) {
                        return PopupMenuItem<String>(
                          value: choice,
                          child: Text(
                            choice,
                            style: TextStyle(color: Colors.white),
                          ),
                        );
                      }).toList();
                    },
                  ),
                ],
                // centerTitle: cubit.CurrentIndex == 0 ? true : true,
                automaticallyImplyLeading: false,
                // backgroundColor: Colors.teal,
                title: Text(
                  "ToDO List",
                  style: const TextStyle(color: Colors.white),
                )),
            body: Pages[cubit.CurrentIndex],
          );
        },
        listener: (context, state) {},
      ),
    );
  }
}

List Pages = [ Home(), Done(), Archeive()];
// List Titles = [
//   'ToDO List',
//   '',
//   '',
// ];
