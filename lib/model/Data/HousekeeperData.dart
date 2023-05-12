class Housekeeper {
  String HousekeeperID;
  String FirstName;
  String LastName;
  String ProfileImage;
  int HearRanking;
  int Vaccinated;
  int Distance;
  String CommunicationSkill;
  String PhoneNumber;

  Housekeeper(
      this.HousekeeperID,
      this.FirstName,
      this.LastName,
      this.ProfileImage,
      this.HearRanking,
      this.Vaccinated,
      this.Distance,
      this.CommunicationSkill,
      this.PhoneNumber);

  Map<String, dynamic> CreateHousekeepertoJson() => {
        'HousekeeperID': HousekeeperID,
        'FirstName': FirstName,
        'LastName': LastName,
        'ProfileImage': ProfileImage,
        'HearRanking': HearRanking,
        'Vaccinated': Vaccinated,
        'MaxDistance': Distance,
        'CommunicationSkill': CommunicationSkill,
      };
}
