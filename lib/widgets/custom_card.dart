import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({Key? key, required this.title, this.onTap})
      : super(key: key);
  final String title;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15),
      child: InkWell(
        onTap: onTap,
        customBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 13),
          decoration: BoxDecoration(
            color: qrColor(title, 100),
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              Container(
                  height: 36,
                  width: 36,
                  decoration: BoxDecoration(
                      color: qrColor(title, 200),
                      borderRadius: BorderRadius.circular(10)),
                  child: const Icon(
                    Icons.qr_code_outlined,
                    size: 30,
                  )),
              const SizedBox(
                width: 10,
              ),
              Flexible(
                child: Text(
                  title,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color qrColor(String title, int opacity) {
    switch (title) {
      case 'Моя машина':
        {
          return Colors.blue[opacity]!;
        }
      case 'Мой ребенок':
        {
          return Colors.purple[opacity]!;
        }
      case 'Моя квартира':
        {
          return Colors.green[opacity]!;
        }
      case 'Мой кошелек':
        {
          return Colors.lightBlue[opacity]!;
        }
      case 'Мой телефон':
        {
          return Colors.cyanAccent[opacity]!;
        }
      default:
        {
          return Colors.amberAccent[opacity]!;
        }
    }
  }
}
