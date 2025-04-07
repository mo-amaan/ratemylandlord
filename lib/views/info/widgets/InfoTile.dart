import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rate_my_landlord/constant.dart';
import 'package:rate_my_landlord/routes/route_generator.dart';
import 'package:rate_my_landlord/views/info/widgets/email_sender.dart';
import 'package:url_launcher/url_launcher.dart';


class InfoTile extends StatefulWidget {
  final String name;
  final String github;
  final String email;
  final String image;

  const InfoTile(
      {Key? key,
        required this.name,
        required this.github,
        required this.email,
        required this.image})
      : super(key: key);

  @override
  State<InfoTile> createState() => _InfoTileState();
}

class _InfoTileState extends State<InfoTile> {

  Future<void>? _launched;

  Future<void> _launchURL(String url) async {
    if (!await launch(url,
      forceSafariVC: false,
      forceWebView: false,
      headers: <String, String>{'my_header_key': 'my_header_value'},
    )) throw 'Could not launch $url';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(136, 106, 106, 106),
            blurRadius: 3,
            offset: Offset(2, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(10),
      width: 150,
      child: Column(
        children: [
          //image
          const CircleAvatar(
            // foregroundImage: AssetImage(widget.image),
            backgroundColor: Colors.white,
            child: Icon(FontAwesomeIcons.userSecret,size: 70,
              color: Colors.black,),
            radius: 50,
          ),
          const SizedBox(
            height: 10,
          ),
          //name
          Text(
            widget.name,
            style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: navyBlueColor),
          ),
          const SizedBox(
            height: 10,
          ),
          //social links
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                child: const Icon(FontAwesomeIcons.github),
                onTap: () => setState(() {
                  _launched = _launchURL(widget.github);
                }),
              ),
              const SizedBox(
                width: 20,
              ),
              GestureDetector(
                child: const Icon(FontAwesomeIcons.envelope),
                onTap: () {},
              ),
            ],
          )
        ],
      ),
    );
  }
}

