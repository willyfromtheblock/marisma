class UtxoSpentBeforeWrite {
  final String utxoId;
  final int spentOnBlock;

  UtxoSpentBeforeWrite({
    required this.utxoId,
    required this.spentOnBlock,
  });

  Map toJson() {
    return {
      "utxoId": 'utxo:$utxoId',
      "spent_on_block": 'block:$spentOnBlock',
    };
  }
}
