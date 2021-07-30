import 'package:flutter/material.dart';

class ListSizes extends StatefulWidget {
  // ignore: non_constant_identifier_names
  final List pro_size;
  final Future<void> Function(String) switchSize;
  ListSizes({required this.pro_size, required this.switchSize, Key? key})
      : super(key: key);

  @override
  _ListSizesState createState() => _ListSizesState();
}

class _ListSizesState extends State<ListSizes> {
  int _sizedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 21),
      child: Row(
        children: [
          ...widget.pro_size.asMap().entries.map((size) => GestureDetector(
                onTap: () {
                  widget.switchSize(size.value).then((value) => setState(() {
                        _sizedIndex = size.key;
                      }));
                },
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    decoration: BoxDecoration(
                        color: _sizedIndex == size.key
                            ? Theme.of(context).accentColor
                            : Color(0xFFDCDCDC),
                        borderRadius: BorderRadius.circular(8.0)),
                    width: 42.0,
                    height: 42.0,
                    child: Center(
                        child: Text(
                      size.value,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: _sizedIndex == size.key
                              ? Colors.white
                              : Colors.black,
                          fontSize: 16.0),
                    )),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
