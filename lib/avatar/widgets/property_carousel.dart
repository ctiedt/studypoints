import 'package:flutter/material.dart';

typedef Widget CarouselItemBuilder<T>(T item);
typedef void VoidFunction<T>(T value);
typedef bool BoolFunction<T>(T value);

class PropertyCarousel<T> extends StatefulWidget {
  final T current;
  final List<T> options;
  final String caption;
  final VoidFunction callback;
  final CarouselItemBuilder builder;
  final BoolFunction selectable;

  const PropertyCarousel(
      {Key key,
      this.current,
      this.options,
      this.caption,
      this.callback,
      this.builder,
      this.selectable})
      : super(key: key);

  @override
  _PropertyCarouselState createState() => _PropertyCarouselState<T>();
}

class _PropertyCarouselState<T> extends State<PropertyCarousel> {
  T current;

  @override
  void initState() {
    current = widget.current;
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
                        elevation: current == v ? 2.0 : 0.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0)),
                        child: Container(
                          height: 128,
                          child: AspectRatio(
                              aspectRatio: 1.0, child: widget.builder(v)),
                        ),
                      ),
                      onPressed: () {
                        if (!widget.selectable(v)) return;
                        setState(() {
                          current = v;
                        });
                        widget.callback(current);
                      },
                    ))
                .toList(),
          ),
        )
      ],
    );
  }
}
