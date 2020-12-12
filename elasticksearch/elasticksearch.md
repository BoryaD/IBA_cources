Задания:
1) Завести Elasticsearch Cluster в Европе
2) Зайти в Kibana -> Dev Tools
3) Создать индекс elasticsearch_cluster с динамическим маппингом с информацией об инстансах созданного ELK стека (в каких регионах созданы,
 какой продукт, для Elasticsearch – какой вид нода, является ли текущим мастером). Информацию берите из deployment на клауде. 
 ```json
 PUT /elasticsearch_cluster
 #
POST elasticsearch_cluster/_doc/1
{ 
  "region": "us-central1-a", 
  "product": "APM", 
  "elasticsearch_info": null 
} 
#
 POST elasticsearch_cluster/_doc/2 
{ 
  "region": "us-central1-a", 
  "product": "Elasticsearch", 
  "elasticsearch_info": { 
      "data": true, 
      "master_eligible": false, 
      "coordinating": true, 
      "master": true, 
      "ingest": true 
  }   
}
#
 POST elasticsearch_cluster/_doc/3 
{ 
  "region": "us-central1-b", 
  "product": "Elasticsearch", 
  "elasticsearch_info": { 
      "data": false, 
      "master_eligible": true, 
      "coordinating": true, 
      "master": false, 
      "ingest": true
  }
}
#
 POST elasticsearch_cluster/_doc/4
{ 
  "region": "us-central1-b",
  "product": "Kibana",
  "elasticsearch_info": null
}
#
 POST elasticsearch_cluster/_doc/5
{
  "region": "us-central1-c",
  "product": "Elasticsearch",
  "elasticsearch_info": {
      "data": false,
      "master_eligible": true,
      "coordinating": false,
      "master": false,
      "ingest": false
  }
}

PUT books
{
  "mappings": {
  }
}

4) Создать индекс с временнЫми данными из любой предметной области. У индекса должно быть 3 primary shards и 3 replica shards.
Mapping должен быть кастомным, при этом должны быть как анализируемые текстовые поля, так и keyword (чтобы соответствовало смыслу).
Дата должна быть в формате дата, а также должны присутствовать числовые данные. Новые текстовые поля должны индексироваться только как keyword.
На одном из keyword полей выключите doc_values. Одно из полей не должно индексироваться вовсе.

####################################################################################
PUT books
{
  "settings": {
  		"index.number_of_shards": 3,
  		"number_of_replicas": 3
  },
  "mappings": {
    "dynamic_templates": [
      {
        "my_string_fields": {
          "match_mapping_type": "string",
          "mapping": {
            "type": "keywords"
          }
        }
      }
    ],
    "properties": {
      "title": {
        "type": "text",
        "doc_values" : false
      },
      "Published": { 
        "type": "date" 
        
      },
      "Country": { 
        "type": "text"
      },
      "Author": { 
        "type": "keyword" 
        
      },
      "Subjects": { 
        "type": "text",
        "analyzer": "english"
        
      },
      "Description": { 
        "enabled" : false
      },
      "Number_of_pages": { 
        "type": "short" 
      }
    }
  }
}

##################################################################
POST books/_doc/1
{
  "title": "The Power of Color",
  "Published": "1995",
  "Country": "United States",
  "Author": "Sara O. Marberry",
  "Subjects": "Color, Color in interior decoration, Decoration, Health aspects, Health aspects of Color, Public buildings",
  "Description": null,
  "Number_of_pages": 111
}

POST books/_doc/2
{
  "title": "The physics",
  "Published": "1929",
  "Country": "UK",
  "Author": "Harvard University Press, Heinemann",
  "Subjects": " Physics textbooks, Outlines, syllabi, Science, Ancient, Textbooks, Philosophy of nature, Philosophy, Criticism and interpretation, Science textbooks, Filosofia antiga, Early works to 1800, Ancient Science, Obres anteriors a 1800, Commentaries, Physics, Fi sica, Physics, early works to 1800",
  "Description": null,
  "Number_of_pages": 544
}
  #######################
POST books/_doc/3
{
  "title": "Rainbow Six",
  "Published": "1998-01-01",
  "Country": "UK",
  "Author": "Tom Clancy",
  "Subjects": "Terrorists, Open Library Staff Picks, Fiction, Terrorism, John Clark Fictitious character, Prevention, Fiction, action  adventure, Terrorism, fiction, Fiction, technological, Fiction, thrillers, general, Clark, john fictitious characte, fiction, Terrorists, fiction, Large type books",
  "Description": "Over the course of nine novels, Tom Clancy's genius for big, compelling plots and his natural narrative gift (The New York Times Magazine) have mesmerized hundreds of millions of readers and established him as one of the preeminent storytellers of our time. Rainbow Six, however, goes beyond anything he has done before.",
  "Number_of_pages": "740"
}
  #######################
POST books/_doc/4
{
  "title": "Yank, the Army Weekly",
  "Published": "1945",
  "Country": "US",
  "Author": " United States. War Department. Special S..., United States. War Department, United States. Armed Forces Information",
  "Subjects": null,
  "Description": "This Week's Cover: This Week's Cover PVT. Raymond Essinger, a Combat MP, of Williamstown, Ohio, is doing his best to learn Tagalog, the official language of The Philippines, spoken by over four million people. It's a big help to MPs who like to get along.",
  "Number_of_pages": "420"
}
  #######################
POST books/_doc/5
{
  "title": "Sula",
  "Published": "2004-11-11",
  "Country": "US",
  "Author": "Toni Morrison",
  "Subjects": "Fiction, African American women, Female friendship, City and town life, Romans, nouvelles, Fiction in English, Amitié féminine, Vie urbaine, Noires américaines, Literature, Ohio, Domestic fiction, open_syllabus_project, African Americans, 1000blackgirlbooks, American fiction (fictional works by one author), Ohio, fiction, African americans, fiction, Fiction, family life, Southern states, fiction, Large type books",
  "Description": "Two girls who grow up to become women. Two friends who become something worse than enemies. In this brilliantly imagined novel, Toni Morrison tells the story of Nel Wright and Sula Peace, who meet as children in the small town of Medallion, Ohio. Their devotion is fierce enough to withstand bullies and the burden of a dreadful secret. It endures even after Nel has grown up to be a pillar of the black community and Sula has become a pariah. But their friendship ends in an unforgivable betrayal—or does it end? Terrifying, comic, ribald and tragic, Sula is a work that overflows with life.",
  "Number_of_pages": "174"
}
  #######################
POST books/_doc/6
{
  "title": "Leonardo Da Vinci and the Splendor of Poland",
  "Published": "2002-09-01",
  "Country": "Poland",
  "Author": "Laurie Winters, Dorota Folga-Januszewska",
  "Subjects": " Leonardo, da vinci, 1452-1519, Painting, european, Painting, collectors and collecting, Painting, exhibitions, European Painting, Painting, Exhibitions, Collectors and collecting",
  "Description": null,
  "Number_of_pages": "352"
}
  #######################
POST books/_doc/7
{
  "title": "Amphoto guide to available light photography",
  "Published": "1980",
  "Country": "Australia",
  "Author": "Don O. Thorpe",
  "Subjects": "Available light photography",
  "Description": "For photograhers",
  "Number_of_pages": "160"
}
  #######################
POST books/_doc/8
{
  "title": "Still Star-Crossed",
  "Published": "2013-02-25",
  "Country": "Poland",
  "Author": "Melinda Taub",
  "Subjects": "Characters in literature, Characters and characteristics in literature, Romance fiction, Family, Vendetta, Juvenile fiction, Benvolio (Fictitious character : Shakespeare), Fiction, Romance, Historical Fiction, Love, Families, History, Love stories",
  "Description": "Despite the glooming peace that has settled on Verona following Romeo’s and Juliet’s tragic deaths, the ancient grudge between the Montagues and Capulets refuses to die: the two houses are brawling in the streets again within a fortnight. Faced anew with “hate’s proceedings,” Prince Escalus concludes that the only way to marry the fortunes of these two families is to literally marry a Montague to a Capulet. But the couple he selects is uninterested in matrimony, for the most eligible Montague bachelor is Benvolio, still anguished by the loss of his friends, and the chosen Capulet maid is Rosaline, whose refusal of Romeo’s affection paved the way for bloodshed. In contrast to their late cousins, there’s no love lost between these two, and so they find a common purpose—resolving the city’s strife in a way that doesn’t end with them at the altar.",
  "Number_of_pages": "342"
}
  #######################
POST books/_doc/9
{
  "title": "Dangerous lies",
  "Published": "2015-04-23",
  "Country": "US",
  "Author": "Becca Fitzpatrick",
  "Subjects": " Witnesses, Young adult fiction, Love, Witnesses our protection, Juvenile fiction, High school students, Fiction, Romance, Protection, Witness protection programs",
  "Description": "After witnessing a murder, high school senior Stella Gordon is sent to Nebraska for her own safety where she chafes at her protection, but when she meets Chet Falconer it becomes harder for her to keep her guard up, and soon she has to deal with the real threat to her life as her enemies are actually closer than she thinks.",
  "Number_of_pages": "384"
}
POST books/_doc/10
{
  "title": "Dangerous lies pt2",
  "Published": "2017-04-23",
  "Country": "US",
  "Author": "Becca Fitzpatrick",
  "Subjects": " Witnesses, Young adult fiction, Love, , Juvenile fiction, High school students, Fiction, Romance, Protection, Witness protection programs",
  "Description": "After witnessing a murder, high school senior Stella Gordon is sent to Nebraska for her own safety where she chafes at her protection, but when she meets Chet Falconer it becomes harder for her to keep her guard up, and soon she has to deal with the real threat to her life as her enemies are actually closer than she thinks.",
  "Number_of_pages": "404"
}

POST books/_doc/11
{
  "title": "Dangerous lies pt3",
  "Published": "2020-04-23",
  "Country": "US",
  "Author": "Becca C. Fitzpatrick",
  "Subjects": " Witnesses, Young adult fiction, Love, Witnesses protection, Juvenile fiction, High school students, Fiction, Romance, Protection, Witness protection programs",
  "Description": "After witnessing a murder, high school senior Stella Gordon is sent to Nebraska for her own safety where she chafes at her protection, but when she meets Chet Falconer it becomes harder for her to keep her guard up, and soon she has to deal with the real threat to her life as her enemies are actually closer than she thinks.",
  "Number_of_pages": "367"
}
  ####################### Нужно было через _bulk, но поздно :(

5) Написать сложный bool запрос с различными видами queries и написать словами, что он показывает.
GET books/_search
{
  "query":{
    "bool": {
      "must": {
        "match": {
          "Country": "US"
        }
      },
      "must_not": {
        "match": {
          "title": "pt3"
        }
      },
      "should": [
        { 
          "range": {
          "Number_of_pages": {
            "gt": 220,
            "lt": 400
          }
        }   
        },
        { 
          "match_phrase": {
            "Subjects": {
              "query": "Witnesses protection",
              "slop": 3}
          }
        }
      ],
      "filter": {
        "range": {
          "Published": {
            "gt": "2000-01-01",
            "lt": "2020-12-01"
          }
        }   
      }
    }
  }
}

Данный запрос вернет книги, в коорые были написаны в США (т.к. поле country объявлено keyword то, гибкости мы не получим, но будет хороший Precision).
Также будут исключены книги в названии которых есть pt3. Также обязательным условием будет то, что книга была опубликована в определнный промежуток времени.
Условия выше будут выполнены обязательно, а условие , что в книге должно быть от 220 до 400 возможно будет выполено, но оно будет влиятть на поряд возвращенных книг,
также как и уcловие, что в полн subjects должно встречаться словосочитане "Witnesses protection", гlt слова могут стоять через 3 слова друг от друга. 

6) Написать сложную агрегацию с sub-buckets и сортировкой по метрикам и написать словами, что она показывает.
Ответ должен содержать только результаты агрегации, но не сами документы.

GET books/_search
{
  "size": 0,
  "aggs": {
    "date_publisged": {
      "date_histogram": {
        "field": "Published",
        "calendar_interval": "year",
        "order": {
          "count_of_pages": "desc"
        }
      },
      "aggs": {
        "count_of_pages": {
          "sum" : {
            "field": "Number_of_pages"
          }
        }
      }
    }
  }
}
Данна агрегация обЪединяет книги написанные в одном году и хранит сумму страниц, и сортирует их по сумме страниц.
 ```