Because this otherwise-CumulusCI-ready repository has a "release" on file, you cannot include it as another CumulusCI-ready project's dependency by putting its URL into a simple `project.dependencies[.github]` property of that other project's `cumulusci.yml` file.

If you try to set up your other project's `cumulusci.yml` like this:

```yaml
project:
  # ...
  dependencies:
    - github: 'https://github.com/kkgthb/sf-cci-02-gh-release-is-most-recent-commit'
```

Then attempts to run `cci flow run dev_org` against that other project's codebase will error out like this:

```
...
------------------------------------------------------------
Running task: update_dependencies
------------------------------------------------------------

Options:
    resolution_strategy: preproduction
    packages_only: False
    interactive: False
    base_package_url_format: {}
Beginning task: UpdateDependencies

Resolving dependencies...
Exception in task dependencies.update_dependencies

Error: 404 Not Found
```

Technically, there's a workaround.  If you structure the calling project's `cumulusci.yml` like this, you can force CumulusCI to use the latest commit to the repository you're trying to include as a dependency, behaving as if there weren't any GitHub releases attatched to the dependency's URL in the first place:


```yaml
project:
  # ...
  dependencies:
    - github: 'https://github.com/kkgthb/sf-cci-02-gh-release-is-most-recent-commit'
  dependency_resolutions:
    # CCI's "preproduction" setting includes what happens when you execute "cci flow run dev_org"
    preproduction: force_cci_to_use_the_latest_commit # You can make this name up, just make it match below.
    resolution_strategies:
      force_cci_to_use_the_latest_commit: # You can make this name up, just make it match above.
        - unmanaged
```

The problem with this workaround is that you'll probably end up forcing _all_ GitHub links to look for the latest commit -- even ones like NPSP that have proper packaging-and-releases in place.

So this repository is _**not**_ a role model to emulate when you're developing your own CumulusCI projects that you'd like to see used as dependencies.

It's just a proof-of-concept that I poked at the boundaries of CCI behavior with.