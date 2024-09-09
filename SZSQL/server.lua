local connection = nil
addEventHandler("onResourceStart",resourceRoot,function(resource)
		connection = dbConnect( "mysql", "dbname=sdz;host=127.0.0.1;charset=utf8", "root", "" )
		
		if connection then
			print("[OK] Database connection was successful.")
		else
			print("[Error] There was a problem while trying to connect to database.")
		end
	end
)

function _Query( ... )
	local query = dbQuery(connection, ... )
	local result = dbPoll(query,-1)
	return result
end

function _QuerySingle(str,...)
	local result = _Query(str,...)
	if type(result) == 'table' then
		return result[1]
	end
end

function _Exec(str,...)
	local query = dbExec(connection,str,...)
	return query
end