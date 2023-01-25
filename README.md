ruby-xml
========

Ruby - example program to read and process an XML file.

QuickStart
----------

The [build.sh](./build.sh) script will prepare the gem set, update bundles and
invoke [rake](https://github.com/ruby/rake). The rake targets are:

* bundles             - Install bundles
* check               - Check project syntax with RuboCop
* check:auto_correct  - Auto-correct RuboCop offenses
* clean               - Remove any temporary products
* clobber             - Remove any generated files
* clobber_doc         - Remove RDoc HTML files
* doc                 - Build RDoc HTML files
* help                - Show help
* info                - Show bundle and Gem information
* redoc               - Rebuild RDoc HTML files
* run                 - Run script with test XML file (verbose)
* test                - Test classes

The default build target is `test`.

rubocop
-------

To correct "Missing frozen string literal comment" error run:

```bash
bundle exec rubocop --auto-correct --only FrozenStringLiteralComment
```

or

```bash
./build.sh check:autocorrect_all
```

Overrides are defined in [rubocop.yml](.rubocop.yml)

Versions
--------

Tested with:

* `ruby 1.9.3p484 (2013-11-22 revision 43786) [x86_64-linux]`
* `ruby 2.3.3p222 (2016-11-21 revision 56859) [x86_64-linux]`
* `ruby 3.1.2p20 (2022-04-12 revision 4491bb740a) [x86_64-linux-gnu]`

