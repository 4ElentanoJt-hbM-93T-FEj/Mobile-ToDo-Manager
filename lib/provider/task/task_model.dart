class Task {
  final String title;
  final String? description;
  // final DateTime dateTime;

  Task({required this.title, this.description});

  Map<String, dynamic> toMap() {
    return {'title': title, 'description': description};
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(title: map['title'], description: map['description']);
  }
}
