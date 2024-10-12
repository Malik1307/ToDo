import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:to_do/stateCubit.dart';

class ToDO_Cubit extends Cubit<stateCubit> {
  ToDO_Cubit() : super(initial()); //why it gives me error
  // ToDO_Cubit() : super(initial()); // Corrected syntax

  List<Map> NewTasks = [];
  List<Map> DoneTasks = [];
  List<Map> ArcheiveTasks = [];

  late Database ToDo_db;

  int CurrentIndex = 0;
  bool shownBottomSheet = false;

  IconData floatIcon = Icons.edit;

  static ToDO_Cubit get(context) => BlocProvider.of(context);
  void Bottom_Navigation_Bar_index(int value) {
    CurrentIndex = value;

    emit(Bottom_Navigation_Bar());
  }

  void changeBottomSheet({required IconData icon, required bool isshown}) {
    shownBottomSheet = isshown;
    floatIcon = icon;

    emit(Bottom_Sheet());
  }

  createDatabase() {
    openDatabase(
      "mmm.db",
      version: 1,
      onCreate: (todoDb, version) {
        todoDb
            .execute(
          'CREATE TABLE todo(id INTEGER PRIMARY KEY, title TEXT, data TEXT,status TEXT,datetime TEXT)',
        )
            .then(
          (value) {
            print("Table created");
          },
        ).catchError((error) {
          print("$error: An error occurred");
        });
        print('Database Created');
      },
      onUpgrade: (todoDb, oldVersion, newVersion) {
        print('Database Upgraded');
      },
      onOpen: (todoDb) {
        getfromdatabase(todoDb);
        print('Database Opened');
      },
    ).then(
      (value) {
        ToDo_db = value;
        // print()
        emit(Create_Databse()); ////////////////////
      },
    );
  }

  insertDatabase(
      {required String title,
      required String dataform,
      String status = 'New'})
       async
        {
    DateFormat inputFormat = DateFormat('d-M-yyyy');
    DateTime dateTime = inputFormat.parse(dataform);
    DateFormat outputFormat = DateFormat('EEEE-M');
    String data = outputFormat.format(dateTime);

    // print(dataform);
    // print(dateTime);
    // print(outputFormat);
    // print(data);

    // String datetime = DateFormat('d-M-yyyy').format(Time!);

    await ToDo_db.transaction((txn) => txn
            .rawInsert(
          'INSERT INTO todo(title, data,status,datetime) VALUES("$title", "$data", "$status","$dataform")',
        )
            .then(
          (value) {
            print("$value Data inserted");
            emit(Insert_To_Databse());
            getfromdatabase(ToDo_db);

          },
        ).catchError((error) {
          print("$error: An error occurred");
        }));
  }

  void getfromdatabase(todoDb) async {
    emit(Befor_Get_From_Databse_Loading());
    NewTasks = [];
    DoneTasks = [];
    ArcheiveTasks = [];

    await todoDb!.rawQuery('SELECT * FROM todo').then(
      (value) {
        value.forEach((value) {
          /////////////
          if (value['status'] == 'New') {
            NewTasks.add(value);
          } else if (value['status'] == 'Done') {
            DoneTasks.add(value);
          }

          if (value['status'] == 'Archeived') {
            ArcheiveTasks.add(value);
          }
        });

        emit(Get_From_Databse());
      },
    );

    print("$NewTasks NewTasks ");
    print("$DoneTasks DoneTasks ");
    print("$ArcheiveTasks Archeive ");
  }

  update_databse({required String stat, required int id}) async {
    //
    await ToDo_db.rawUpdate(
        'UPDATE todo SET status = ? WHERE id = ?', [stat, '$id'] //
        ).then(
      (value) {
        emit(Update_Database());
      },
    );
    // getfromdatabase(ToDo_db);
    print("$NewTasks NewTasks ");
    print("$DoneTasks DoneTasks ");
    print("$ArcheiveTasks Archeive ");
  }

  void delete_database({required int id}) {
    ToDo_db.rawDelete('DELETE FROM todo WHERE id = ?', [id]).then(
      (value) {
        getfromdatabase(ToDo_db);
        emit(Delete_From_Datbase());
      },
    );
  }
}
