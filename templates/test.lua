module('test@ID@', package.seeall)

require('parameters')

CFG_strTestName = '@NAME@'

CFG_aParameterDefinitions = {
  {
    name='operand0',
    default=3,
    help='The first argument for the computation.',
    mandatory=false,
    validate=parameters.test_uint32,
    constrains=nil
  },
  {
    name='operand1',
    default=9,
    help='The second argument for the computation.',
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
  local ulOperand0         = tonumber(aParameters['operand0'])
  local ulOperand1         = tonumber(aParameters['operand1'])


  ----------------------------------------------------------------------
  --
  -- Build the parameter structure.
  --
  local aulParameter = {
    -- These are parameters passed from LUA to the netX.
    [1] = ulOperand0,
    [2] = ulOperand1,

    -- These are the parameters which are returned from the netX to LUA.
    [3] = 'OUTPUT'
  }


  ----------------------------------------------------------------------
  --
  -- Open the connection to the netX.
  -- (or re-use an existing connection.)
  --
  local tPlugin = tester.getCommonPlugin()
  if tPlugin==nil then
    error('No plug-in selected, nothing to do!')
  end

  local ulResult = tester.mbin_simple_run(tester.getPanel(), tPlugin, 'netx/skeleton_netx${ASIC_TYPE}.bin', aulParameter)
  if ulResult~=0 then
    error('The test failed!')
  end

  print(string.format('The sum of %d and %d is %d.\n', aulParameter[1], aulParameter[2], aulParameter[3]))

  print('')
  print(' #######  ##    ## ')
  print('##     ## ##   ##  ')
  print('##     ## ##  ##   ')
  print('##     ## #####    ')
  print('##     ## ##  ##   ')
  print('##     ## ##   ##  ')
  print(' #######  ##    ## ')
  print('')
end
