import 'package:flutter/material.dart';
import '../../models/house_entity.dart';
import '../../providers/google_sheets_provider.dart';
import '../add/add_page.dart';

class HomePage extends StatefulWidget {
  final GoogleSheetsProvider provider;
  const HomePage({
    required this.provider,
    Key? key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<HouseEntity>> get houses => widget.provider.getHouses();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    const sheetId = "1uPTi7OYXMPZQcIjNrauM79Avq2_lJLcvYv3Mkhaa6i0";
    const worksheetTitle = "Test1";
    widget.provider.initializeForWorksheet(sheetId, worksheetTitle);
    print("start7");

    return Scaffold(
      appBar: AppBar(
        title: const Text('Houses'),
      ),
      // listening for data change
      body: FutureBuilder(
        builder: (ctx, snapshot) {
          // Checking if future is resolved or not
          if (snapshot.connectionState == ConnectionState.done &&
              isLoading == false) {
            // If we got an error
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  '${snapshot.error} | occurred',
                  style: const TextStyle(fontSize: 18),
                ),
              );

              // if we got our data
            } else if (snapshot.hasData) {
              // Extracting data from snapshot object
              final data = snapshot.data;
              return Padding(
                padding: const EdgeInsets.all(24.0),
                child: ListView.builder(
                    itemCount: data!.length,
                    itemBuilder: (context, index) => HouseCard(
                          name: data[index].name,
                          address: data[index].address,
                          onDelete: () async {
                            await widget.provider.deleteHouse(index);

                            /// should call again the getter
                            setState(() {});
                          },
                        )),
              );
            }
          }

          // Displaying LoadingSpinner to indicate waiting state
          return const Center(
            child: CircularProgressIndicator(),
          );
        },

        // Future that needs to be resolved
        // inorder to display something on the Canvas
        future: houses,
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AddPage(provider: widget.provider)),
          );

          setState(() {});
        },
        child: const Icon(
          Icons.house,
          color: Colors.white,
        ),
      ),
    );
  }
}

class HouseCard extends StatelessWidget {
  final String name;
  final String address;
  final VoidCallback onDelete;

  const HouseCard({
    required this.name,
    required this.address,
    required this.onDelete,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                        fontSize: 20.0, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.start,
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  Text(address, textAlign: TextAlign.start),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Container(
                color: Colors.grey,
                height: 20.0,
                width: 2.0,
              ),
            ),
            Center(
              child: IconButton(
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                onPressed: onDelete,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
