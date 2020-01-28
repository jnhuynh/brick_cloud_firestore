import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unanchored/blocs/room/room_bloc.dart';
import 'package:unanchored/utils/debouncer.dart';

class CreateRoomForm extends StatefulWidget {
  @override
  _CreateRoomFormState createState() {
    return _CreateRoomFormState();
  }
}

class _CreateRoomFormState extends State<CreateRoomForm> {
  final _debouncer = Debouncer(milliseconds: 300);
  // Uniquely identifies a form for validation.
  final _formKey = GlobalKey<FormState>();
  String _value;

  @override
  Widget build(BuildContext context) {
    // Add a header and more styling.
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter a name for the room';
                }

                return null;
              },
              onChanged: (value) {
                _debouncer.run(() {
                  setState(() {
                    _value = value;
                  });
                });
              },
            ),
            RaisedButton(
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  BlocProvider.of<RoomBloc>(context).add(
                    CreateRoom(name: _value),
                  );
                }
              },
              child: const Text('Create'),
            ),
          ],
        ),
      ),
    );
  }
}
