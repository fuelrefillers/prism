import 'package:flutter/material.dart';
import 'package:frontend/providers.dart/user_provider.dart';
import 'package:provider/provider.dart';

class FeeStatusScreen extends StatelessWidget {
  const FeeStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Fee Status"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Here are your details :"),
              ],
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                //set border radius more than 50% of height and width to make circle
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Name :"),
                    Text(user.name),
                    const Divider(
                      color: Colors.black,
                    ),
                    const Text("Email :"),
                    Text(user.studentemail),
                    const Divider(
                      color: Colors.black,
                    ),
                    const Text("Mobile :"),
                    Text(user.studentphno),
                    const Divider(
                      color: Colors.black,
                    ),
                    const Text("Department :"),
                    Text(user.branch),
                    const Divider(
                      color: Colors.black,
                    ),
                    const Text("Parent details :"),
                    Text(user.parentname),
                    Text(user.parentphno),
                    Text(user.parentemail),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Fee Status : ",
                    style: TextStyle(
                        fontSize: 25, color: Color.fromARGB(255, 0, 0, 0)),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text("Pay Fee"),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SwitchClass extends StatefulWidget {
  const SwitchClass({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SwitchClassState createState() => _SwitchClassState();
}

class _SwitchClassState extends State<SwitchClass> {
  bool _veganFilterSet = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const Text("body text 2"),
        SwitchListTile(
          value: _veganFilterSet,
          onChanged: (isChecked) {
            setState(() {
              _veganFilterSet = isChecked;
            });
          },
          title: Text(
            'Vegan',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
          subtitle: Text(
            'Only include vegan meals.',
            style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
          activeColor: Theme.of(context).colorScheme.tertiary,
          contentPadding: const EdgeInsets.only(left: 34, right: 22),
        ),
      ],
    );
  }
}
