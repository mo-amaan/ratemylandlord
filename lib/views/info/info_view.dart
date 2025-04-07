import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rate_my_landlord/constant.dart';
import 'package:rate_my_landlord/views/info/widgets/InfoTile.dart';

class InfoView extends StatelessWidget {
  const InfoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 50,
        ),
        child: Column(
          children: [
            //! the big image
            SvgPicture.asset(
              'assets/illustrations/DevelopersInfo.svg',
              height: 200,
            ),

            const SizedBox(
              height: 20,
            ),

            //! info tile
            //TODO: update the other's info with proper data
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                InfoTile(
                  name: "Mohammed Amaan",
                  github: "https://github.com/moshiurr",
                  image: 'assets/images/alif.jpeg',
                  email: 'mrahman9@upei.ca',
                ),
                InfoTile(
                  name: "Essayas Kassa",
                  github: "https://github.com/moshiurr",
                  image: 'assets/images/alif.jpeg',
                  email: 'mrahman9@upei.ca',
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                InfoTile(
                  name: "Moshiur Rahman",
                  github: "https://github.com/moshiurr",
                  image: 'assets/images/alif.jpeg',
                  email: 'mrahman9@upei.ca',
                ),
                InfoTile(
                  name: "Mamnoon Sami",
                  github: "https://github.com/moshiurr",
                  image: 'assets/images/alif.jpeg',
                  email: 'mrahman9@upei.ca',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
