class FavHousekeeper {
  String HousekeeperID;
  String FirstName;
  String LastName;
  String ProfileImage;
  int HearRanking;
  int Vaccinated;
  int Distance;
  String CommunicationSkill;
  bool fav;
  bool booked;
  String PhoneNumber;

  FavHousekeeper(
    this.HousekeeperID,
    this.FirstName,
    this.LastName,
    this.ProfileImage,
    this.HearRanking,
    this.Vaccinated,
    this.Distance,
    this.CommunicationSkill,
    this.fav,
    this.booked,
    this.PhoneNumber,
  );

  Map<String, dynamic> CreateFavHousekeepertoJson() => {
        'HousekeeperID': HousekeeperID,
        /* 'FirstName': FirstName,
        'LastName': LastName,
        'ProfileImage': ProfileImage,
        'HearRanking': HearRanking,
        'HearRanking': HearRanking,
        'Vaccinated': Vaccinated,
        'MaxDistance': Distance,
        'CommunicationSkill': CommunicationSkill,
        'PhoneNumber': PhoneNumber*/
      };
}
