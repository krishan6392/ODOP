import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/shimmer/gf_shimmer.dart';
import 'package:odop/firebase_services.dart';
import 'package:odop/widgets/banner_widget.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class BrandHighlights extends StatefulWidget {
  const BrandHighlights({Key? key}) : super(key: key);

  @override
  State<BrandHighlights> createState() => _BrandHighlightsState();
}

class _BrandHighlightsState extends State<BrandHighlights> {
  double _scrollPosition = 0;
  FirebaseService _service = FirebaseService();
  List _brandAds = [];

  @override
  void initState() {
    getBranddAd();
    super.initState();
  }

  getBranddAd() {
    return _service.brandAd.get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        setState(() {
          _brandAds.add(doc);
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          const SizedBox(
            height: 18,
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                ' Highlights',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          Container(
            height: 166,
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            child: PageView.builder(
              itemCount: _brandAds.length,
              itemBuilder: (BuildContext context, int index) {
                return Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8, 0, 4, 8),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: Container(
                                height: 100,
                                color: Colors.deepOrange,
                                child: YoutubePlayer(
                                  controller: YoutubePlayerController(
                                    initialVideoId: _brandAds[index]['youtube'],
                                    flags: const YoutubePlayerFlags(
                                      autoPlay: false,
                                      mute: true,
                                      loop: true,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(8, 0, 4, 8),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(4),
                                    child: Container(
                                      height: 50,
                                      color: Colors.red,
                                      child: CachedNetworkImage(
                                        imageUrl: _brandAds[index]['image1'],
                                        fit: BoxFit.fill,
                                        placeholder: (context, url) =>
                                            GFShimmer(
                                          child: Container(
                                            height: 50,
                                            color: Colors.grey.shade400,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(8, 0, 4, 8),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(4),
                                    child: Container(
                                      height: 50,
                                      color: Colors.red,
                                      child: CachedNetworkImage(
                                        imageUrl: _brandAds[index]['image3'],
                                        fit: BoxFit.fill,
                                        placeholder: (context, url) =>
                                            GFShimmer(
                                          child: Container(
                                            height: 50,
                                            color: Colors.grey.shade400,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(4, 0, 8, 8),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: Container(
                            height: 160,
                            color: Colors.blue,
                            child: CachedNetworkImage(
                              imageUrl: _brandAds[index]['image2'],
                              fit: BoxFit.fill,
                              placeholder: (context, url) => GFShimmer(
                                child: Container(
                                  height: 50,
                                  color: Colors.grey.shade400,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                );
              },
              onPageChanged: (val) {
                setState(() {
                  _scrollPosition = val.toDouble();
                });
              },
            ),
          ),
          _brandAds.isEmpty
              ? Container()
              : DotsIndicatorWidget(
                  scrollPosition: _scrollPosition,
                  itemList: _brandAds,
                )
        ],
      ),
    );
  }
}
