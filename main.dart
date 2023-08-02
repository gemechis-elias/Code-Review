import 'dart:io';

class Task {
  String title;
  String description;
  DateTime dueDate;
  bool completed;

  Task({
    required this.title,
    required this.description,
    required this.dueDate,
    this.completed = false,
  });

  @override
  String toString() {
    String status = completed ? 'Completed' : 'Pending';
    return 'Title: $title\nDescription: $description\nDue Date: ${dueDate.toLocal()}\nStatus: $status\n';
  }
}

class TaskManager {
  List<Task> _tasks = [];

  void addTask(Task task) {
    _tasks.add(task);
  }

  List<Task> get allTasks {
    return _tasks;
  }

  List<Task> get completedTasks {
    return _tasks.where((task) => task.completed).toList();
  }

  List<Task> get pendingTasks {
    return _tasks.where((task) => !task.completed).toList();
  }

  void editTask(
    Task task,
    String newTitle,
    String newDescription,
    DateTime newDueDate,
    bool newStatus,
  ) {
    task.title = newTitle;
    task.description = newDescription;
    task.dueDate = newDueDate;
    task.completed = newStatus;
  }

  void deleteTask(Task task) {
    _tasks.remove(task);
  }
}

void main() {
  TaskManager taskManager = TaskManager();
  var input;

  while (true) {
    print("Choose an action: ");
    print("1. Add task");
    print("2. View all tasks");
    print("3. View completed tasks");
    print("4. View pending tasks");
    print("5. Edit task");
    print("6. Delete task");
    print("0. Exit");

    input = stdin.readLineSync();

    if (input == '1') {
      print("Enter task details:");
      print("Title: ");
      var title = stdin.readLineSync()!;
      print("Description: ");
      var description = stdin.readLineSync()!;
      print("Due Date (YYYY-MM-DD): ");
      var dueDateStr = stdin.readLineSync()!;
      var dueDate = DateTime.parse(dueDateStr);
      taskManager.addTask(Task(
        title: title,
        description: description,
        dueDate: dueDate,
      ));
      print("Task added successfully!\n");
    } else if (input == '2') {
      print("All tasks:");
      print(taskManager.allTasks);
    } else if (input == '3') {
      print("Completed tasks:");
      print(taskManager.completedTasks);
    } else if (input == '4') {
      print("Pending tasks:");
      print(taskManager.pendingTasks);
    } else if (input == '5') {
      print("Enter the title of the task you want to edit:");
      var titleToEdit = stdin.readLineSync()!;
      var taskToEdit = taskManager.allTasks.firstWhere(
        (task) => task.title == titleToEdit,
        orElse: () => Task(
          title: '', // An empty task with default values
          description: '',
          dueDate: DateTime.now(),
          completed: false,
        ),
      );
      if (taskToEdit.title.isEmpty) {
        print("Task not found!");
      } else {
        print("Enter updated task details:");
        print("New Title: ");
        var newTitle = stdin.readLineSync()!;
        print("New Description: ");
        var newDescription = stdin.readLineSync()!;
        print("New Due Date (YYYY-MM-DD): ");
        var newDueDateStr = stdin.readLineSync()!;
        var newDueDate = DateTime.parse(newDueDateStr);
        print("Is it completed? (true or false): ");
        var newStatusStr = stdin.readLineSync()!;
        var newStatus = newStatusStr.toLowerCase() == 'true';
        taskManager.editTask(
          taskToEdit,
          newTitle,
          newDescription,
          newDueDate,
          newStatus,
        );
        print("Task updated successfully!\n");
      }
    } else if (input == '6') {
      print("Enter the title of the task you want to delete:");
      var titleToDelete = stdin.readLineSync()!;
      var taskToDelete = taskManager.allTasks.firstWhere(
        (task) => task.title == titleToDelete,
        orElse: () => Task(
          title: '', // An empty task with default values
          description: '',
          dueDate: DateTime.now(),
          completed: false,
        ),
      );
      if (taskToDelete.title.isEmpty) {
        print("Task not found!");
      } else {
        taskManager.deleteTask(taskToDelete);
        print("Task deleted successfully!\n");
      }
    } else if (input == '0') {
      print("Exiting Task Manager...");
      break;
    } else {
      print("Invalid input. Please try again.\n");
    }
  }
}
