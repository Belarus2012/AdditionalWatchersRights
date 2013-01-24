# Redmine own time entries

Plugin which add statement "Issues created by or assigned to user or watcher" to issues visibility option
in "administration/roles and permissions" that allow user to browse issues, created by or assigned to him and issues in which he marked as watcher.

## Redmine version

Versions: 1.3.0, 1.4 stable, 2.2.x stable.


## Installation

Just put plugin to the folder REDMINE/vendor/plugins and restart Redmine

No migrations, no new gems.


## Usage

Set issues visibility as "Issues created by or assigned to user or watcher" to allow user see issues created by or assigned to him and issues in which he marked as watcher.


## Changes

Patches:
  * Role#ISSUES_VISIBILITY_OPTIONS
  * Issue#visible?
  * Issue#visible_condition
