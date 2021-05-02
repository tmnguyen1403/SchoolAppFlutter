class Finance {
  final int id;
  final String eligibility;
  final double balance;

  Finance({ 
    required this.id,
    required this.eligibility,
    required this.balance,
  });

  factory Finance.fromJson(Map<String, dynamic> data) {
    return Finance(
      id: data['id'], 
      eligibility: data['eligibility'],
      balance: data['balance'],
    );
  }
}