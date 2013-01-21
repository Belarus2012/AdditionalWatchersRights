module IssuesVisibilityWatchedPatch
	
	def self.included(base) 
		base.class_eval do 

		Role::ISSUES_VISIBILITY_OPTIONS << ['watched', :label_issues_visibility_watched] 
		end			
	end	

end	