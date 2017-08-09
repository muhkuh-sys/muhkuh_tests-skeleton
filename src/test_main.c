
#include "test_main.h"

#include "test_common.h"
#include "rdy_run.h"
#include "systime.h"
#include "uprintf.h"
#include "version.h"


/*--------------------------------------------------------------------------*/


static TEST_RESULT_T test_routine(USER_PARAMETER_T *ptUserParameter)
{
	TEST_RESULT_T tResult;
	unsigned long ulSum;


	/* Initialize the result with an error.
	 * This will be set to "OK" later on if the test succeeds.
	 */
	tResult = TEST_RESULT_ERROR;

	/* Print the parameters. */
	uprintf("Parameters:\n");
	uprintf("  ulOperand0 = 0x%08x\n", ptUserParameter->ulOperand0);
	uprintf("  ulOperand1 = 0x%08x\n", ptUserParameter->ulOperand1);
	uprintf("\n");

	/* TODO: Add the test routine here.
	 * This demonstration just adds the ulOperand0 and ulOperand1 parameters.
	 * If the sum is even, it returns OK. Otherwise it returns an errror.
	 */

	/* Calculate the sum of the ulAdd0 and ulAdd1 parameter. */
	ulSum = ptUserParameter->ulOperand0 + ptUserParameter->ulOperand1;
	uprintf("ulSum = 0x%08x\n", ulSum);

	/* Write the sum to the parameter block so that the LUA script on the
	 * PC can read it.
	 */
	ptUserParameter->ulSum = ulSum;
	
	/* Is the sum even?
	 * A number is even if bit 0 is not set.
	 * This means the bit-wise "and" operation of the sum and "1" must
	 * return 0.
	 */
	if( (ulSum&1)==0 )
	{
		/* The sum is even. Return "OK". */
		tResult = TEST_RESULT_OK;
		uprintf("The sum is even -> OK!\n");
	}
	else
	{
		/* The sum is odd. */
		uprintf("The sum is odd -> ERROR!\n");
	}
	
	return tResult;
}


/*--------------------------------------------------------------------------*/


TEST_RESULT_T test_main(TEST_PARAMETER_T *ptTestParameter)
{
	TEST_RESULT_T tTestResult;
	USER_PARAMETER_T *ptUserParameter;


	/* Initialize the SYSTIME unit.
	 * This is important for delays and SYS LED blink sequences.
	 */
	systime_init();

	/* Show a welcome message including the version. */
	uprintf("\f. *** Test skeleton by doc_bacardi@users.sourceforge.net ***\n");
	uprintf("V" VERSION_ALL "\n\n");

	/* Switch off SYS LED. */
	rdy_run_setLEDs(RDYRUN_OFF);

	/* Show the address of the test parameter. */
	uprintf("ptTestParameter: 0x%08x\n", ptTestParameter);

	/* Get the user parameter. */
	ptUserParameter = (USER_PARAMETER_T*)(ptTestParameter->pvUserParameter);

	/* Show the address of the user parameter. */
	uprintf("ptUserParameter: 0x%08x\n", ptUserParameter);

	/* Call the test routine. */
	tTestResult = test_routine(ptUserParameter);

	/* Set the RDY/RUN LED to green if the result of the test is "OK".
	 * Set it to yellow if an error occured.
	 */
	if( tTestResult==TEST_RESULT_OK )
	{
		rdy_run_setLEDs(RDYRUN_GREEN);
	}
	else
	{
		rdy_run_setLEDs(RDYRUN_YELLOW);
	}

	return tTestResult;
}


/*--------------------------------------------------------------------------*/


