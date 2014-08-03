module("test01", package.seeall)

require("parameters")

CFG_strTestName = "TEST_SKELETON"

CFG_aParameterDefinitions = {
	{
		name="add0",
		default=3,
		help="The index of the UART unit to test.",
		mandatory=false,
		validate=parameters.test_uint32,
		constrains=nil
	},
	{
		name="add1",
		default=9,
		help="The index of the MMIO pin for the UART RXD signal.",
		mandatory=false,
		validate=parameters.test_uint32,
		constrains=nil
	}
}


function run(aParameters)
	----------------------------------------------------------------------
	--
	-- Parse the parameters and collect all options.
	--
	local ulAdd0         = tonumber(aParameters["add0"])
	local ulAdd1         = tonumber(aParameters["add1"])
	
	
	----------------------------------------------------------------------
	--
	-- Build the parameter structure.
	--
	local aulParameter = {
		-- These are parameters passed from LUA to the netX.
		ulAdd0,
		ulAdd1,
		
		-- These are the parameters which are returned from the netX to LUA.
		0
	}
	
	
	----------------------------------------------------------------------
	--
	-- Open the connection to the netX.
	-- (or re-use an existing connection.)
	--
	local tPlugin = tester.getCommonPlugin()
	if tPlugin==nil then
		error("No plug-in selected, nothing to do!")
	end
	
	local ulResult = tester.mbin_simple_run(tester.getPanel(), tPlugin, "netx/skeleton_netx${ASIC_TYPE}.bin", aulParameter)
	if ulResult~=0 then
		error("The test failed!")
	end
	
	print("")
	print(" #######  ##    ## ")
	print("##     ## ##   ##  ")
	print("##     ## ##  ##   ")
	print("##     ## #####    ")
	print("##     ## ##  ##   ")
	print("##     ## ##   ##  ")
	print(" #######  ##    ## ")
	print("")
end

