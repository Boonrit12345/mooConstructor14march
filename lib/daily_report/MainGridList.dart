import 'package:flutter/material.dart';

class MainGridList extends StatelessWidget {
  List<_Photo> _photos() {
    return [
      _Photo(imageURL: 'https://image.shutterstock.com/image-photo/surveyor-builder-engineer-theodolite-transit-260nw-747626554.jpg',
          title: 'Eagle',
          subtitle: 'Eagle subtitle'),
      _Photo(imageURL: 'https://image.shutterstock.com/image-photo/silhouette-engineer-standing-orders-construction-260nw-426500653.jpg',
          title: 'Cute Dog',
          subtitle: 'cute cute'),
      _Photo(imageURL: 'https://image.shutterstock.com/image-photo/silhouette-teams-business-engineers-looking-260nw-723993466.jpg',
          title: 'deer',
          subtitle: 'looks kind'),
      _Photo(imageURL: 'https://image.shutterstock.com/image-photo/construction-site-workers-aerial-top-260nw-406114573.jpg',
          title: 'mongoose',
          subtitle: 'hug'),
      _Photo(imageURL: 'https://image.shutterstock.com/image-photo/engineer-working-on-building-site-260nw-547956979.jpg',
          title: 'Horse',
          subtitle: 'yummy'),
      _Photo(imageURL: 'https://cdn.pixabay.com/photo/2016/10/12/23/23/mining-excavator-1736293__340.jpg',
          title: 'Raccoon',
          subtitle: 'Boring'),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.count(crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        padding: const EdgeInsets.all(8),
        childAspectRatio: 1,
            physics: ScrollPhysics(),
        shrinkWrap: true,
        children:_photos().map<Widget>( (photo) {
          return _GridDemoPhotoItem(
            photo: photo,
          );
        }).toList()),
      ),
    );
  }
}

class _Photo {
  _Photo({
    this.imageURL,
    this.title,
    this.subtitle,
  });

  final String imageURL;
  final String title;
  final String subtitle;
}

class GridSubject extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return
      Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Text('รายงานความก้าวหน้า',
            style: TextStyle(fontFamily: 'ConcertOne-Regular',
                fontSize: 22,fontWeight: FontWeight.bold)),
      );
  }
}

class _GridTitleText extends StatelessWidget {
  const _GridTitleText(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      alignment: AlignmentDirectional.centerStart,
        child: Text(text),
    );
  }
}

class _GridDemoPhotoItem extends StatelessWidget {
  _GridDemoPhotoItem({
    Key key,
    @required this.photo,
  }) : super(key: key);

  final _Photo photo;

  @override
  Widget build(BuildContext context) {
    final Widget image = Material(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4)),
      clipBehavior: Clip.antiAlias,
      child: Image.network(photo.imageURL,
        fit: BoxFit.cover,
      ),
    );

    return GridTile(
      footer: Material(
        color: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(4)),
          ),
        clipBehavior: Clip.antiAlias,
        child: GridTileBar(
          backgroundColor: Colors.black45,
          title: _GridTitleText(photo.title),
          subtitle: _GridTitleText(photo.subtitle),
        ),
        ),
      child: image,
      );
  }}