addEventHandler("onResourceStart",resourceRoot,function(resource)
		if resource then
			setFPSLimit(100)
			return true
		else
			return false
		end
	end
)