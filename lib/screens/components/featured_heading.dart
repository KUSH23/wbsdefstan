
import 'package:flutter/material.dart';
import 'package:wbsessential/screens/components/new_project_form.dart';
import 'package:wbsessential/screens/components/responsive.dart';

class FeaturedHeading extends StatefulWidget {
  const FeaturedHeading({
    Key? key,
    required this.screenSize,
  }) : super(key: key);

  final Size screenSize;

  @override
  State<FeaturedHeading> createState() => _FeaturedHeadingState();
}

class _FeaturedHeadingState extends State<FeaturedHeading> {
  bool _isHovering = false;
  bool _isCreatingNew = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: widget.screenSize.height * 0.06,
        left: widget.screenSize.width / 15,
        right: widget.screenSize.width / 15,
      ),
      child: ResponsiveWidget.isSmallScreen(context)
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Row(),
                const Text(
                  'Projects',
                  style: TextStyle(
                    fontSize: 24,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                InkWell(
                    onHover: (value) {
                      setState(() {
                        value ? _isHovering = true : _isHovering = false;
                      });
                    },
                    onTap:  () {
                      showDialog(
                        context: context,
                        builder: (context) => NewFormDialog(),
                      );
                    },
                    child: Text(
                      'Create New Project',
                      style: TextStyle(
                        color: _isHovering ? Colors.white : Colors.white70,
                      ),
                    )
                ),
                const SizedBox(height: 10),
              ],
            )
          : Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  'Projects',
                  style: TextStyle(
                    fontSize: 40,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Flexible(
                  flex: 3,
                  child: Container(
                    width: double.maxFinite,
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onHover: (value) {
                      setState(() {
                        value ? _isHovering = true : _isHovering = false;
                      });
                    },
                    onTap:  () {
                      showDialog(
                        context: context,
                        builder: (context) => NewFormDialog(),
                      );
                    },
                    child: Text(
                      'Create New Project',
                      style: TextStyle(
                        color: _isHovering ? Colors.white : Colors.white70,
                      ),
                    )
                    ),
                  ),
              ],
            ),
    );
  }
}
