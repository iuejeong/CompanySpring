import 'package:companyspring/database/databaseConfig.dart';
import 'package:companyspring/database/user.dart';
import 'package:companyspring/main.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _meaningController = TextEditingController();
  final DatabaseService _databaseService = DatabaseService();
  Future<List<User>> _userList = DatabaseService()
      .databaseConfig()
      .then((_) => DatabaseService().selectUsers());
  int currentCount = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => addUserDialog(context),
            );
          },
          child: const Icon(
            Icons.add,
          ),
        ),
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
        body: Container(
          width: screenWidth,
          height: screenHeight,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/login_background.jpg'),
              fit: BoxFit.cover,
            ),
          ),          
          padding: const EdgeInsets.all(10),
          child: FutureBuilder(
            future: _userList,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                currentCount = snapshot.data!.length;
                if (currentCount == 0) {
                  return const Center(
                    child: Text("방 없음"),
                  );
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return userBox(
                        snapshot.data![index].idx,
                        snapshot.data![index].userId,
                        snapshot.data![index].password,
                      );
                    },
                  );
                }
              } else if (snapshot.hasError) {
                return const Center(
                  child: Text("Error."),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Widget userBox(int id, String name, String meaning) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(15),
          child: Text("$id"),
        ),
        Container(
          padding: const EdgeInsets.all(15),
          child: Text(name),
        ),
        Container(
          padding: const EdgeInsets.all(15),
          child: Text(meaning),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              updateButton(id),
              const SizedBox(
                width: 10,
              ),
              deleteButton(id),
            ],
          ),
        ),
      ],
    );
  }

  Widget updateButton(int id) {
    return ElevatedButton(
        onPressed: () {
          Future<User> user = _databaseService.selectUser(id);
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => updateUserDialog(user, context),
          );
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.green),
        ),
        child: const Icon(Icons.edit));
  }

  Widget deleteButton(int id) {
    return ElevatedButton(
      onPressed: () => showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => deleteUserDialog(id, context),
      ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.red),
      ),
      child: const Icon(Icons.delete),
    );
  }

  Widget addUserDialog(context) {
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("방 추가"),
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(
              Icons.close,
            ),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(hintText: "방 제목을 입력하세요."),
          ),
          const SizedBox(
            height: 15,
          ),
          TextField(
            controller: _meaningController,
            decoration: const InputDecoration(hintText: "비밀번호를 입력하세요."),
          ),
          const SizedBox(
            height: 15,
          ),
          ElevatedButton(
            onPressed: () {
              _databaseService
                  .insertUser(User(
                      idx: currentCount + 1,
                      userId: _nameController.text,
                      password: _meaningController.text,
                      nickname: _meaningController.text,))
                  .then((result) {
                if (result) {
                  Navigator.of(context).pop();
                  setState(() {
                    _userList = _databaseService.selectUsers();
                  });
                } else {
                  print("insert Error");
                }
              });
            },
            child: const Text("생성"),
          ),
        ],
      ),
    );
  }

  Widget updateUserDialog(Future<User> user, BuildContext context) {
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("방 제목 수정"),
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.close),
          ),
        ],
      ),
      content: FutureBuilder(
        future: user,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            _nameController.text = snapshot.data!.userId;
            _meaningController.text = snapshot.data!.password;
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(hintText: "방 제목을 입력하세요."),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextField(
                  controller: _meaningController,
                  decoration: const InputDecoration(hintText: "비밀번호를 입력하세요."),
                ),
                const SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                  onPressed: () {
                    _databaseService
                        .updateUser(User(
                            idx: snapshot.data!.idx,
                            userId: _nameController.text,
                            password: _meaningController.text,
                            nickname: _meaningController.text))
                        .then(
                      (result) {
                        if (result) {
                          Navigator.of(context).pop();
                          setState(() {
                            _userList = _databaseService.selectUsers();
                          });
                        } else {
                          print("update Error");
                        }
                      },
                    );
                  },
                  child: const Text("수정"),
                )
              ],
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text("Error occurred!"),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            );
          }
        },
      ),
    );
  }

  Widget deleteUserDialog(int id, BuildContext context) {
    return AlertDialog(
      title: const Text("이 방을 삭제하시겠습니까?"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {
                  _databaseService.deleteUser(id).then((result) {
                    if (result) {
                      Navigator.of(context).pop();
                      setState(() {
                        _userList = _databaseService.selectUsers();
                      });
                    } else {
                      print("delete Error");
                    }
                  });
                },
                child: const Text("예"),
              ),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop,
                child: const Text("아니오"),
              )
            ],
          ),
        ],
      ),
    );
  }
}
