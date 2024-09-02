class AddRoundNumberModel {
  final String id;
  final String value;

  AddRoundNumberModel( this.id,this.value);

  factory AddRoundNumberModel.fromJson(jsonData) {
    return AddRoundNumberModel(jsonData['id'], jsonData['roundNumbers']);
  }
}
