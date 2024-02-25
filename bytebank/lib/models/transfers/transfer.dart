class TransferModel {
  final String value;
  final String accountNumber;

  TransferModel(this.value, this.accountNumber);

  @override
  toString() {
    return 'TransferModel{value: $value, accountNumber: $accountNumber}';
  }
}
