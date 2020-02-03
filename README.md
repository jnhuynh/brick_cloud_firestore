# Brick Cloud Firestore

A package that provides a [Brick][brick] compatible Cloud Firestore provider.

**Brick Cloud Firestore is still in a pre-alpha release**

## Packages

- [brick_cloud_firestore][brick_cloud_firestore]: Cloud Firestore connection classes.
- [brick_cloud_firestore_abstract][brick_cloud_firestore_abstract]: Annotations and classes used to generate Cloud Firestore adapters. Exposes `ConnectOfflineFirstWithRest` for class level annotation and `@CloudFirestore` for field level annotation.
- [brick_cloud_firestore_generator][brick_cloud_firestore_generator]: Classes that generate code for annotated classes.
- [brick_offline_first_with_cloud_firestore_build][brick_offline_first_with_cloud_firestore_build]: Builder that generates code for all classes annotated with `ConnectOfflineFirstWithCloudFirestore`. Generates adapters and model dictionaries to support [brick_offline_first][brick_offline_first] and brick_cloud_firestore.

[brick]:https://github.com/greenbits/brick
[brick_offline_first]:https://github.com/greenbits/brick/tree/master/packages/brick_offline_first
[brick_cloud_firestore]:https://github.com/jnhuynh/brick_cloud_firestore/tree/master/brick_cloud_firestore
[brick_cloud_firestore_abstract]:https://github.com/jnhuynh/brick_cloud_firestore/tree/master/brick_cloud_firestore_abstract
[brick_cloud_firestore_generator]:https://github.com/jnhuynh/brick_cloud_firestore/tree/master/brick_cloud_firestore_generator
[brick_offline_first_with_cloud_firestore_build]:https://github.com/jnhuynh/brick_cloud_firestore/tree/master/brick_offline_first_with_cloud_firestore_build
