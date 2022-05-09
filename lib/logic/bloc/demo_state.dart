part of 'demo_bloc.dart';

abstract class DemoState extends Equatable {
  const DemoState({required this.validInput, required this.persons});
  final bool validInput;
  final List<Person> persons;

  @override
  List<Object> get props => [validInput];
}

class DemoInit extends DemoState {
  DemoInit() : super(validInput: true, persons: []);
}

class NormalState extends DemoState {
  const NormalState({required bool validInput, required List<Person> persons})
      : super(validInput: validInput, persons: persons);
}

class LoadState extends DemoState {
  const LoadState({required bool validInput, required List<Person> persons})
      : super(validInput: validInput, persons: persons);
}

class ErrorState extends DemoState {
  ErrorState({required bool validInput})
      : super(validInput: validInput, persons: []);
}
