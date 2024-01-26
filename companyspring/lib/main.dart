import 'package:companyspring/pages/registerPage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
    initialRoute: '/companyspring/signIn',
    routes: {
      '/companyspring/signIn': (context) => const LoginPage(),
      '/companyspring/signUp': (context) => const RegisterPage(),
    },
  ));
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: Container(
          width: screenWidth,
          height: screenHeight,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/login_background.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/companyspring_logo.png',
                    width: 70,
                    height: 70,
                  ),
                  SizedBox(
                    width: 25,
                  ),
                  Text(
                    '회사의 봄',
                    style: TextStyle(
                        fontFamily: 'CompanySpringFont',
                        fontSize: 45,
                        color: Colors.lightGreen),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/id_icon.png',
                    width: 40,
                    height: 40,
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Container(
                      width: 240, // 넓이를 원하는 값으로 설정
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: '아이디 입력',
                          labelStyle: TextStyle(
                            color: Colors.grey.withOpacity(0.7),
                            fontSize: 14,
                          ),
                          contentPadding:
                              EdgeInsets.only(bottom: 10), // 아래 방향으로만 패딩을 줍니다.
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.grey
                                    .withOpacity(0.7)), // 비활성화된 상태일 때의 밑줄 색상
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.blue), // 활성화된 상태일 때의 밑줄 색상
                          ),
                        ),
                      ))
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/password_icon.png',
                    width: 40,
                    height: 40,
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Container(
                    width: 240, // 넓이를 원하는 값으로 설정
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: '비밀번호 입력',
                        labelStyle: TextStyle(
                          color: Colors.grey.withOpacity(0.7),
                          fontSize: 14,
                        ),
                        contentPadding:
                            EdgeInsets.only(bottom: 10), // 아래 방향으로만 패딩을 줍니다.
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.grey
                                  .withOpacity(0.7)), // 비활성화된 상태일 때의 밑줄 색상
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.blue), // 활성화된 상태일 때의 밑줄 색상
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 150,
                    height: 60,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.lightGreen),
                      onPressed: () {},
                      child: Text(
                        '로그인',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                  width: 150,
                  height: 60,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.lime),
                      onPressed: () {
                      Navigator.pushNamed(
                      context, '/companyspring/signUp'
                    );
                      },
                      child: Text(
                        '회원가입',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
