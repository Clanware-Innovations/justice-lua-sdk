--!strict
--[[
 * Clanware Lua/Roblox-TS Justice SDK
 * Built for API version 1.0.0
 * Documentation: https://justice.clanware.org/api/docs
--]]

local HttpService = game:GetService("HttpService")

local BASE_URL = "https://justice.clanware.org"
local API_SEMVER = "1.0.0"

type Request = {
	endpoint: string,
	method: "GET" | "POST" | "PUT" | "PATCH" | "DELETE",
	body: { [string]: any }?,
	params: { [string]: any }?,
}

type listCasesParams = {
	page: number?, -- > 0
	limit: number?, -- 1 to 20
	showArchived: boolean?,
}

type ClanwareService = {
	getInstance: (
		apiToken: string?
	) -> {
		apiToken: string,
		listDegenerates: (params: listCasesParams?) -> any,
		listExploiters: (params: listCasesParams?) -> any,
		getDegenerate: (caseId: number, params: { showArchived: boolean? }?) -> any,
		getExploiter: (caseId: number, params: { showArchived: boolean? }?) -> any,
		searchDegenerates: (
			body: {
				robloxIds: { string }?,
				discordIds: { string }?,
				robloxUsernames: { string }?,
				showArchived: boolean?,
			}
		) -> any,
		searchExploiters: (
			body: {
				robloxIds: { string }?,
				discordIds: { string }?,
				robloxUsernames: { string }?,
				showArchived: boolean?,
			}
		) -> any,
		checkLegacy: (robloxId: number) -> any,
	},
}

local createClanwareService = function()
	local instance

	local request = function(req: Request): {
		Body: string?,
		Headers: {
			[string]: string,
		},
		StatusCode: number,
		StatusMessage: string,
		Success: boolean,
	} | false
		local paramStrings = {}
		if req.params then
			for key, value in pairs(req.params) do
				paramStrings[#paramStrings + 1] = key .. "=" .. value
			end
		end

		local url = BASE_URL .. "/" .. req.endpoint .. "?" .. table.concat(paramStrings, "&")

		local success, response = pcall(function()
			return HttpService:RequestAsync({
				Url = url,
				Method = req.method,
				Body = req.body and HttpService:JSONEncode(req.body) or nil,
				Headers = {
					Authorization = instance.apiToken,
				},
			})
		end)

		if not success or response.StatusCode == nil then
			warn("[Clanware] " .. API_SEMVER .. " Request to " .. url .. " failed.")
			return false
		else
			return response
		end
	end

	local listCases = function(endpoint, params)
		if params and params.page and params.page <= 0 then
			error("[Clanware] " .. API_SEMVER .. " Page must be greater than 0")
		end
		return request({
			endpoint = endpoint,
			method = "GET",
			params = params,
		})
	end

	local listDegenerates = function(params)
		return listCases("api/justice/degenerates", params)
	end

	local listExploiters = function(params)
		return listCases("api/justice/exploiters", params)
	end

	local getDegenerate = function(caseId, params)
		return request({
			endpoint = "api/justice/degenerates/" .. caseId,
			method = "GET",
			params = params,
		})
	end

	local getExploiter = function(caseId, params)
		return request({
			endpoint = "api/justice/exploiters/" .. caseId,
			method = "GET",
			params = params,
		})
	end

	local searchDegenerates = function(body)
		return request({
			endpoint = "api/justice/degenerates",
			method = "POST",
			body = body,
		})
	end

	local searchExploiters = function(body)
		return request({
			endpoint = "api/justice/exploiters",
			method = "POST",
			body = body,
		})
	end

	local checkLegacy = function(robloxId)
		return request({
			endpoint = "api/justice/legacy/" .. robloxId,
			method = "GET",
		})
	end

	local getInstance = function(apiToken)
		if not instance then
			if apiToken == nil then
				error("[Clanware] " .. API_SEMVER .. " API token is required for the first time getInstance is called")
			end
			instance = {
				apiToken = apiToken,
				listDegenerates = listDegenerates,
				listExploiters = listExploiters,
				getDegenerate = getDegenerate,
				getExploiter = getExploiter,
				searchDegenerates = searchDegenerates,
				searchExploiters = searchExploiters,
				checkLegacy = checkLegacy,
			}
		end

		return instance
	end

	return { getInstance = getInstance }
end

return createClanwareService()
