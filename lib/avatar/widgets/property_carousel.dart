import 'package:flutter/material.dart';

typedef Widget CarouselItemBuilder<T>(T item);
typedef void VoidFunction<T>(T value);
typedef bool BoolFunction<T>(T value);
typedef void VoidCallbackFunction<T>(T value, Function callback);

class PropertyCarousel<T> extends StatefulWidget {
  final List<T> currentList;
  final List<T> options;
  final String caption;
  final VoidFunction callbackSelected;
  final VoidFunction callbackUnselected;
  final CarouselItemBuilder builder;
  final BoolFunction selectable;
  final VoidCallbackFunction disabledCallback;
  final bool isMultiSelect;

  const PropertyCarousel(
      {Key key,
      this.currentList,
      this.options,
      this.caption,
      this.callbackSelected,
      this.callbackUnselected,
      this.builder,
      this.selectable,
      this.disabledCallback,
      this.isMultiSelect = false})
      : super(key: key);

  @override
  _PropertyCarouselState createState() => _PropertyCarouselState<T>();
}

class _PropertyCarouselState<T> extends State<PropertyCarousel<T>> {
  List<T> currentList = [];

  void initState() {
    currentList.addAll(widget.currentList);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(widget.caption),
        Divider(),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: widget.options
                .map((v) => FlatButton(
                      padding: EdgeInsets.all(8),
                      child: Material(
                        elevation: currentList.contains(v) ? 2.0 : 0.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0)),
                        child: Container(
                          height: 128,
                          child: AspectRatio(
                              aspectRatio: 1.0, child: widget.builder(v)),
                        ),
                      ),
                      onPressed: () {
                        if (!widget.selectable(v)) {
                          widget.disabledCallback(v, () {
                            setState(() {
                              if (!widget.isMultiSelect) currentList.clear();
                              currentList.add(v);
                            });
                          });
                          return;
                        }
                        if (!currentList.contains(v)) {
                          setState(() {
                            if (!widget.isMultiSelect) currentList.clear();
                            currentList.add(v);
                          });
                          widget.callbackSelected(v);
                        } else if (widget.isMultiSelect) {
                          setState(() {
                            currentList.remove(v);
                          });
                          widget.callbackUnselected(v);
                        }
                        print(currentList);
                      },
                    ))
                .toList(),
          ),
        )
      ],
    );
  }
}
