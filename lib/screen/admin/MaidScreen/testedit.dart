import 'package:flutter/material.dart';
import 'package:mutemaidservice/component/InfoJobAtom.dart';

class EditNameForm extends StatefulWidget {
  String firstName;
  String lastName;

  EditNameForm(this.firstName, this.lastName);

  @override
  _EditNameFormState createState() => _EditNameFormState();
}

class _EditNameFormState extends State<EditNameForm> {
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;

  @override
  void initState() {
    super.initState();

    // Initialize the text controllers with the current first and last names
    _firstNameController = TextEditingController(text: widget.firstName);
    _lastNameController = TextEditingController(text: widget.lastName);
  }

  @override
  void dispose() {
    // Dispose the text controllers when the form is disposed
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Edit Name'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: _firstNameController,
            decoration: InputDecoration(labelText: 'First Name'),
          ),
          TextFormField(
            controller: _lastNameController,
            decoration: InputDecoration(labelText: 'Last Name'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            // Save the new names and close the form
            Navigator.pop(
              context,
              {
                'firstName': _firstNameController.text,
                'lastName': _lastNameController.text,
              },
            );
          },
          child: Text('Save'),
        ),
        TextButton(
          onPressed: () {
            // Close the form without saving any changes
            Navigator.pop(context);
          },
          child: Text('Cancel'),
        ),
      ],
    );
  }
}

class MyWidget extends StatelessWidget {
  final String imageAssetPath;
  final String name;
  final String lastName;

  const MyWidget({
    required this.imageAssetPath,
    required this.name,
    required this.lastName,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        // Show the edit name form and wait for the result
        final result = await showDialog(
          context: context,
          builder: (_) => EditNameForm(
            name,
            lastName,
          ),
        );

        if (result != null) {
          // Update the name and last name with the new values
          final firstName = result['firstName'];
          final lastName = result['lastName'];

          // Perform any necessary updates with the new name and last name
          // ...

          // Show a success message to the user
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Name updated successfully')),
          );
        }
      },
      child: InfoJobAtom(
        imageAssetPath,
        '$name $lastName',
      ),
    );
  }
}
