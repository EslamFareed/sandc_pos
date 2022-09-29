import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Contact us",
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Image.asset(
              "assets/images/logo.jpg",
              width: MediaQuery.of(context).size.width / 2,
            ),
            SizedBox(
              height: 40.0.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () async {
                    String location =
                        'https://www.google.com/maps/place/Chefchaoun/@30.0343284,31.2162761,17z/data=!3m1!4b1!4m5!3m4!1s0x145846d5f247ec27:0x97a97e15a729813b!8m2!3d30.0343376!4d31.216236';
                    try {
                      bool launched =
                          await launch(location, forceSafariVC: false);

                      if (!launched) {
                        await launch(location, forceSafariVC: false);
                      }
                    } catch (e) {
                      await launch(location, forceSafariVC: false);
                    }
                  },
                  icon: Icon(
                    Icons.location_searching_outlined,
                    size: 24,
                  ),
                  iconSize: 40,
                ),
                Expanded(
                  child: Container(
                    child: Text(
                      "Egypt, Cairo, Helwan",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontSize: 15),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () async {
                    String webSite = 'https://www.facebook.com/EsFareed';
                    try {
                      bool launched =
                          await launch(webSite, forceSafariVC: false);

                      if (!launched) {
                        await launch(webSite, forceSafariVC: false);
                      }
                    } catch (e) {
                      await launch(webSite, forceSafariVC: false);
                    }
                  },
                  icon: Icon(
                    Icons.link,
                    size: 24,
                  ),
                  iconSize: 40,
                ),
                Expanded(
                  child: Container(
                    child: Text(
                      "https://www.facebook.com/EsFareed",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontSize: 15),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () async {
                    try {
                      bool launched = await launch("tel://+201016361173");

                      if (!launched) {
                        await launch("tel://+201016361173");
                      }
                    } catch (e) {
                      await launch("tel://+201016361173");
                    }
                  },
                  icon: Icon(
                    Icons.phone,
                    size: 24,
                  ),
                  iconSize: 40,
                ),
                Expanded(
                  child: Container(
                    child: Text(
                      '+201016361173',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontSize: 15),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Text(
                "Social Media",
                style: TextStyle(color: Colors.grey, fontSize: 20),
              )
            ]),
            SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () async {
                    String faceBoockUrl = 'https://www.facebook.com/EsFareed';
                    try {
                      bool launched =
                          await launch(faceBoockUrl, forceSafariVC: false);

                      if (!launched) {
                        await launch(faceBoockUrl, forceSafariVC: false);
                      }
                    } catch (e) {
                      await launch(faceBoockUrl, forceSafariVC: false);
                    }
                  },
                  child: Image(
                    image: AssetImage('assets/images/facebook.png'),
                    width: 20.w,
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    String insta = 'https://www.instagram.com/chefchaoun_co/';
                    try {
                      bool launched = await launch(insta, forceSafariVC: false);

                      if (!launched) {
                        await launch(insta, forceSafariVC: false);
                      }
                    } catch (e) {
                      await launch(insta, forceSafariVC: false);
                    }
                  },
                  child: Image(
                    image: AssetImage('assets/images/instagram.png'),
                    width: 20.w,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
