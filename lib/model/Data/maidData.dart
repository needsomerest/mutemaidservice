class Maid {
  String HousekeeperID;
  String FirstName;
  String LastName;
  String ProfileImage;

  Maid(
    this.HousekeeperID,
    this.FirstName,
    this.LastName,
    this.ProfileImage,
  );

  // Map<String, dynamic> CreateHousekeepertoJson() => {
  //       'HousekeeperID': HousekeeperID,
  //       'FirstName': FirstName,
  //       'LastName': LastName,
  //       'ProfileImage': ProfileImage,
  //       'HearRanking': HearRanking,
  //       'Vaccinated': Vaccinated,
  //       'MaxDistance': Distance,
  //       'CommunicationSkill': CommunicationSkill,
  //     };
}
