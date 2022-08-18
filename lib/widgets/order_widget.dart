import 'package:flutter/material.dart';

import '../services/utils.dart';
import 'text_widget.dart';

class OrderWidget extends StatelessWidget {
  const OrderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Utils(context).getTheme;
    final size = Utils(context).getScreenSize;
    Color color = theme == true ? Colors.white : Colors.black;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        borderRadius: BorderRadius.circular(8.0),
        color: Theme.of(context).cardColor.withOpacity(0.4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Flexible(
                flex: size.width < 650 ? 3 : 1,
                child: Image.network(
                  'https://picsum.photos/400',
                  fit: BoxFit.fill,
                )),
            const SizedBox(
              width: 12,
            ),
            Expanded(
                flex: 10,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextWidget(
                      text: '12x For \$19.9',
                      color: color,
                      textSize: 16,
                      isTitle: true,
                    ),
                    FittedBox(
                      child: Row(
                        children: [
                          TextWidget(
                            text: 'By',
                            color: Colors.blue,
                            textSize: 16,
                            isTitle: true,
                          ),
                          TextWidget(
                            text: '  Emon.',
                            color: color,
                            textSize: 14,
                            isTitle: true,
                          ),
                        ],
                      ),
                    ),
                    const Text(
                      '20/03/2022',
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
