import 'package:daily_expenses/dailyexpenses.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transparent_image/transparent_image.dart';



class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController serverIpController = TextEditingController();

  String currentip = '192.168.0.130';

  @override
  void initState(){
    //TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Screen'),
      ),


      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Image.asset('assets/perry.jpeg',height: 310),

              
              /*child: FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  image: "https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/8b472d70-a0d6-41b5-9a66-c35687090acc/d8erp10-3fab19e7-fdba-4d50-bfcc-29115ff9a240.jpg/v1/fill/w_1024,h_1326,q_75,strp/perry_platipus_by_edsfox_d8erp10-fullview.jpg?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7ImhlaWdodCI6Ijw9MTMyNiIsInBhdGgiOiJcL2ZcLzhiNDcyZDcwLWEwZDYtNDFiNS05YTY2LWMzNTY4NzA5MGFjY1wvZDhlcnAxMC0zZmFiMTllNy1mZGJhLTRkNTAtYmZjYy0yOTExNWZmOWEyNDAuanBnIiwid2lkdGgiOiI8PTEwMjQifV1dLCJhdWQiOlsidXJuOnNlcnZpY2U6aW1hZ2Uub3BlcmF0aW9ucyJdfQ.OM563nqEM_oakYn_Bjy4Jq5i3SgwizzE4D4Rb-63aJw",
                  height:310
              ),*/
              ),

              Text( "Current IP Address is $currentip", style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              ),

              Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    controller: usernameController,
                    decoration: const InputDecoration(
                      labelText: 'Username',
                    ),
                  ),
              ),

              Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    controller: passwordController,
                    obscureText: true,  //Hide the password
                    decoration: const InputDecoration(
                      labelText: 'Password',
                    ),
                  ),
              ),


              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: serverIpController,
                  decoration: InputDecoration(
                    labelText: "IP address",
                  ),),
              ),



              ElevatedButton(
                  onPressed: () async {
                    // Implement login logic here
                    String username = usernameController.text;
                    String password = passwordController.text;
                    if (username == 'test' && password == '123456789'){
                      //Navigate to the daily expense screen
                      final prefs = await SharedPreferences.getInstance();
                      if (serverIpController.text.isEmpty)
                      {
                        String ip = currentip;
                        await prefs.setString("ip", ip);
                      }
                      else{
                      String ip = serverIpController.text;
                      await prefs.setString("ip", ip);
                      }

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DailyExpensesApp(username:username),
                        ),
                      );
                    }else{
                      //show an error message or handle invalid login
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Login Failed'),
                              content: const Text('Invalid username or password.'),
                              actions: [
                                TextButton(
                                  child: const Text('OK'),
                                  onPressed: (){
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            );
                          },
                      );
                    }
                  },
                  child: const Text ('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
