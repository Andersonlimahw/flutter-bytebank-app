import 'package:flutter/material.dart';

void main() {
  runApp(const BybankApp());
}

class BybankApp extends StatelessWidget {
  const BybankApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bytebank',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent),
        useMaterial3: true,
      ),
      home: TransferList(),
    );
  }
}

class TransferList extends StatefulWidget {
  TransferList({super.key});

  final List<TransferModel> transfers = [];

  @override
  State<StatefulWidget> createState() => _TransferListState();
}

class _TransferListState extends State<TransferList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transfers List'),
      ),
      body: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: widget.transfers.length,
          itemBuilder: (BuildContext context, int index) {
            return TransferItem(transferModel: widget.transfers[index]);
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final Future routeFuture = Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return TransferForm();
            }),
          );
          routeFuture.then((value) => {
                debugPrint('value: $value'),
                if (value != null)
                  {
                    setState(() {
                      widget.transfers.add(value);
                    })
                  }
              });
        },
        tooltip: 'New transfer',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class TransferForm extends StatefulWidget {
  const TransferForm({super.key});
  @override
  State<StatefulWidget> createState() => _TransferFormState();
}

class _TransferFormState extends State<StatefulWidget> {
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
      body: SingleChildScrollView(
        child: Column(
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
      ),
    );
  }

  void _createTransfer(BuildContext context) {
    final int? accountNumber = int.tryParse(_accountNumberController.text);
    final double? value = double.tryParse(_valueController.text);
    if (accountNumber == null || value == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid values'),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }
    final transfer = TransferModel(accountNumber.toString(), value.toString());
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(transfer.toString()),
        backgroundColor: Colors.greenAccent,
      ),
    );
    Navigator.pop(context, transfer);
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
        title: Text(transferModel.accountNumber.toString()),
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
