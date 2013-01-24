require 'redmine_issues_visibility_patch/issues_visibility_issue_patch'
require 'redmine_issues_visibility_patch/issues_visibility_role_patch'

Rails.configuration.to_prepare do
  Role.send(:include, IssuesVisibilityRolePatch)
  Issue.send(:include, IssuesVisibilityIssuePatch)
end
