/usr/bin/mongoimport --host $APP_MONGO_HOST --port $APP_MONGO_PORT --db movies --collection tags --file /$NETOLOGY_DATA/raw_data/simple_tags.json
----загрузила JSOn

db.tags.count();
---158680----Это число элементов в коллекции tags

db.tags.count({name: 'woman'});
----19-----Это число фильмов с тегом woman

db.tags.aggregate([{$group: {_id: "$name", tag_count: { $sum: 1}}}, {sort:{tag_count: -1}}, {$limit: 3}]);
----- Топ-3 самых распространенных тэгов

