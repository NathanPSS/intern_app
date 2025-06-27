
import 'package:flutter/material.dart';

class UserSearch extends StatefulWidget {
  const UserSearch({super.key});

  @override
  _UserSearchState createState() => _UserSearchState();
}

class _UserSearchState extends State<UserSearch> {
  final TextEditingController _controller = TextEditingController();
  bool _isEmpty = true;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
        setState(() {
          _isEmpty = _controller.text.isEmpty;
        });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (MediaQuery.of(context).size.width <= 1280) ? 164 : 320,
        padding: EdgeInsets.only(
          left: 12
        ),
      decoration:  BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(12)),
          border: Border(
            top: BorderSide(width: 2,color: Colors.grey),
            left: BorderSide(width: 2,color: Colors.grey),
            right: BorderSide(width: 2,color: Colors.grey),
            bottom: BorderSide(width: 2,color: Colors.grey)
        )),
        child: TextField(
            controller: _controller,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "Pesquisar Nome",
              suffixIcon: _isEmpty ? Icon(Icons.person_search) : null,
            ),
         ),
    );
  }
}