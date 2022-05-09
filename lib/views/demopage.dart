import 'package:bloc_demo/models/constants.dart';
import 'package:bloc_demo/views/alerdialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../logic/bloc/demo_bloc.dart';
import '../models/person.dart';

class DemoPage extends StatelessWidget {
  const DemoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('BlocDemo')),
      body: Column(
        children: const [
          Expanded(child: InputForm()),
          Divider(
            color: Colors.black,
          ),
          Text('Persons', style: titleText),
          Expanded(flex: 2, child: ContentList()),
        ],
      ),
    );
  }
}

class InputForm extends StatelessWidget {
  const InputForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _bloc = context.read<DemoBloc>();
    return BlocBuilder<DemoBloc, DemoState>(
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: SizedBox(
                  width: 250,
                  child: TextField(
                    textAlign: TextAlign.center,
                    onChanged: (_) => _bloc.add(UpdateUI()),
                    controller: _bloc.username,
                    decoration: InputDecoration(
                        label: const Text('Name'),
                        errorText: state.validInput ? null : 'invalid input'),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 250,
                child: ElevatedButton(
                    onPressed: () => _bloc.add(AddPerson()),
                    child: const Text('Add Person')),
              ),
            )
          ],
        );
      },
    );
  }
}

class ContentList extends StatelessWidget {
  const ContentList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DemoBloc, DemoState>(
      builder: (context, state) {
        final _bloc = context.read<DemoBloc>();
        if (state is DemoInit) {
          _bloc.add(UpdateList());
        } else if (state is LoadState) {
          return const Center(child: CircularProgressIndicator());
        }
        return Center(
          child: SizedBox(
            width: 250,
            child: ListView.builder(
              itemCount: state.persons.length,
              itemBuilder: (context, index) {
                return ContentTile(person: state.persons[index]);
              },
            ),
          ),
        );
      },
    );
  }
}

class ContentTile extends StatelessWidget {
  final Person person;
  const ContentTile({Key? key, required this.person}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _bloc = context.read<DemoBloc>();
    return GestureDetector(
      onTap: () async {
        String deleteMsg = 'Do you really want to delete ${person.name}?';
        var response = await yesNoDialog(context, deleteMsg);
        if (response == true) {
          _bloc.add(DeleteItem(person));
        }
      },
      child: Container(
          width: 250,
          margin: const EdgeInsets.all(4),
          height: 50,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: Center(child: Text(person.name))),
    );
  }
}
