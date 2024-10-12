import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/cubit.dart';
import 'package:to_do/main.dart';
import 'package:to_do/stateCubit.dart';
class Archeive extends StatefulWidget {//////////////////
   Archeive({super.key});

  @override
  State<Archeive> createState() => _ArcheiveState();
}


class _ArcheiveState extends State<Archeive> {
  @override
  Widget build(BuildContext context) {
  return BlocConsumer<ToDO_Cubit,stateCubit>(
      builder: (context, state) {
        var cubit = ToDO_Cubit.get(context);
        return 
        state is Befor_Get_From_Databse_Loading? Center(child: CircularProgressIndicator()): 
        buildPage(cubit.ArcheiveTasks);
      },
      listener: (context, state) {},
    );  }
}