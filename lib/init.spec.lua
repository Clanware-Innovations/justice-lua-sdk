local CWService = require(script.Parent)
local API_TOKEN = "api-token"

return function()
	it("should create a singleton", function()
		expect(function()
			CWService.getInstance()
		end).to.throw()

		expect(function()
			CWService.getInstance(API_TOKEN)
		end).never.to.throw()
	end)

	it("should return an object with the correct methods", function()
		local service = CWService.getInstance(API_TOKEN)

		expect(service.listDegenerates).to.be.a("function")
		expect(service.listExploiters).to.be.a("function")
		expect(service.getDegenerate).to.be.a("function")
		expect(service.getExploiter).to.be.a("function")
		expect(service.searchDegenerates).to.be.a("function")
		expect(service.searchExploiters).to.be.a("function")
		expect(service.checkLegacy).to.be.a("function")
	end)

	it("should throw an error if listCases is called with a page number less than or equal to 0", function()
		local service = CWService.getInstance(API_TOKEN)

		expect(function()
			service.listDegenerates({ page = 0 })
		end).to.throw()

		expect(function()
			service.listDegenerates({ page = -1 })
		end).to.throw()
	end)
end
