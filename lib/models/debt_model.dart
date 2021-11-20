class DebtModel {
  //0 la da thanh toan, 1 is cho no, 2 la no
  final int stateDebt;
  final String personName;
  final int cost;
  final DateTime timeUpdated;
  final String description;

  const DebtModel(
      {required this.stateDebt,
      required this.personName,
      required this.cost,
      required this.timeUpdated,
      required this.description});
}
