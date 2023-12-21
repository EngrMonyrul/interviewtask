// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:interviewtask/models/database.dart';
import 'package:interviewtask/models/task_model.dart';
import 'package:interviewtask/views/homePage/home_page_view.dart';
import 'package:interviewtask/views/homePage/subViews/addTask/add_task_view.dart';
import 'package:interviewtask/views/homePage/widgets/homepage_appbar.dart';
import 'package:quickalert/quickalert.dart';

class TaskViewPage extends StatefulWidget {
  final DatabaseHandler databaseHandler;
  final Task task;

  const TaskViewPage({super.key, required this.task, required this.databaseHandler});

  @override
  State<TaskViewPage> createState() => _TaskViewPageState();
}

class _TaskViewPageState extends State<TaskViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: homepageAppbar(needActionButton: false, title: 'Task View'),
      body: Padding(
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
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                titleShow(),
                const SizedBox(height: 20),
                statusArea(),
                titleArea(),
                descriptionArea(),
                const Spacer(),
                Buttons(context)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row Buttons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        actionButton(
          title: 'Edit',
          iconData: CupertinoIcons.pen,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddTaskView(
                  databaseHandler: widget.databaseHandler,
                  task: widget.task,
                ),
              ),
            );
          },
        ),
        actionButton(
          title: 'Delete',
          iconData: CupertinoIcons.delete,
          onPressed: () async {
            await widget.databaseHandler.deleteTask(id: widget.task.id);
            QuickAlert.show(
              context: context,
              type: QuickAlertType.success,
              title: 'Delete File Successfully',
              onConfirmBtnTap: () {
                widget.databaseHandler.fetchTasks();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomePageView(databaseHandler: widget.databaseHandler)));
              },
            );
          },
        ),
      ],
    );
  }

  Text descriptionArea() {
    return Text.rich(
      TextSpan(
        style: const TextStyle(
          fontSize: 20,
        ),
        children: [
          const TextSpan(
            text: 'Description: ',
            style: TextStyle(
              color: Colors.deepOrange,
            ),
          ),
          TextSpan(
            text: widget.task.description,
          )
        ],
      ),
    );
  }

  Text titleArea() {
    return Text.rich(
      TextSpan(
        style: const TextStyle(
          fontSize: 20,
        ),
        children: [
          const TextSpan(
            text: 'Title: ',
            style: TextStyle(
              color: Colors.deepOrange,
            ),
          ),
          TextSpan(
            text: widget.task.title,
          )
        ],
      ),
    );
  }

  Text statusArea() {
    return Text.rich(
      TextSpan(
        style: const TextStyle(
          fontSize: 20,
        ),
        children: [
          const TextSpan(
            text: 'Status: ',
            style: TextStyle(
              color: Colors.deepOrange,
            ),
          ),
          TextSpan(
            text: (widget.task.status == 0) ? 'Completed' : 'Backlog',
          )
        ],
      ),
    );
  }

  Center titleShow() {
    return Center(
      child: Text(
        '${widget.task.id}',
        style: const TextStyle(fontSize: 40),
      ),
    );
  }

  IconButton actionButton({required String title, required IconData iconData, required Function() onPressed}) {
    return IconButton(
      onPressed: onPressed,
      icon: Column(
        children: [
          CircleAvatar(
            child: Icon(iconData),
          ),
          Text(
            title,
            style: const TextStyle(fontSize: 10),
          ),
        ],
      ),
    );
  }
}
