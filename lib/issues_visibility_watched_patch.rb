module IssuesVisibilityWatchedPatch
	
	def self.included(base) 
		base.send(:include, InstanceMethods)

		base.class_eval do 			
			Role::ISSUES_VISIBILITY_OPTIONS << ['watcher', :label_issues_visibility_watcher] 	  
	  	
	  	validate :supress_error_caused_inclusion_validation_for_issues_visibility
		end			
	end	

	module InstanceMethods

		# Because of redefining constant Role::ISSUES_VISIBILITY_OPTIONS,  
		# validation "validates_inclusion_of :issues_visibility" in role.rb causing error,
		# since after_validation collback runs after @role.update_attributes() the only way to realize it is  
		# to delete error raised by this callback with validation below

	  def supress_error_caused_inclusion_validation_for_issues_visibility
	    if errors.any? && Role::ISSUES_VISIBILITY_OPTIONS.flatten.include?(issues_visibility)

	      errors_clone = errors.instance_variable_get('@errors')
	      errors_clone.delete('issues_visibility')
	      errors.instance_variable_set('@errors', errors_clone)
	    end  
	  end
	end

end	
