require 'redmine'

require 'issues_visibility_watched_patch'

Rails.configuration.to_prepare do
  Role.send(:include, IssuesVisibilityWatchedPatch)
end


Redmine::Plugin.register :redmine_issues_visibility do
  name 'Redmine Issues Visibility plugin'
  author 'Author name'
  description 'This is a plugin for Redmine'
  version '0.0.1'
  url 'http://example.com/path/to/plugin'
  author_url 'http://example.com/about'
end
