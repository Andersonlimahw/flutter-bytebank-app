import 'package:bytebank/models/transfers/transfer.dart';
import 'package:bytebank/screens/transfers/form.dart';
import 'package:bytebank/screens/transfers/strings.dart';
import 'package:flutter/material.dart';

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
        title: const Text(TransferStrings.transfersList),
        backgroundColor: Colors.black,
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
              return const TransferForm();
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
        tooltip: TransferStrings.newTransfer,
        child: const Icon(Icons.add),
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
