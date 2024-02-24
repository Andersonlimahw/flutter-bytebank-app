import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bytebank',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Bytebank'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TransferForm(),
    );
  }
}

class TransferList extends StatelessWidget {
  const TransferList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TransferItem(transferModel: TransferModel('100.0', '1000')),
        TransferItem(transferModel: TransferModel('100.0', '1000')),
      ],
    );
  }
}

class TransferForm extends StatelessWidget {
  TransferForm({super.key});

  final TextEditingController _accountNumberController =
      TextEditingController();
  final TextEditingController _valueController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.colorScheme.primary,
        title: const Text('Transfers'),
      ),
      body: Column(
        children: [
          Editor(
            controller: _accountNumberController,
            label: 'Account Number',
            hint: '0000',
            icon: Icons.account_balance,
          ),
          Editor(
            controller: _valueController,
            label: 'Value',
            hint: '0,00',
            icon: Icons.monetization_on,
          ),
          ElevatedButton(
            onPressed: () {
              _createTransfer(context);
            },
            child: const Text(
              'Confirm',
              textDirection: TextDirection.ltr,
            ),
          ),
        ],
      ),
    );
  }

  void _createTransfer(BuildContext context) {
    final int? accountNumber = int.tryParse(_accountNumberController.text);
    final double? value = double.tryParse(_valueController.text);
    final transfer = TransferModel(accountNumber.toString(), value.toString());
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(transfer.toString()),
      ),
    );
  }
}

class Editor extends StatelessWidget {
  const Editor({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
    this.icon,
  });

  final TextEditingController controller;
  final String label;
  final String hint;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: controller,
        style: const TextStyle(fontSize: 24.0),
        decoration: InputDecoration(
          icon: icon != null ? Icon(icon) : null,
          labelText: label,
          hintText: hint,
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }
}

class TransferItem extends StatelessWidget {
  const TransferItem({
    super.key,
    required this.transferModel,
  });

  final TransferModel transferModel;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.monetization_on),
        title: Text(transferModel.value.toString()),
        subtitle: Text(transferModel.value.toString()),
      ),
    );
  }
}

class TransferModel {
  final String value;
  final String accountNumber;

  TransferModel(this.value, this.accountNumber);

  @override
  toString() {
    return 'TransferModel{value: $value, accountNumber: $accountNumber}';
  }
}
