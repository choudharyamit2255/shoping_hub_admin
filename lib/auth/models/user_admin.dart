class UserAdmin{
  String username;
  String password;
   UserAdmin(   {required this.username,required this.password});
   Map<String,dynamic> toMap(){
     return{'username':username,
       'password':password,
   };}
}