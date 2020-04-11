import 'package:flutter/material.dart';
import 'package:mooconstructor14march/daily_report/detail_dialog.dart';

class Features extends StatelessWidget {
  List<_FeaturePhoto> _feature() {
    return [
      // PICTURE# 01
      _FeaturePhoto(
          imageURL:
              'https://cdn.pixabay.com/photo/2016/11/24/20/30/architecture-1857175__340.jpg',
          title: 'Beatufil Cat',
          subtitle: 'I love cat',
          featureString: 'Pictue01',
          explain: '13131356'),

      // PICTURE# 02
      _FeaturePhoto(
          imageURL:
              'https://cdn.pixabay.com/photo/2014/10/05/08/11/iron-rods-474792__340.jpg',
          title: 'Loud bird',
          subtitle: 'sometimes the bird is loud',
          featureString: 'Pictue02',
          explain: '13131356'),

      // PICTURE# 03
      _FeaturePhoto(
          imageURL:
              'https://cdn.pixabay.com/photo/2016/07/11/20/31/construction-1510561__340.jpg',
          title: 'Rabit',
          subtitle: 'She is cute',
          featureString: 'Pictue03',
          explain: '13131356'),

      // PICTURE# 04
      _FeaturePhoto(
          imageURL:
              'https://cdn.pixabay.com/photo/2016/02/01/21/15/excavators-1174428__340.jpg',
          title: 'Cat',
          subtitle: 'She is cat',
          featureString: 'Pictue04',
          explain: '13131356'),

      // PICTURE# 05
      _FeaturePhoto(
          imageURL:
              'https://cdn.pixabay.com/photo/2015/11/06/16/38/steelworkers-1029665__340.jpg',
          title: 'Rabit',
          subtitle: 'She is cute',
          featureString: 'Pictue05',
          explain: '13131356'),

      // PICTURE# 06
      _FeaturePhoto(
          imageURL:
              'https://cdn.pixabay.com/photo/2016/12/09/17/35/worker-1895691__340.jpg',
          title: 'Rabit',
          subtitle: 'She is cute',
          featureString: 'Pictue06',
          explain: '13131356'),

      // PICTURE# 07
      _FeaturePhoto(
          imageURL:
              'https://cdn.pixabay.com/photo/2016/11/06/20/24/building-1804030__340.jpg',
          title: 'Rabit',
          subtitle: 'She is cute',
          featureString: 'Pictue07',
          explain: '13131356'),

      // PICTURE# 08
      _FeaturePhoto(
          imageURL:
              'https://cdn.pixabay.com/photo/2019/05/31/10/01/construction-4241847__340.jpg',
          title: 'Rabit',
          subtitle: 'She is cute',
          featureString: 'Pictue08',
          explain: '13131356'),

      // PICTURE# 09
      _FeaturePhoto(
          imageURL:
              'https://cdn.pixabay.com/photo/2016/04/28/15/50/construction-site-1359136__340.jpg',
          title: 'Rabit',
          subtitle: 'She is cute',
          featureString: 'Pictue09',
          explain: '13131356'),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        // color: Colors.grey,
        height: 320,
        width: 220,
        child: ListView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.all(10.0),
            
            children: _feature().map<Widget>((photo) {
              return GestureDetector(
                onTap: () => showDialog(
                    context: context,
                    builder: (context) => DetailDialog(
                        context, photo.imageURL, photo.title, photo.explain)),
                child: _FeatureGridItem(featurePhoto: photo), //Feature(photo)
              );
            }).toList()));
  }
}

class _FeaturePhoto {
  _FeaturePhoto(
      {this.imageURL,
      this.title,
      this.subtitle,
      this.featureString,
      this.explain});
  final String imageURL;
  final String title;
  final String subtitle;
  final String featureString;
  final String explain;
}

class _FeatureText extends StatelessWidget {
  const _FeatureText(this.text, this.fontSize);
  final String text;
  final double fontSize;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 14),
      child: Text(text,
          style:
              TextStyle(fontFamily: 'ConcertOne-Regular', fontSize: fontSize)),
    );
  }
}

class _FeatureGridItem extends StatelessWidget {
  _FeatureGridItem({Key key, @required this.featurePhoto}) : super(key: key);

  final _FeaturePhoto featurePhoto;

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Card(
            semanticContainer: true,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Stack(
              children: <Widget>[
                Image.network(
                  featurePhoto.imageURL,
                  width: 300,
                  height: 230,
                  fit: BoxFit.cover,
                ),
                Positioned(
                    top: 16,
                    left: 200,
                    child: Container(
                      height: 25,
                      width: 80,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3.0),
                          color: Colors.black, //Color(0xff0F0F0F),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                            )
                          ]),
                      child: Center(
                        child: Text(
                          featurePhoto.featureString,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ))
              ],
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
            elevation: 5,
            margin: EdgeInsets.all(5),
          ),
          _FeatureText(featurePhoto.title, 16),
          _FeatureText(featurePhoto.subtitle, 12),
        ]);
  }
}
