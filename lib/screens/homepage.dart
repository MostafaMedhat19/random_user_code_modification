import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:random_user/providers/user_provider.dart';
import '../Widgets/user_item.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Random Users"),
        centerTitle: true,
      ),
      body: Consumer<UserProvider>(builder: (context, value, child) {
        var data = value.userData?.result;
        if(data == null)
          {
             value.fetchUsers();
             return const Center(child: CircularProgressIndicator());
          }
          else
            {
              return ListView.separated(
                itemCount: 5,
                itemBuilder: (context, index) {

                  return UserItem(
                    name: data[index]['name']['first'].toString(),
                    email: data[index]['email'].toString(),
                    image: data[index]['picture']['large'],
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(height: 10),



              );
            }
      },),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final userProvider = Provider.of<UserProvider>(context, listen: false);
           userProvider.fetchUsers(); 
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
