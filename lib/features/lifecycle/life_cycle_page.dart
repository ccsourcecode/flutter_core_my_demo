import 'package:flutter/material.dart';
import 'life_cycle_parent.dart';

class LifeCyclePage extends StatefulWidget {
  const LifeCyclePage({Key? key}) : super(key: key);
  @override
  _LifeCyclePageState createState() => _LifeCyclePageState();
}

class _LifeCyclePageState extends State<LifeCyclePage>
    with WidgetsBindingObserver {
  //當Widget第一次插入到Widget樹時會被調用。對於每一個State對象，Flutter只會調用該回調一次
  @override
  void initState() {
    super.initState();
    print("1. LifeCyclePage initState......");
    WidgetsBinding.instance.addObserver(this); //註冊監聽器

    WidgetsBinding.instance.addPostFrameCallback((_) {
      print("Just once: 單次Frame繪製回調"); //只回調一次
    });

    WidgetsBinding.instance.addPersistentFrameCallback((_) {
      print("Many times: 實時Frame繪製回調"); //每幀都回調
    });
  }

  @override
  void setState(fn) {
    super.setState(fn);
    print("LifeCyclePage setState......");
  }

  /*
  *初始化時，在initState之後立刻調用
  *當State的依賴關係發生變化時，會觸發此接口被調用
  */
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("2. LifeCyclePage didChangeDependencies......");
  }

  //繪製界面
  @override
  Widget build(BuildContext context) {
    print("3. LifeCyclePage build......");
    return Scaffold(
      appBar: AppBar(title: const Text("Lifecycle demo")),
      body: Center(
        child: Column(
          children: <Widget>[
            TextButton(
              child: const Text("打開/關閉新頁面查看狀態變化"),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LifeCyleParent()),
              ),
            )
          ],
        ),
      ),
    );
  }

  //狀態改變的時候會調用該方法,比如父類調用了setState
  @override
  void didUpdateWidget(LifeCyclePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("LifeCyclePage didUpdateWidget......");
  }

//當State對像從樹中被移除時，會調用此回調
  @override
  void deactivate() {
    super.deactivate();
    print('LifeCyclePage deactivate......');
  }

  //當State對像從樹中被永久移除時調用；通常在此回調中釋放資源
  @override
  void dispose() {
    super.dispose();
    print('LifeCyclePage dispose......');
    WidgetsBinding.instance.removeObserver(this); //移除監聽器
  }

  //監聽App生命週期回調
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    print("$state");
    if (state == AppLifecycleState.resumed) {
      //do sth
    }
  }
}
