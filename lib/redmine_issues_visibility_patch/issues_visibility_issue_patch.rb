module IssuesVisibilityIssuePatch
  def self.included(base)

    base.class_eval do

      # Returns a SQL conditions string used to find all issues visible by the specified user on it's index page
      def self.visible_condition(user, options={})
        Project.allowed_to_condition(user, :view_issues, options) do |role, user|
          case role.issues_visibility
          when 'all'
            nil
          when 'default'
            user_ids = [user.id] + user.groups.map(&:id)
            "(#{table_name}.is_private = #{connection.quoted_false} OR #{table_name}.author_id = #{user.id} OR #{table_name}.assigned_to_id IN (#{user_ids.join(',')}))"
          when 'own'
            user_ids = [user.id] + user.groups.map(&:id)
            "(#{table_name}.author_id = #{user.id} OR #{table_name}.assigned_to_id IN (#{user_ids.join(',')}))"
          # =========== patch start ===========
          when 'watcher'
            user_ids = [user.id] + user.groups.map(&:id)
            "(#{table_name}.author_id = #{user.id} OR #{table_name}.assigned_to_id IN (#{user_ids.join(',')}) OR #{table_name}.id IN (SELECT watchable_id FROM `watchers` WHERE (user_id=3 AND watchable_type='issue')))"
          # =========== patch end =============
          else
            '1=0'
          end
        end
      end

      # Returns true if usr or current user is allowed to view the issue's show page
      def visible?(usr=nil)
        (usr || User.current).allowed_to?(:view_issues, self.project) do |role, user|
          case role.issues_visibility
          when 'all'
            true
          when 'default'
            !self.is_private? || self.author == user || user.is_or_belongs_to?(assigned_to)
          when 'own'
            self.author == user || user.is_or_belongs_to?(assigned_to)
          # =========== patch start ===========
          when 'watcher'
            self.author == user || user.is_or_belongs_to?(assigned_to) || self.watchers.map(&:user_id).include?(user.id)
          # =========== patch end =============
          else
            false
          end
        end
      end

    end

  end
end
