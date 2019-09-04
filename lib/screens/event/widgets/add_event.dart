import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:sbaclean/store/app_state.dart';
import 'package:sbaclean/models/user.dart';
import 'package:intl/intl.dart';
import '../../../actions/event_actions.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';


class AddEventForm extends StatefulWidget {
  @override
  _AddEventFormState createState() => new _AddEventFormState();
}

class _AddEventFormState extends State<AddEventForm> {
  final formKey = new GlobalKey<FormState>();

  String _title;
  String _description;
  String _max;
  String _starts_at;

  void _submit() {
    final form = formKey.currentState;

    if (form.validate()) {
      form.save();
    }
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState,User> (
    converter: (store) =>  store.state.auth.user,
    builder: (context,user) {
    return new Form(
      key: formKey,
      child: new Column(
        children: [
          new TextFormField(
            decoration: new InputDecoration(labelText: 'Title'),
            validator: (val) =>
            val.isEmpty ? 'Please enter the title' : null,
            onSaved: (val) => _title = val,
          ),
          new TextFormField(
            decoration: new InputDecoration(labelText: 'description'),
            validator: (val) =>
            val.isEmpty ? 'Please enter the description' : null,
            onSaved: (val) => _description = val,
          ),
          new TextFormField(
            decoration: new InputDecoration(labelText: 'Max Participants'),
            validator: (val) =>
            val.isEmpty ? 'Please enter the max of participants' : null,
            onSaved: (val) => _max = val,
          ),
          new DateTimePickerFormField(
            inputType: InputType.both,
            format: DateFormat("y-M-d H:m"),
            decoration: new InputDecoration(labelText: 'Starts at'),
            onSaved: (val) => _starts_at = val.toString(),

          ),
          new Padding(
            padding: new EdgeInsets.only(top: 20.0),
            child: new FlatButton(
              onPressed:() {
                _submit();
                postEvent(context,user.authToken,_title,_description,user.id,_max,_starts_at);
              },
              child: new Text('Submit'),
            ),
          ),
        ],
      ),
    );
    });
  }

}