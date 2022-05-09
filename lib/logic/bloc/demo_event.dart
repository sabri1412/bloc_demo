part of 'demo_bloc.dart';

abstract class DemoEvent extends Equatable {
  const DemoEvent();

  @override
  List<Object> get props => [];
}

class AddPerson extends DemoEvent {}

class UpdateUI extends DemoEvent {}

class UpdateList extends DemoEvent {}

class DeleteItem extends DemoEvent {
  final Person deleteP;
  const DeleteItem(this.deleteP);
}
