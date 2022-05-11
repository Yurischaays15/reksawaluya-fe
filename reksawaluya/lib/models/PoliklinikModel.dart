class PoliklinikModel {
  int? poliklinikId;
  String? poliklinikName;
  String? poliklinikKode;
  String? poliklinikIcon;
  List<Doctors>? doctors;

  PoliklinikModel(
      {this.poliklinikId,
        this.poliklinikName,
        this.poliklinikKode,
        this.poliklinikIcon,
        this.doctors});

  PoliklinikModel.fromJson(Map<String, dynamic> json) {
    poliklinikId = json['poliklinik_id'];
    poliklinikName = json['poliklinik_name'];
    poliklinikKode = json['poliklinik_kode'];
    poliklinikIcon = json['poliklinik_icon'];
    if (json['doctors'] != null) {
      doctors = <Doctors>[];
      json['doctors'].forEach((v) {
        doctors!.add(Doctors.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['poliklinik_id'] = poliklinikId;
    data['poliklinik_name'] = poliklinikName;
    data['poliklinik_kode'] = poliklinikKode;
    data['poliklinik_icon'] = poliklinikIcon;
    if (doctors != null) {
      data['doctors'] = doctors!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Doctors {
  String? doctorName;
  List<Schedule>? schedule;

  Doctors({this.doctorName, this.schedule});

  Doctors.fromJson(Map<String, dynamic> json) {
    doctorName = json['doctor_name'];
    if (json['schedule'] != null) {
      schedule = <Schedule>[];
      json['schedule'].forEach((v) {
        schedule!.add(Schedule.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['doctor_name'] = doctorName;
    if (schedule != null) {
      data['schedule'] = schedule!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Schedule {
  int? id;
  String? date;
  String? time;

  Schedule({this.id, this.date, this.time});

  Schedule.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['date'] = date;
    data['time'] = time;
    return data;
  }
}
