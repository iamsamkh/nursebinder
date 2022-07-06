class NurseTypeModel {
  NurseTypeModel({this.title, this.img});

  final title;
  final img;
}

List<NurseTypeModel> nurse = [
  NurseTypeModel(
    img: "assets/icon_dokter_umum.png",
    title: "Registered Nurse",
  ),
  NurseTypeModel(
    img: "assets/icon_dokter_umum (1).png",
    title: "Licensed Practical Nurse",
  ),
  NurseTypeModel(
    img: "assets/icon_dokter_umum (2).png",
    title: "Certified Nursing Assistant",
  ),
];

List<NurseTypeModel> get nurseList => nurse;