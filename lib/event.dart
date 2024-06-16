//Defines the Event class with a title and date
//Defining event model
class Event {
  final int id;
  final String title;
  final String description;
  final DateTime date;
  final String createdBy;

  Event({
    required this.id, 
    required this.title, 
    required this.description, 
    required this.date, 
    required this.createdBy
    });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      date: DateTime.parse(json['date']),
      createdBy: json['created_by'],
    );
  }
   Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': date.toIso8601String(),
      'created_by': createdBy,
    };
  }
}