import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
                  Container(
                    width: 200, // 넓이를 원하는 값으로 설정
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
                    ),
                  ),
                  SizedBox(width: 30),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightGreen,
                        minimumSize: Size(80, 40)),
                    onPressed: () {},
                    child: Text(
                      '중복 확인',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 350, // 넓이를 원하는 값으로 설정
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
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 350, // 넓이를 원하는 값으로 설정
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: '비밀번호 확인',
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
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 350,
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: '닉네임 입력',
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
                  ),
                ],
              ),
              SizedBox(
                height: 80,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lime,
                    minimumSize: Size(120, 60)),
                onPressed: () {
                  Navigator.pushNamed(
                      context, '/companyspring/signIn'
                    );
                },
                child: Text(
                  '회원가입 완료',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
