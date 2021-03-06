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
  final VoidFunction callbackDeselected;
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
      this.callbackDeselected,
      this.builder,
      this.selectable,
      this.disabledCallback,
      this.isMultiSelect = false})
      : super(key: key);

  @override
  _PropertyCarouselState createState() => _PropertyCarouselState<T>();
}

class _PropertyCarouselState<T> extends State<PropertyCarousel<T>> {
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
                        elevation: widget.currentList.contains(v) ? 2.0 : 0.0,
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
                              if (!widget.isMultiSelect)
                                widget.currentList.clear();
                              widget.currentList.add(v);
                            });
                          });
                          return;
                        }
                        if (!widget.currentList.contains(v)) {
                          setState(() {
                            if (!widget.isMultiSelect)
                              widget.currentList.clear();
                            widget.currentList.add(v);
                          });
                          widget.callbackSelected(v);
                        } else if (widget.isMultiSelect) {
                          setState(() {
                            widget.currentList.remove(v);
                          });
                          widget.callbackDeselected(v);
                        }
                      },
                    ))
                .toList(),
          ),
        )
      ],
    );
  }
}
