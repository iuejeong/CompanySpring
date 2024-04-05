import 'package:companyspring/database/databaseConfig.dart';
import 'package:companyspring/database/user.dart';
import 'package:flutter/material.dart';
import 'package:mysql_client/mysql_client.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final TextEditingController _userIdController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController = TextEditingController();
  final TextEditingController _nicknameController = TextEditingController();
  final DatabaseService _databaseService = DatabaseService();
  final Future<List<User>> _userList = DatabaseService()
    .databaseConfig()
    .then((_) => DatabaseService().selectUsers());
  MySQLConnection db = DatabaseService().connection;
  bool userIdFlag = false;
  bool nicknameFlag = false;

  @override
  void initState() {
    super.initState();
    userIdFlag = false; // initState에서 초기화
    nicknameFlag = false;
  }

  @override
  void dispose() {
    _userIdController.dispose(); // 위젯이 제거될 때 해당 위젯과 관련된 리소스를 정리하고 해제
    _passwordController.dispose();
    _passwordConfirmController.dispose();
    _nicknameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent, // AppBar의 배경색을 투명하게 설정
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushNamed(context, '/companyspring/login');
            },
          ),
        ),
        extendBodyBehindAppBar: true,
        body: SingleChildScrollView(
          child: Container(
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
                    SizedBox(
                      width: 200,
                      child: TextField(
                        controller: _userIdController,
                          onChanged: (value) {
                          setState(() {
                            // 아이디가 변경될 때마다 userIdFlag를 false로 설정
                            userIdFlag = false;
                          });
                        },
                        decoration: InputDecoration(
                          labelText: '아이디 입력',
                          labelStyle: TextStyle(
                            color: Colors.grey.withOpacity(0.7),
                            fontSize: 14,
                          ),
                          contentPadding:
                              EdgeInsets.only(bottom: 10),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.grey
                                    .withOpacity(0.7)),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.blue),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 30),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.lightGreen,
                          minimumSize: Size(80, 40)),
                      onPressed: () async {
                        String userId = _userIdController.text;
                        if(userId.isEmpty || userId.contains(' ')) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("알림"),
                                content: Text("공백은 사용할 수 없습니다.", style: TextStyle(color: Colors.red),),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text("확인"),
                                  ),
                                ],
                              );
                            },
                          );                        
                        }else {
                          DatabaseService databaseService = DatabaseService();
                          bool dupFlag = await databaseService.selectDupUser(userId);
                          if (dupFlag) {
                            userIdFlag = true;
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("알림"),
                                  content: Text("사용 가능한 아이디입니다.", style: TextStyle(color: Colors.green),),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text("확인"),
                                    ),
                                  ],
                                );
                              },
                            );
                          }else {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("알림"),
                                  content: Text("이미 존재하는 아이디입니다.", style: TextStyle(color: Colors.red),),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text("확인"),
                                    ),
                                  ],
                                );
                              },
                            );                        
                          }
                        }
                      },
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
                    SizedBox(
                      width: 350,
                      child: TextField(
                        obscureText: true, // 비밀번호를 숨기도록 설정
                        controller: _passwordController,
                        decoration: InputDecoration(
                          labelText: '비밀번호 입력',
                          labelStyle: TextStyle(
                            color: Colors.grey.withOpacity(0.7),
                            fontSize: 14,
                          ),
                          contentPadding:
                              EdgeInsets.only(bottom: 10),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.grey
                                    .withOpacity(0.7)),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.blue),
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
                    SizedBox(
                      width: 350,
                      child: TextField(
                        obscureText: true,
                        controller: _passwordConfirmController,
                        decoration: InputDecoration(
                          labelText: '비밀번호 확인',
                          labelStyle: TextStyle(
                            color: Colors.grey.withOpacity(0.7),
                            fontSize: 14,
                          ),
                          contentPadding:
                              EdgeInsets.only(bottom: 10),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.grey
                                    .withOpacity(0.7)),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.blue),
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
                    SizedBox(
                      width: 200,
                      child: TextField(
                        controller: _nicknameController,
                          onChanged: (value) {
                          setState(() {
                            // 닉네임이 변경될 때마다 userIdFlag를 false로 설정
                            nicknameFlag = false;
                          });
                        },
                        decoration: InputDecoration(
                          labelText: '닉네임 입력',
                          labelStyle: TextStyle(
                            color: Colors.grey.withOpacity(0.7),
                            fontSize: 14,
                          ),
                          contentPadding:
                              EdgeInsets.only(bottom: 10),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.grey
                                    .withOpacity(0.7)),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.blue),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 30),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.lightGreen,
                          minimumSize: Size(80, 40)),
                      onPressed: () async {
                        String nickname = _nicknameController.text;
                        if(nickname.isEmpty || nickname.contains(' ')) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("알림"),
                                content: Text("공백은 사용할 수 없습니다.", style: TextStyle(color: Colors.red),),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text("확인"),
                                  ),
                                ],
                              );
                            },
                          );                        
                        }else {
                          DatabaseService databaseService = DatabaseService();
                          bool dupFlag = await databaseService.selectDupNickname(nickname);
                          if (dupFlag) {
                            nicknameFlag = true;
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("알림"),
                                  content: Text("사용 가능한 닉네임입니다.", style: TextStyle(color: Colors.green),),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text("확인"),
                                    ),
                                  ],
                                );
                              },
                            );
                          }else {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("알림"),
                                  content: Text("이미 존재하는 닉네임입니다.", style: TextStyle(color: Colors.red),),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text("확인"),
                                    ),
                                  ],
                                );
                              },
                            );                        
                          }
                        }
                      },
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
                  height: 80,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lime,
                      minimumSize: Size(120, 60)),
                  onPressed: () {
                      String password = _passwordController.text;
                      String passwordConfirm = _passwordConfirmController.text;
                      if(!userIdFlag) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("알림"),
                                content: Text("아이디 중복 확인을 해주세요.", style: TextStyle(color: Colors.red),),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text("확인"),
                                  ),
                                ],
                              );
                            },
                          );                      
                      }else if (password.isEmpty || passwordConfirm.isEmpty) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("알림"),
                                content: Text("비밀번호를 입력해주세요.", style: TextStyle(color: Colors.red),),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text("확인"),
                                  ),
                                ],
                              );
                            },
                          );                       
                      }else if(password != passwordConfirm) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("알림"),
                                content: Text("비밀번호가 일치하지 않습니다.", style: TextStyle(color: Colors.red),),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text("확인"),
                                  ),
                                ],
                              );
                            },
                          ); 
                      }else if(!nicknameFlag) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("알림"),
                                content: Text("닉네임 중복 확인을 해주세요.", style: TextStyle(color: Colors.red),),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text("확인"),
                                  ),
                                ],
                              );
                            },
                          );                        
                      }else {
                          _databaseService
                              .insertUser(User(
                                  idx: 0,
                                  userId: _userIdController.text,
                                  password: _passwordConfirmController.text,
                                  nickname: _nicknameController.text,))
                              .then((result) {
                            if (result) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text("알림"),
                                    content: Text("회원가입이 완료 되었습니다.", style: TextStyle(color: Colors.green),),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          Navigator.pushNamed(context, '/companyspring/login');
                                        },
                                        child: Text("확인"),
                                      ),
                                    ],
                                  );
                                },
                          ); 
                            } else {
                              print("insert Error");
                            }
                          });
                      }
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
      ),
    );
  }
}
