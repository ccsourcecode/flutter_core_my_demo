import '../viewmodels/home_viewmodel.dart';
import '../widgets/creation_aware_list_item.dart';
import '../widgets/list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider<HomeViewModel>(
        create: (context) => HomeViewModel(),
        child: Consumer<HomeViewModel>(
          builder: (context, model, child) => ListView.builder(
            itemCount: model.items.length,
            itemBuilder: (context, index) => CreationAwareListItem(
              itemCreated: () {
                print('Item created at $index');
                // prevent calling a rebuild while the item is still in the render process.
                // use the SchedulerBinding to make sure the items are refreshed after the current frame
                // that is being drawn
                SchedulerBinding.instance.addPostFrameCallback((duration) =>
                    model.handleItemCreated(index)); // handle the logic here
              },
              child: ListItem(
                title: model.items[index],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
