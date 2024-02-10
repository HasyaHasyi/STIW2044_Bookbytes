class User {
  String? userid;
  String? useremail;
  String? username;
  String? userpassword;
  String? userdatereg;
  String? useraddress;
  String? userphone;



  User(
      {this.userid,
      this.useremail,
      this.username,
      this.userpassword,
      this.userdatereg,
      this.useraddress,
      this.userphone,});
  

  User.fromJson(Map<String, dynamic> json) {
    userid = json['id'];
    useremail = json['email'];
    username = json['name'];
    userpassword = json['userpassword'];
    userdatereg = json['date'];
    userphone = json['userphone'];
    useraddress = json['useraddress'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userid'] = userid;
    data['useremail'] = useremail;
    data['username'] = username;
    data['userpassword'] = userpassword;
    data['userdatereg'] = userdatereg;
    data['useraddress'] = useraddress;
    data['userphone'] = userphone;
    return data;
  }
}