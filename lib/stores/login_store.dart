class LoginStore{
  Map<String,String> userData = {};

  void saveUserData(String name,String email,String phonenumber){
    userData["name"]=name;
    userData["email"]=email;
    userData["phonenumber"]=phonenumber;
  }
}