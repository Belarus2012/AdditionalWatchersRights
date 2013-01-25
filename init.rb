require 'redmine'
require 'redmine_issues_visibility'

Redmine::Plugin.register :redmine_issues_visibility do
  name 'AdditionalWatchersRights'
  author 'Twinslash'
  description 'Plugin which add statement "Issues created by or assigned to user or watcher" to issues visibility option.'
  version '0.0.1'
  url 'https://github.com/Belarus2012/AdditionalWatchersRights'
  author_url 'http://twinslash.com/'
end
