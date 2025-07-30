// class Nilai {
//   int id; // Added id property
//   String NISN;
//   int BIndo;
//   int MTK;
//   int IPA;
//   int BInggris;
//   int PKN;
//   int SB;
//   int Rerata;
//
//   Nilai({
//     required this.id, // Added id parameter to the constructor
//     required this.NISN,
//     required this.BIndo,
//     required this.MTK,
//     required this.IPA,
//     required this.BInggris,
//     required this.PKN,
//     required this.SB,
//     required this.Rerata,
//   });
//
//   // Create a Nilai object from a JSON representation
//   factory Nilai.fromJson(Map<String, dynamic> json) {
//     return Nilai(
//       id: json['id'] as int,
//       NISN: json['NISN'] as String,
//       BIndo: json['BIndo'] as int,
//       MTK: json['MTK'] as int,
//       IPA: json['IPA'] as int,
//       BInggris: json['BInggris'] as int,
//       PKN: json['PKN'] as int,
//       SB: json['SB'] as int,
//       Rerata: json['Rerata'] as int,
//     );
//   }
//
//   // Convert the Nilai object to a JSON representation
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'NISN': NISN,
//       'BIndo': BIndo,
//       'MTK': MTK,
//       'IPA': IPA,
//       'BInggris': BInggris,
//       'PKN': PKN,
//       'SB': SB,
//       'Rerata': Rerata,
//     };
//   }
// }
class Nilai {
  int id;
  String NISN;
  int BIndo;
  int MTK;
  int IPA;
  int BInggris;
  int PKN;
  int SB;
  int Rerata;

  Nilai({
    required this.id,
    required this.NISN,
    required this.BIndo,
    required this.MTK,
    required this.IPA,
    required this.BInggris,
    required this.PKN,
    required this.SB,
    required this.Rerata,
  });

  int get rerata => Rerata;

  factory Nilai.fromJson(Map<String, dynamic> json) {
    return Nilai(
      id: json['id'] as int,
      NISN: json['NISN'] as String,
      BIndo: json['BIndo'] as int,
      MTK: json['MTK'] as int,
      IPA: json['IPA'] as int,
      BInggris: json['BInggris'] as int,
      PKN: json['PKN'] as int,
      SB: json['SB'] as int,
      Rerata: json['Rerata'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'NISN': NISN,
      'BIndo': BIndo,
      'MTK': MTK,
      'IPA': IPA,
      'BInggris': BInggris,
      'PKN': PKN,
      'SB': SB,
      'Rerata': Rerata,
    };
  }
}


