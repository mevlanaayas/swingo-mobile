import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:swingo/src/ankara/general.dart';
import 'package:swingo/src/models/models.dart';
import 'package:swingo/src/pages/profile/match_details.dart';
import 'package:swingo/src/theme/decoration.dart';
import 'package:swingo/src/theme/style.dart';
import 'package:swingo/src/utils/sliders.dart';

class MatchItem extends StatefulWidget {
  final SwMatch item;

  const MatchItem({this.item});

  @override
  _MatchItemState createState() => _MatchItemState();
}

class _MatchItemState extends State<MatchItem> {
  Widget _buildHeading(String username) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: <Widget>[
            Row(
              children: <Widget>[
                widget.item.purchaser.username == username
                    ? const Icon(
                        FontAwesomeIcons.moneyBillWave,
                        color: secondaryColor,
                        size: 11.0,
                      )
                    : const Icon(
                        FontAwesomeIcons.babyCarriage,
                        color: secondaryColor,
                        size: 11.0,
                      ),
                const SizedBox(
                  width: 5.0,
                ),
                widget.item.purchaser.username == username
                    ? const Text(
                        "PURCHASING",
                        style: itemBodyDetailContentStyle,
                      )
                    : const Text(
                        "CARRYING",
                        style: itemBodyDetailContentStyle,
                      ),
              ],
            ),
            // Text("₺" + widget.item.price.toString(), style: itemPriceContentStyle)
          ],
        ),
        Text("₺" + widget.item.value.toString(), style: itemPriceContentStyle)
      ],
    );
  }

  Widget _buildBody() {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Text(
              widget.item.fromAddress,
              style: itemBodyDetailContentStyle,
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: <Widget>[
            Text(
              widget.item.toAddress,
              style: itemBodyDetailContentStyle,
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: <Widget>[
            const Text(
              "Payment",
              style: blackTextStyle,
            ),
            const SizedBox(
              width: 5.0,
            ),
            Text(
              widget.item.paymentType.toString(),
              style: blackTextStyle,
            ),
          ],
        ),
        const SizedBox(
          height: 5.0,
        ),
        Row(
          children: <Widget>[
            const Text(
              "Status",
              style: blackTextStyle,
            ),
            const SizedBox(
              width: 5.0,
            ),
            Text(
              widget.item.status,
              style: blackTextStyle,
            ),
          ],
        ),
      ],
    );
  }

  bool isExpanded = false;

  Future<void> _handleTap(BuildContext context, SwMatch item) async {
    Navigator.push(
      context,
      SlideTopRoute(page: MatchDetailScreen(item: item)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserStatus>(context);
    return Padding(
      padding: const EdgeInsets.only(left: 3, right: 3, bottom: 5),
      child: Container(
        decoration: CardItemDecoration(),
        child: Material(
          elevation: 0.0,
          type: MaterialType.transparency,
          borderRadius: const BorderRadius.all(Radius.circular(9)),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            splashColor: Colors.transparent,
            onTap: () => _handleTap(context, widget.item),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeading(userProvider.currentUser.username),
                  const SizedBox(height: 12),
                  _buildBody()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
