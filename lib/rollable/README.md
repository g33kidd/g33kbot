# rollable

Roll and parse dices

Works with crystal v0.23.0

## Installation [![travis](https://travis-ci.org/Nephos/crystal_rollable.svg)](https://travis-ci.org/Nephos/crystal_rollable)

Add this to your application's `shard.yml`:

```yaml
dependencies:
  rollable:
    github: Nephos/crystal_rollable
```


## Usage


```crystal
require "rollable"
Rollable::Roll.parse("2d6+4").test # => roll 2 dices and add 4 to the sum
```


## Development

TODO: Write development instructions here

## Contributing

1. Fork it ( https://github.com/Nephos/crystal_rollable/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [Nephos](https://github.com/Nephos) Arthur Poulet - creator, maintainer
