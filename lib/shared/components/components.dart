import 'package:flutter/material.dart';
import 'package:news_app/modules/webView.dart';

Widget buildArticleItem(article,context){
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: InkWell(
      onTap: (){
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => WebViewScreen('${article['url']}')));
      },
      child: Row(
        children: [
          Container(
            height: 120,
            width: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              image: DecorationImage(
                  image:NetworkImage('${article['urlToImage']}'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 20.0,),
          Expanded(
            child: Container(
              height: 120.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                    '${article['title']}',
                    style: Theme.of(context).textTheme.bodyText1,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  //SizedBox(height: 10.0,),
                  Text(
                    '${article['publishedAt']}',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    ),
  );
}

Widget articleBuilder(list,{isSearch=false}){
  return list.length > 0
      ? ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) => buildArticleItem(list[index],context),
      separatorBuilder: (context, index) => Padding(
        padding: const EdgeInsetsDirectional.only(start: 16.0),
        child: Container(
          height: 1.0,
          width: double.infinity,
          color: Colors.grey[300],
        ),
      ),
      itemCount: list.length)
      : isSearch?  Container() :const Center(child: CircularProgressIndicator());
}