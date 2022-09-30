import 'package:flutter/material.dart';

class AddButtonWidget extends StatefulWidget {
  final Icon icon1;
  final Color iconcolor1;
  final Widget formdialog1;
  final Icon icon2;
  final Color iconcolor2;
  final Widget formdialog2;

  const AddButtonWidget({
    required this.icon1,
    required this.iconcolor1,
    required this.formdialog1,
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
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);

    _translateButton = Tween<double>(
      begin: 100,
      end: -20,
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
        children: [
          Transform(
            transform: Matrix4.translationValues(
              0.0,
              _translateButton.value * 3,
              0.0,
            ),
            child: FloatingActionButton(
              backgroundColor: widget.iconcolor1,
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
          ),
          Transform(
            transform: Matrix4.translationValues(
              0.0,
              _translateButton.value * 2,
              0.0,
            ),
            child: FloatingActionButton(
              backgroundColor: widget.iconcolor2,
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
          ),
          FloatingActionButton(
            onPressed: _toggle,
            backgroundColor: const Color.fromARGB(255, 0, 27, 67),
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
