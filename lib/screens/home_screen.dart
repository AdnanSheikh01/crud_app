import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _CrudOperationsPageState();
}

class _CrudOperationsPageState extends State<HomeScreen> {
  final TextEditingController _nameController = TextEditingController();

  final CollectionReference _users =
      FirebaseFirestore.instance.collection('users');

  final _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * .1),
              const Text(
                'Add User Details',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * .1),
              Form(
                key: _key,
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please add Something';
                    } else if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
                      return 'Name should contains alphabets';
                    }
                    return null;
                  },
                  controller: _nameController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Name'),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * .1),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.deepPurple),
                  onPressed: () {
                    _addUser();
                    Future.delayed(const Duration(milliseconds: 200), () {
                      _nameController.clear();
                    });
                  },
                  child: const Text('Add User'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _addUser() async {
    if (_key.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.green.shade700,
          content: const Text('User Added Successfully'),
        ),
      );

      await _users.add({'name': _nameController.text});
    }
  }
}
