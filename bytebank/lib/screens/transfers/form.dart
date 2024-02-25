import 'package:bytebank/models/transfers/transfer.dart';
import 'package:bytebank/screens/transfers/strings.dart';
import 'package:bytebank/widgets/editor.dart';
import 'package:flutter/material.dart';

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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: const Text(TransferStrings.appBar),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Editor(
              controller: _accountNumberController,
              label: TransferStrings.accountNumber,
              hint: '0000',
              icon: Icons.account_balance,
            ),
            Editor(
              controller: _valueController,
              label: TransferStrings.value,
              hint: '0,00',
              icon: Icons.monetization_on,
            ),
            ElevatedButton(
              onPressed: () {
                _createTransfer(context);
              },
              child: const Text(
                TransferStrings.confirmButton,
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
          content: Text(TransferStrings.snackBarInValid),
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
