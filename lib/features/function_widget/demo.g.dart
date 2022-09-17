// **************************************************************************
// FunctionalWidgetGenerator
// **************************************************************************
part of 'demo.dart';

class HomeView extends StatelessWidget {
  const HomeView(this.title, {Key? key}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) => homeView(title);
}

class HeaderSection extends StatelessWidget {
  const HeaderSection(this.title, this.name, {Key? key}) : super(key: key);

  final String title;

  final String name;

  @override
  Widget build(BuildContext context) => headerSection(title, name);
}

class DecoratedContainer extends StatelessWidget {
  const DecoratedContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => decoratedContainer();
}
