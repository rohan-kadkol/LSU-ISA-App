class Offer {
  String apartmentId;
  AvailabilityType availability;
  double deposit;
  String description;
  bool furnished;
  double numBeds;
  double numBaths;
  List<Option> options;
  bool petsAllowed;
  Sqft sqft;

  Offer({this.apartmentId, this.availability, this.deposit, this.description, this.furnished,
      this.numBeds, this.numBaths, this.options, this.petsAllowed, this.sqft});

  @override
  String toString() {
    // TODO: implement toString
    return apartmentId;
  }
}

class Option {
  String name;
  Cost cost;
  OptionType type;

  Option({this.name, this.cost, this.type});
}

class Cost {
  CostType type;
  double cost;
  double costMax;

  Cost({this.type, this.cost, this.costMax});
}

class Sqft {
  SqftType type;
  double sqft;
  double sqftMax;

  Sqft({this.type, this.sqft, this.sqftMax});
}

enum AvailabilityType {AVAILABLE_NOW, NOT_AVAILABLE, AVAILABLE_SOON}
enum CostType {EXACT, FROM, RANGE, PLEASE_CALL}
enum OptionType {BASE, ADDON}
enum SqftType {EXACT, RANGE}