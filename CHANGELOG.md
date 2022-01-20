## Unreleased

### Changes

* Add ActiveSupport 6.0 support
  * [PR#8](https://github.com/yujideveloper/rekkyo/pull/8)
* Add Ruby 2.7 support
  * [PR#9](https://github.com/yujideveloper/rekkyo/pull/9)
* Add Ruby 3.0 and ActiveSupport 6.1 support
  * [PR#12](https://github.com/yujideveloper/rekkyo/pull/12)
* Drop Ruby 2.4 support
  * [PR#14](https://github.com/yujideveloper/rekkyo/pull/14)
* Call `super` when `Rekkyo::Type` is included
* Add Ruby 3.1 and ActiveSupport 3.1 support
* Override `freeze` method to freeze enum members
* Drop ActiveSupport 5.1 support

### Misc

* Migrate CI from Travis CI from GitHub Actions
  * [PR#11](https://github.com/yujideveloper/rekkyo/pull/11)


## 1.0.0 (2019-04-08)

### Changes

* Add support Ruby 2.6
  * [PR#5](https://github.com/yujideveloper/rekkyo/pull/5)

### Misc

* Add examples
* Relax bundler version


## 0.2.0 (2018-12-12)

### Changes

* Add `Rekkyo::Type::Member#===` as an alias of `Rekkyo::Type::Member#match?`
  * [PR#1](https://github.com/yujideveloper/rekkyo/pull/1)
* Change predicate methods for `Rekkyo::Type::Member` to auto-define
  * [PR#2](https://github.com/yujideveloper/rekkyo/pull/2)
* Improve matching with String/Symbol
  * [PR#3](https://github.com/yujideveloper/rekkyo/pull/3)
* Re-implement `Rekkyo::Type::Member` using PORO
  * [PR#4](https://github.com/yujideveloper/rekkyo/pull/4)

### Misc

* Change required rake version in development


## 0.1.0 (2018-12-07)

Initial release
