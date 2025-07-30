class Siswa {
  String NISN;
  String nama;
  String jenkel;
  String KK;
  String tgl_lahir;
  String alamat;
  String agama;
  String seleksi;

  Siswa({required this.NISN,required  this.nama,required  this.jenkel,required  this.KK,required  this.tgl_lahir,required  this.alamat,required  this.agama,required   this.seleksi});

  factory Siswa.fromJson(Map<String, dynamic> json) {
    return Siswa(
      NISN: json['NISN'] as String,
      nama: json['nama'] as String,
      jenkel: json['jenkel'] as String,
      KK: json['KK'] as String,
      tgl_lahir: json['tgl_lahir'] as String,
      alamat: json['alamat'] as String,
      agama: json['agama'] as String,
      seleksi: json['seleksi'] as String,
    );
  }
}

