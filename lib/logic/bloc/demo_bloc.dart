import 'package:bloc/bloc.dart';
import 'package:bloc_demo/models/localdb.dart';
import 'package:bloc_demo/models/person.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'demo_event.dart';
part 'demo_state.dart';

class DemoBloc extends Bloc<DemoEvent, DemoState> {
  DemoBloc() : super(DemoInit()) {
    on<UpdateList>(_updateList);
    on<UpdateUI>(_updateUI);
    on<AddPerson>(_addPerson);
    on<DeleteItem>(_deleteItem);
  }

  final TextEditingController username = TextEditingController();

  void _updateList(UpdateList event, Emitter<DemoState> emit) async {
    //load items
    emit(LoadState(validInput: state.validInput, persons: state.persons));
    var persons = await LocalDb.getPersons();
    emit(NormalState(validInput: state.validInput, persons: persons));
  }

  void _updateUI(UpdateUI event, Emitter<DemoState> emit) {
    //load items
    if (!state.validInput) {
      emit(NormalState(validInput: true, persons: state.persons));
    }
  }

  void _addPerson(AddPerson event, Emitter<DemoState> emit) {
    //show error
    if (username.text.length < 3) {
      emit(NormalState(validInput: false, persons: state.persons));
    } else {
      //add
      LocalDb.addPerson(Person(username.text));
      add(UpdateList());
    }
  }

  void _deleteItem(DeleteItem event, Emitter<DemoState> emit) {
    LocalDb.removePerson(event.deleteP);
    add(UpdateList());
  }
}
