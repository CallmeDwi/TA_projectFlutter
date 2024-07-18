import 'package:flutter/material.dart';
import 'package:perhutaniwisata_app/widgets/app_text.dart';

class ResponsiveButton extends StatelessWidget {
  final bool isResponsive;
  final double width;

  ResponsiveButton({
    Key? key,
    this.width = 120, // Provide a default width if not specified
    this.isResponsive = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        width: isResponsive == true ? double.maxFinite : width,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.black, // Example background color, adjust as needed
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: isResponsive == true
                ? MainAxisAlignment.spaceBetween
                : MainAxisAlignment.center,
            children: [
              isResponsive == true
                  ? Container(
                      margin: const EdgeInsets.only(
                        left: 20,
                      ),
                      child: AppText(
                        text: "Back to Home",
                        color: Colors.white,
                        size: 18,
                      ),
                    )
                  : Container(),
              Image.asset(
                "img/rightarrowwhite.png",
                width: 35,
                height: 35,
              ), // Corrected the asset path
            ],
          ),
        ),
      ),
    );
  }
}
