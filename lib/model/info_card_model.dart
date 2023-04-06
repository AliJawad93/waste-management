class InfoCardModel {
  String numberCard;
  int expireMonth;
  int expireYear;
  String name;
  InfoCardModel({
    required this.numberCard,
    required this.expireMonth,
    required this.expireYear,
    required this.name,
  });

  factory InfoCardModel.fromMap(Map<String, dynamic> map) {
    return InfoCardModel(
        numberCard: map["number_card"],
        expireMonth: map["expire_month"],
        expireYear: map["expire_year"],
        name: map["name"]);
  }

  Map<String, dynamic> toMap() {
    return {
      "number_card": numberCard,
      "expire_month": expireMonth,
      "expire_year": expireYear,
      "name": name,
    };
  }
}
