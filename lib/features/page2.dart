import 'package:flutter/material.dart';

class Page2 extends StatefulWidget {
  const Page2({Key? key}) : super(key: key);

  @override
  _ParentState createState() => _ParentState();
}

class _ParentState extends State<Page2> {
  int _counter = 0;

//當Widget第一次插入到Widget樹時會被調用。對於每一個State對象，Flutter只會調用該回調一次
  @override
  void initState() {
    super.initState();
    print("1. page2 parent initState......");
  }

  /*
  *初始化時，在initState之後立刻調用
  *當State的依賴關係發生變化時，會觸發此接口被調用
  */
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("2. page2 parent didChangeDependencies......");
  }

  @override
  void setState(fn) {
    super.setState(fn);
    print("7. page2 parent setState......");
  }

  //绘制界面
  @override
  Widget build(BuildContext context) {
    print("3. / 8. page2 parent build......");
    return Scaffold(
      appBar: AppBar(title: const Text("Page 2 demo")),
      body: Center(
          child: TextButton(
        ///点击事件
        onPressed: () {
          setState(() {
            _counter++;
          });
        },
        child: Child(count: _counter),
      )),
    );
  }

//狀態改變的時候會調用該方法,比如父類調用了setState
  @override
  void didUpdateWidget(Page2 oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("page2 parent didUpdateWidget......");
  }

  //當State對像從樹中被移除時，會調用此回調
  @override
  void deactivate() {
    super.deactivate();
    print('11. page2 parent deactivate......');
  }

  //當State對像從樹中被永久移除時調用；通常在此回調中釋放資源
  @override
  void dispose() {
    super.dispose();
    print('14. page2 parent dispose......');
  }
}

class Child extends StatefulWidget {
  final int count;
  const Child({Key? key, required this.count}) : super(key: key);

  @override
  _ChildState createState() => _ChildState();
}

class _ChildState extends State<Child> {
  //繪製界面
  @override
  Widget build(BuildContext context) {
    print("6. / 10. child build......");
    return Text('點擊按鈕查看狀態變化 count: ${widget.count}');
  }

  //當Widget第一次插入到Widget樹時會被調用。對於每一個State對象，Flutter只會調用該回調一次
  @override
  void initState() {
    super.initState();
    print("4. page2 child initState......");
  }

  /*
  *初始化時，在initState之後立刻調用
  *當State的依賴關係發生變化時，會觸發此接口被調用
  */
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("5. page2 child didChangeDependencies......");
  } //狀態改變的時候會調用該方法,比如父類調用了setState

  @override
  void didUpdateWidget(Child oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("9. page2 child didUpdateWidget......");
  }

  //當State對像從樹中被移除時，會調用此回調
  @override
  void deactivate() {
    super.deactivate();
    print('12. page2 child deactivate......');
  }

  //當State對像從樹中被永久移除時調用；通常在此回調中釋放資源
  @override
  void dispose() {
    super.dispose();
    print('13. page2 child dispose......');
  }
}
