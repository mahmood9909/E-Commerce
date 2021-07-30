import 'package:flutter/material.dart';

class ImagesSlider extends StatefulWidget {
  final List images;
  final PageController pageCtrl;
  const ImagesSlider({Key? key, required this.images, required this.pageCtrl})
      : super(key: key);

  @override
  _ImagesSliderState createState() => _ImagesSliderState();
}

class _ImagesSliderState extends State<ImagesSlider> {
  int _selectedPage = 0;

  void _switchThePage(index) => setState(() {
        _selectedPage = index;
      });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView.builder(
          onPageChanged: (index) {
            _switchThePage(index);
          },
          itemBuilder: (context, index) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.45,
              width: MediaQuery.of(context).size.width,
              child: Image.network(
                widget.images[index],
                fit: BoxFit.cover,
              ),
            );
          },
          itemCount: widget.images.length,
          controller: widget.pageCtrl,
        ),
        Positioned(
          bottom: 20,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...widget.images.asMap().entries.map(((imageIndicator) {
                return AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeOutCubic,
                  margin: EdgeInsets.symmetric(horizontal: 3),
                  decoration: BoxDecoration(
                      color: _selectedPage == imageIndicator.key
                          ? Colors.white.withOpacity(0.9)
                          : Colors.white.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(12.0)),
                  height: 10.0,
                  width: _selectedPage == imageIndicator.key ? 35.0 : 10.0,
                );
              }))
            ],
          ),
        )
      ],
    );
  }
}
