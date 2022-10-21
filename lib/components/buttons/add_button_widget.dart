import 'package:flutter/material.dart';

class AddButtonWidget extends StatefulWidget {
  final String text1;
  final Icon icon1;
  final Color iconcolor1;
  final Widget formdialog1;
  final String text2;
  final Icon icon2;
  final Color iconcolor2;
  final Widget formdialog2;

  const AddButtonWidget({
    required this.text1,
    required this.icon1,
    required this.iconcolor1,
    required this.formdialog1,
    required this.text2,
    required this.icon2,
    required this.iconcolor2,
    required this.formdialog2,
    Key? key,
  }) : super(key: key);

  @override
  State<AddButtonWidget> createState() => _AddButtonWidgetState();
}

class _AddButtonWidgetState extends State<AddButtonWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  late Animation<double> _buttonAnimatedIcon;

  late Animation<double> _translateButton;

  bool _isExpanded = false;

  @override
  initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..addListener(() {
        setState(() {});
      });

    _buttonAnimatedIcon =
        Tween<double>(begin: 0.0, end: 0.0).animate(_animationController);

    _translateButton = Tween<double>(
      begin: 30,
      end: 0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    super.initState();
  }

  @override
  dispose() {
    _animationController.dispose();
    super.dispose();
  }

  _toggle() {
    if (_isExpanded) {
      _animationController.reverse();
    } else {
      _animationController.forward();
    }

    _isExpanded = !_isExpanded;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Transform(
            transform: Matrix4.translationValues(
              0.0,
              _translateButton.value * 7,
              0.0,
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(15.0),
                          primary: widget.iconcolor1,
                        ),
                        child: widget.icon1,
                        onPressed: () => {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return widget.formdialog1;
                            },
                          )
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          widget.text1,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Lato',
                            color: widget.iconcolor1,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(15.0),
                          primary: widget.iconcolor2,
                        ),
                        child: widget.icon2,
                        onPressed: () => {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return widget.formdialog2;
                            },
                          )
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          widget.text2,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Lato',
                            color: widget.iconcolor2,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          ElevatedButton(
            onPressed: _toggle,
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(20.0),
              primary: const Color.fromARGB(255, 0, 27, 67),
            ),
            // backgroundColor: const Color.fromARGB(255, 0, 27, 67),
            child: AnimatedIcon(
              icon: AnimatedIcons.menu_close,
              progress: _buttonAnimatedIcon,
            ),
          ),
        ],
      ),
    );
  }
}
