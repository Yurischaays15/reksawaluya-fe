class PasienModel {
  PasienModel({
      int? id, 
      String? name, 
      String? date, 
      String? gender, 
      String? nik, 
      String? address, 
      String? telp, 
      String? bpjs, 
      String? medicalRecord,}){
    _id = id;
    _name = name;
    _date = date;
    _gender = gender;
    _nik = nik;
    _address = address;
    _telp = telp;
    _bpjs = bpjs;
    _medicalRecord = medicalRecord;
}

  PasienModel.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _date = json['date'];
    _gender = json['gender'];
    _nik = json['nik'];
    _address = json['address'];
    _telp = json['telp'];
    _bpjs = json['bpjs'];
    _medicalRecord = json['medical_record'];
  }
  int? _id;
  String? _name;
  String? _date;
  String? _gender;
  String? _nik;
  String? _address;
  String? _telp;
  String? _bpjs;
  String? _medicalRecord;

  int? get id => _id;
  String? get name => _name;
  String? get date => _date;
  String? get gender => _gender;
  String? get nik => _nik;
  String? get address => _address;
  String? get telp => _telp;
  String? get bpjs => _bpjs;
  String? get medicalRecord => _medicalRecord;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['date'] = _date;
    map['gender'] = _gender;
    map['nik'] = _nik;
    map['address'] = _address;
    map['telp'] = _telp;
    map['bpjs'] = _bpjs;
    map['medical_record'] = _medicalRecord;
    return map;
  }

}