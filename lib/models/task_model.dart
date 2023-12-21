import 'dart:convert';

Task taskModelFromJson(String string) => Task.fromJson(json.decode(string));

String taskModelToJson(Task task) => json.encode(task.toJson());

class Task {
  /*-------------------> Declaring Variables <--------------------*/
  int id;
  String title;
  String description;
  int status;

  /*-------------------> Declaring Constructor <--------------------*/
  Task({required this.id, required this.title, required this.description, required this.status});

  Task copyWith({
    required int id,
    required String title,
    required String description,
    required int status,
  }) =>
      Task(id: id, title: title, description: description, status: status);

  factory Task.fromJson(Map<String, dynamic> json) =>
      Task(id: json['id'], title: json['title'], description: json['description'], status: json['status']);

  Map<String, dynamic> toJson() => {'id': id, 'title': title, 'description': description, 'status': status};
}
