class Person {
  final String name;
  final String email;
  final num id;

  Person({required this.name, required this.email, required this.id});

  Person.fromMap(Map<String, dynamic> json)
      : this(name: json['name'], email: json['email'], id: json['id']);
}

List<Person> personList = <Person>[];
