JCModel
=======

JCModel is a small, simple framework that automatically converts JSON data to real NSObjects in your data model. It aims to require as little code as possible, by allowing you to specify mappings using PList files, with a simple, easy to understand dot syntax for nested attributes.

Usage
-----

If you're using AFNetworking (which you should be!) and your class's properties have the same name as the JSON attributes, using JCModel is dirt simple. Just make your model object (let's say it's it's called Article) a subclass of JCModel, and set the response serializer on your AFNetworking operation to that Article's JCResponseSerializer, like so:

```objective-c
[operation setResponseSerializer:[Article responseSerializer]];
```

If multiple objects are returned in an array, use 
```objective-c
[Article arrayResponseSerializer];
```
and if the article(s) aren't the root object, use something like
```objective-c
[Article arrayResponseSerializerWithRootKeyPath:@"response.content.articles"];
```
depending on how the JSON looks.

Mapping
-------

I've tried to make the process of specifying an object mapping with JCModel as simple as possible. If your object's properties have the same names as their respective JSON attributes, you're already done! JCPropertyMapper will automatically map all properties that match.

Otherwise, override the method "mappingPlistName" on your JCModel subclass, and return the name of a Plist in your main bundle. That plist can take two possible forms:
- If the names all match, as above, but you only want to map a subset of the mappable properties, the plist can be an array of the names of properties you do want mapped.
- If the names don't match, the plist will be a dictionary. The keys of this dictionary will be the JSON attribute names, and the dictionary values should be the respective object properties you wish to map to.

Here's an example from one of my apps:
![Example mapping](https://dl.dropboxusercontent.com/u/19755362/MappingExample.png)

Some of the syntax might be a little confusing, but I'm in the process of fleshing out the documentation, so check out the source or feel free to contact me if you have any questions.


