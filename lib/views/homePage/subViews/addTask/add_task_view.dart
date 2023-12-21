// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:interviewtask/models/database.dart';
import 'package:interviewtask/models/task_model.dart';
import 'package:interviewtask/views/homePage/home_page_view.dart';
import 'package:interviewtask/views/homePage/subViews/addTask/widgets/input_field_title.dart';
import 'package:interviewtask/views/homePage/subViews/addTask/widgets/task_status.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';
import '../../../../controls/providers/home_page_provider.dart';
import '../../widgets/homepage_appbar.dart';
import '../../widgets/input_fields.dart';

class AddTaskView extends StatefulWidget {
  final DatabaseHandler databaseHandler;
  final Task? task;

  const AddTaskView({super.key, required this.databaseHandler, this.task});

  @override
  State<AddTaskView> createState() => _AddTaskViewState();
}

class _AddTaskViewState extends State<AddTaskView> {
  final TextEditingController id = TextEditingController();
  final TextEditingController title = TextEditingController();
  final TextEditingController description = TextEditingController();

  void setupController() {
    if (widget.task != null) {
      id.text = widget.task!.id.toString();
      title.text = widget.task!.title;
      description.text = widget.task!.description;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setupController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: homepageAppbar(
        title: 'Add Task',
        needActionButton: false,
      ),
      body: SingleChildScrollView(
        child: Consumer<HomePageProvider>(builder: (context, property, child) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              height: MediaQuery.of(context).size.height * .9,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: Color(0xFF4c4f4d),
                borderRadius: BorderRadius.all(Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    spreadRadius: 3,
                    blurRadius: 3,
                    offset: Offset(5, 5),
                  ),
                ],
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                margin: const EdgeInsets.symmetric(vertical: 10),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Column(
                  children: [
                    /*-------------------> Input Field Title <--------------------*/
                    inputFieldTitle(),
                    const SizedBox(height: 50),

                    /*-------------------> Input Field for ID Card <--------------------*/
                    inputField(title: 'ID:', hintText: '11223344', controller: id, maxLine: false, context: context),
                    const SizedBox(height: 20),

                    /*-------------------> Input Field for Title <--------------------*/
                    inputField(
                        title: 'Title:', hintText: 'Wake Up', controller: title, maxLine: false, context: context),
                    const SizedBox(height: 20),

                    /*-------------------> Input Field for Description <--------------------*/
                    inputField(
                        title: 'Description:',
                        hintText: 'Description.....',
                        controller: description,
                        maxLine: true,
                        context: context),
                    const SizedBox(height: 20),

                    /*-------------------> Input Field for Task Status <--------------------*/
                    taskStatus(property),
                    const SizedBox(height: 20),

                    /*-------------------> Submit Button <--------------------*/
                    submitButton(property, context),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  CupertinoButton submitButton(HomePageProvider property, BuildContext context) {
    return CupertinoButton(
      color: const Color(0xFF4c4f4d),
      onPressed: () async {
        Task task = Task(
          id: int.parse(id.text),
          title: title.text,
          description: description.text,
          status: (property.status) ? 1 : 0,
        );
        if (widget.task != null) {
          await widget.databaseHandler.updateTask(id: widget.task!.id, task: task);
        } else {
          await widget.databaseHandler.createTask(task: task);
        }
        QuickAlert.show(
          context: context,
          type: QuickAlertType.success,
          title: 'Task Submitted Successfully',
          onConfirmBtnTap: () {
            widget.databaseHandler.fetchTasks();
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => HomePageView(databaseHandler: widget.databaseHandler)));
          },
        );
      },
      child: const Text('Submit'),
    );
  }
}
