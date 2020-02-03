# Brick Cloud Firestore

Firestore connection for Flutter apps using [Brick](https://github.com/greenbits/brick). This package manages your Firestore schema: it is strongly discouraged to manipulate data without using this package.

## Setup

Add the following packages to your pubspec:

```yaml
dependencies:
  brick_cloud_firestore: any
dev_dependencies:
  brick_offline_first_with_firestore_build: any
  build_runner: any
```

And follow the regular [Brick setup](https://github.com/greenbits/brick#setup).

## Supported `Query` Configuration

### `providerArgs`

The following map exactly to the Firestore API.

* `limit`
* `orderBy`

When using `orderBy`, follow SQLite syntax::

```dart
Query(
  providerArgs: {'orderBy': 'lastName ASC'},
)
```

### `where:`

All fields are supported. Every `Compare` value **except** `Compare.notEqual` is supported.

Associations are not currently supported but are in active development.
