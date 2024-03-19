import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend/models/prevQP_model.dart';
import 'package:frontend/services/ip.dart';
import 'package:frontend/widgets/prevQp_item.dart';
import 'package:http/http.dart' as http;

class PrevQPScreen extends StatefulWidget {
  const PrevQPScreen({super.key});

  @override
  State<PrevQPScreen> createState() => _PrevQPScreenState();
}

class _PrevQPScreenState extends State<PrevQPScreen> {
  List<PrevQp> prevQP = [];

  @override
  void initState() {
    super.initState();
    getPrevQP();
  }

  void getPrevQP() async {
    try {
      http.Response res = await http.get(Uri.parse(
          "${ip}/api/prevQP/getPrevQP?regulation=MR21&department=CSE"));
      if (res.statusCode == 200) {
        List<PrevQp> temp = [];
        var result = jsonDecode(res.body);
        print(result);
        for (int i = 0; i < result.length; i++) {
          PrevQp s = PrevQp.fromMap(result[i] as Map<String, dynamic>);
          temp.add(s);
        }
        setState(() {
          prevQP = temp;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("QP"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: prevQP.length,
              itemBuilder: (context, index) => PrevQpItem(
                prevQp: prevQP[index],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
