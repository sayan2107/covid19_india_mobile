import 'package:corona_trac_helper/src/ui/home/dashboard/data/data.dart';
import 'package:corona_trac_helper/src/ui/home/dashboard/models/categorie_model.dart';
import 'package:corona_trac_helper/src/ui/home/dashboard/models/product_model.dart';
import 'package:corona_trac_helper/src/ui/home/dashboard/models/trending_productmodel.dart';
import 'package:corona_trac_helper/src/ui/home/dashboard/screens/corona_home_screen.dart';
import 'package:corona_trac_helper/src/utility/color_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeLayoutWidget extends StatefulWidget {
  @override
  _HomeLayoutWidgetState createState() => _HomeLayoutWidgetState();
}

class _HomeLayoutWidgetState extends State<HomeLayoutWidget> {
  List<TrendingProductModel> trendingProducts = new List();
  List<ProductModel> products = new List();
  List<CategorieModel> categories = new List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    trendingProducts = getTrendingProducts();
    products = getProducts();
    categories = getCategories();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 50,),

              /// Search Bar
              Container(
                margin: EdgeInsets.symmetric(horizontal: 12),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      offset: Offset(5.0, 5.0),
                      blurRadius: 5.0,
                      color: Colors.black87.withOpacity(0.05),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 9),
                      child: Text("Search", style: TextStyle(
                          color: Color(0xff9B9B9B),
                          fontSize: 17
                      ),),
                    ),
                    Spacer(),
                    Icon(Icons.search),
                  ],
                ),
              ),

              SizedBox(height: 20,),
              Container(
                height: 200,
                child: GridView.count(
                  physics: NeverScrollableScrollPhysics(),
                  childAspectRatio: 2,
                  padding: const EdgeInsets.all(20),
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  crossAxisCount: 2,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(8),
                      child: const Text('He\'d have you all unravel at the'),
                      color: Colors.teal[100],
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      child: const Text('Heed not the rabble'),
                      color: Colors.teal[200],
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      child: const Text('Sound of screams but the'),
                      color: Colors.teal[300],
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      child: const Text('Who scream'),
                      color: Colors.teal[400],
                    ),

                  ],
                )
              ),

              /// Trending
              Container(
                padding: EdgeInsets.symmetric(horizontal: 22),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text("Top Affected Today", style: TextStyle(
                        color: Colors.black87,
                        fontSize: 22
                    ),),
                    SizedBox(width: 12,),
                    Text("4 March")
                  ],
                ),
              ),
              SizedBox(height: 20,),
              Container(
                padding: EdgeInsets.only(left: 22),
                height: 150,
                child: ListView.builder(
                    itemCount: trendingProducts.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index){
                      return TopAffectedStateTile(
                        stateName: trendingProducts[index].productName,
                        confirmedCases: trendingProducts[index].storename,
                      );
                    }),
              ),

              SizedBox(height: 40,),
              /// Best Selling
              Container(
                padding: EdgeInsets.symmetric(horizontal: 22),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text("State wise affected", style: TextStyle(
                        color: Colors.black87,
                        fontSize: 22
                    ),),
                    SizedBox(width: 12,),
                    Text("This week")
                  ],
                ),
              ),
              SizedBox(height: 20,),
              Container(
                height: 240,
                padding: EdgeInsets.only(left: 22),
                child: ListView.builder(
                    itemCount: products.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index){
                      return EntryItem(data[index]);
                    }),
              ),

              /// Top categorie
              Container(
                padding: EdgeInsets.symmetric(horizontal: 22),
                child: Text("Top categorie", style: TextStyle(
                    color: Colors.black87,
                    fontSize: 22
                ),),
              ),

              SizedBox(height: 20,),
              Container(
                height: 240,
                padding: EdgeInsets.only(left: 22),
                child: ListView.builder(
                    itemCount: categories.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index){
                      return CategorieTile(
                        categorieName: categories[index].categorieName,
                        imgAssetPath: categories[index].imgAssetPath,
                        color1: categories[index].color1,
                        color2: categories[index].color2,
                      );
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}


class CategorieTile extends StatelessWidget {

  String categorieName;
  String imgAssetPath;
  String color1;
  String color2;

  CategorieTile({this.imgAssetPath,this.color2,this.color1,this.categorieName});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 65,
            width: 110,
            margin: EdgeInsets.only(right: 16),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Color(int.parse(color1)),Color(int.parse(color2))]
                ),
                borderRadius: BorderRadius.circular(8)
            ),
            padding: const EdgeInsets.symmetric(vertical: 14,horizontal: 8),
            child: Container(
                child: Image.asset(imgAssetPath,)),
          ),
          SizedBox(height: 8,),
          Text(categorieName),
        ],
      ),
    );
  }
}