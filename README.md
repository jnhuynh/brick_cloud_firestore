# Brick Cloud Firestore

A package that provides a [Brick][brick] compatible Cloud Firestore provider, repository, and code generation.

**Brick Cloud Firestore is still in a pre-alpha release**

## Packages

- [brick_cloud_firestore][brick_cloud_firestore]: Cloud Firestore connection classes.
- [brick_cloud_firestore_abstract][brick_cloud_firestore_abstract]: Annotations and classes used to generate Cloud Firestore adapters. Exposes `ConnectOfflineFirstWithRest` for class level annotation and `@CloudFirestore` for field level annotation.
- [brick_cloud_firestore_generator][brick_cloud_firestore_generator]: Classes that generate code for annotated classes.
- [brick_offline_first_with_cloud_firestore_build][brick_offline_first_with_cloud_firestore_build]: Builder that generates code for all classes annotated with `ConnectOfflineFirstWithCloudFirestore`. Generates adapters and model dictionaries to support [brick_offline_first][brick_offline_first] and brick_cloud_firestore.

## ConnectOfflineFirstWithCloudFirestore

`@ConnectOfflineFirstWithCloudFirestore` combines a sqlite cache, via [Brick Offline First][brick_offline_first], and Cloud Firestore. By leveraging this annotation, we benefit from code generation that will build adapters for both data sources and DB schema migrations.

### Setup

1. Add the following packages:

```
brick_cloud_firestore:
  git:
    url: https://github.com/jnhuynh/brick_cloud_firestore.git
    path: packages/brick_cloud_firestore
brick_offline_first: any

dev_dependencies:
  build_runner: any
  brick_offline_first_with_cloud_firestore_build:
    git:
      url: https://github.com/jnhuynh/brick_cloud_firestore.git
      path: packages/brick_offline_first_with_cloud_firestore_build
```

```shell
$ flutter pub get
```

2. Create an annotated model

```dart
import 'package:brick_cloud_firestore/cloud_firestore.dart';

@ConnectOfflineFirstWithCloudFirestore()
class Customer extends OfflineFirstWithCloudFirestoreModel {
  final String firstName;
  final String lastName;

  Customer({
    this.firstName,
    this.lastName,
  });
}
```

3. Generate adapters and migrations.

```shell
$ flutter pub run build_runner build
```

[brick]:https://github.com/greenbits/brick
[brick_offline_first]:https://github.com/greenbits/brick/tree/master/packages/brick_offline_first
[brick_cloud_firestore]:https://github.com/jnhuynh/brick_cloud_firestore/tree/master/brick_cloud_firestore
[brick_cloud_firestore_abstract]:https://github.com/jnhuynh/brick_cloud_firestore/tree/master/brick_cloud_firestore_abstract
[brick_cloud_firestore_generator]:https://github.com/jnhuynh/brick_cloud_firestore/tree/master/brick_cloud_firestore_generator
[brick_offline_first_with_cloud_firestore_build]:https://github.com/jnhuynh/brick_cloud_firestore/tree/master/brick_offline_first_with_cloud_firestore_build
