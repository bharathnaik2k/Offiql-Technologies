import 'package:flutter/material.dart';
import 'package:offiql_techno_assign/utils/custom_widgets.dart';
import 'package:offiql_techno_assign/utils/widgets_custom_class.dart';
import 'package:offiql_techno_assign/widgets/components/data_model_class.dart';

class DetailsScreen extends StatefulWidget {
  final DataModel? dataList;
  final Color? color;

  const DetailsScreen({
    super.key,
    required this.dataList,
    required this.color,
  });

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Scaffold build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Padding(
        padding: const EdgeInsets.only(right: 22.0, left: 22.0),
        child: ListView(
          children: [
            const SizedBox(height: 18.0),
            Center(
              child: Hero(
                tag: "heroTag",
                child: CircleAvatar(
                  backgroundColor: widget.color,
                  radius: 80,
                  child: const Icon(
                    Icons.person_4,
                    size: 60,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 18.0),
            Center(
              child: customText(
                widget.dataList!.name.toString(),
                fontsize: 22.0,
              ),
            ),
            Center(
              child: customText(
                "Username : ${widget.dataList!.username.toString()}",
                fontsize: 14.0,
              ),
            ),
            const SizedBox(height: 18.0),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 220, 220, 220),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  customText(
                    "Contact Detauls",
                    color: Colors.blue,
                  ),
                  const SizedBox(height: 8.0),
                  customText(
                    "Email : ${widget.dataList!.email.toString()}",
                  ),
                  customText(
                    "Mob. : ${widget.dataList!.phone.toString()}",
                  ),
                  const SizedBox(height: 8.0),
                ],
              ),
            ),
            const SizedBox(height: 18.0),
            customText(
              "Website : ${widget.dataList!.website.toString()}",
              color: const Color.fromARGB(255, 177, 139, 0),
              fontsize: 14.0,
            ),
            const SizedBox(height: 18.0),
            customText(
              "Company Details",
              fontsize: 10.0,
              color: const Color.fromARGB(255, 100, 33, 243),
            ),
            const SizedBox(height: 8.0),
            customText(
              widget.dataList!.company!.name.toString(),
            ),
            customText(
              widget.dataList!.company!.catchPhrase.toString(),
            ),
            customText(
              widget.dataList!.company!.bs.toString(),
            ),
            const SizedBox(height: 18.0),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 248, 255, 171),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  customText(
                    "Address",
                    color: Colors.blue,
                  ),
                  const SizedBox(height: 8.0),
                  customText(
                    "Street : ${widget.dataList!.address!.street.toString()}",
                  ),
                  customText(
                    "Suite : ${widget.dataList!.address!.suite.toString()}",
                  ),
                  customText(
                    "City : ${widget.dataList!.address!.city.toString()}",
                  ),
                  customText(
                    "Zipcode : ${widget.dataList!.address!.zipcode.toString()}",
                  ),
                  Row(
                    children: [
                      customText(
                        "Loction : ",
                      ),
                      customText(
                        "Lat : ${widget.dataList!.address!.geo!.lat.toString()} ",
                        color: const Color.fromARGB(255, 0, 8, 248),
                      ),
                      customText(
                        "Lng : ${widget.dataList!.address!.geo!.lng.toString()}",
                        color: Colors.red,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                ],
              ),
            ),
            const SizedBox(height: 18.0),
          ],
        ),
      ),
    );
  }

  PreferredSize appBar() {
    return const PreferredSize(
      preferredSize: Size.fromHeight(kToolbarHeight),
      child: CustomAppbar(
        title: "User Details",
      ),
    );
  }
}
