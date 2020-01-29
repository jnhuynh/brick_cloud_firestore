# Brick Cloud Firestore

Firestore connection for Flutter apps using [Brick](https://github.com/greenbits/brick).

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

All fields and associations are supported. Every `Compare` value **except** `Compare.notEqual` is supported.
