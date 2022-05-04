class BudgetEntry {
  late final int? id;
  late final String userName;
  late final double cost;
  late final String transactionType;
  late final String transactionCategory;

  BudgetEntry({ this.id, required this.userName, required this.cost, required this.transactionType, required this.transactionCategory});

 factory BudgetEntry.fromMap(Map<String, dynamic> json) => BudgetEntry(
   id: json['id'],
   userName: json['userName'],
   cost: json['cost'],
   transactionType: json['transactionType'],
   transactionCategory: json['transactionCategory']
 );

 Map<String, dynamic> toMap() {
   return {
     'id': id,
     'cost': cost,
     'userName': userName,
     'transactionType': transactionType,
     'transactionCategory': transactionCategory
   };
   }
 }


