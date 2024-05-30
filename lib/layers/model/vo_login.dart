
class Login {
 final String userID;
 final  String password;

 Login(this.userID, this.password);

 Map<String, dynamic> toMap(){
  return {
   'email': userID,
   'password': password,
  };
 }
}