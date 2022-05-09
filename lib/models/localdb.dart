import 'package:bloc_demo/models/person.dart';

class LocalDb {
  /// simulate a db
  static Future<List<Person>> getPersons() async {
    //simulate waiting time...
    await Future.delayed(const Duration(milliseconds: 700));
    return _persons;
  }

  static void addPerson(Person p) => _persons.add(p);

  static void removePerson(Person p) => _persons.remove(p);

  static final List<Person> _persons = [Person('Random Person')];
}
