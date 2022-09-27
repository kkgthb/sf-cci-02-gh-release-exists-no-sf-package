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

However, if the latest commit to the project that you'd like to include as a dependency happens to be associated with a GitHub release that in turn is associated with a tag whose name begins with "`rel/`," then it **_is_** includable by setting up the calling `cumulusci.yml` like this instead:


```yaml
project:
  # ...
  dependencies:
    - github: 'https://github.com/kkgthb/sf-cci-02-gh-release-is-most-recent-commit'
  dependency_resolutions:
    preproduction: force_cci_to_use_the_latest_commit_which_also_is_a_properly_formatted_release # You can make this name up, just make it match below.
    resolution_strategies:
      force_cci_to_use_the_latest_commit_which_also_is_a_properly_formatted_release: # You can make this name up, just make it match above.
        - unmanaged
```