import 'package:flutter/material.dart';
import 'package:swingo/src/card_paint.dart';
import 'package:swingo/src/models/models.dart';
import 'package:swingo/src/pages/pages.dart';
import 'package:swingo/src/theme/decoration.dart';
import 'package:swingo/src/theme/style.dart';
import 'package:swingo/src/utils/constans.dart';
import 'package:swingo/src/utils/formatters.dart';
import 'package:swingo/src/utils/sliders.dart';

class ListItem extends StatefulWidget {
  final Order item;
  final String orderOwnerType;
  final onTap;
  final Widget priceRow;

  const ListItem({
    this.item,
    this.orderOwnerType,
    this.onTap,
    this.priceRow,
  });

  @override
  _ListItemState createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  Future<void> _handleTap(BuildContext context, Order item) async {
    Navigator.push(
      context,
      SlideRightRoute(
          page: Detail(
        item: item,
        orderOwnerType: widget.orderOwnerType,
      )),
    );
  }

  Widget _buildCityRow() {
    return Text(
      "${widget.item.from_city.toUpperCase()} - ${widget.item.to_city.toUpperCase()}",
      style: itemDetailCityStyle,
    );
  }

  Widget _buildDateRow() {
    return Text(
      "${dateVerboseFormatter.format(widget.item.from_date)} - ${dateVerboseFormatter.format(widget.item.to_date)}",
      style: itemBodyDateContentStyle,
    );
  }

  Widget _buildPriceRow() {
    if(widget.priceRow != null){
      return widget.priceRow;
    }

    final price = widget.orderOwnerType == ORDER_OWNER_TYPES['SENDER']
        ? "${widget.item.price} \$"
        : "OFFER";
    return Container(
      margin: const EdgeInsets.all(2.0),
      padding: const EdgeInsets.all(8),
      decoration: new BoxDecoration(
          borderRadius: new BorderRadius.all(Radius.circular(28)),
          color: primaryColor),
      child: Column(
        children: <Widget>[
          Text(
            "payment",
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'Muli',
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            price,
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: 'Muli',
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      children: <Widget>[
        _buildCityRow(),
        SizedBox(
          height: 5,
        ),
        _buildDateRow(),
        SizedBox(
          height: 5,
        ),
        _buildPriceRow(),
      ],
    );
  }

  _buildPainter() {
    return CornerPainter(
      orderType: widget.orderOwnerType,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: cardMargin,
      decoration: CardItemDecoration(),
      child: CustomPaint(
        child: Material(
          elevation: 0.0,
          type: MaterialType.transparency,
          borderRadius: cardBorderRadius,
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            splashColor: Colors.transparent,
            onTap: () => widget.onTap != null
                ? widget.onTap(context)
                : _handleTap(context, widget.item),
            child: Padding(
              padding: cardPadding,
              child: _buildContent(context),
            ),
          ),
        ),
        painter: _buildPainter(),
      ),
    );
  }
}
