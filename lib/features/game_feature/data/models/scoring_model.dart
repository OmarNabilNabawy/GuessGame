// ignore_for_file: public_member_api_docs, sort_constructors_first
class ScoringModel {
  int myScore;
  int myFriendScore;
  String roomName;
  ScoringModel(
    this.roomName, {
    this.myScore = 0,
    this.myFriendScore = 0,
  });
}
