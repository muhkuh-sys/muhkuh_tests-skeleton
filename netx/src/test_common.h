
#ifndef __TEST_COMMON_H__
#define __TEST_COMMON_H__


/*--------------------------------------------------------------------------*/


typedef enum ENUM_TEST_RESULT
{
	TEST_RESULT_OK = 0,
	TEST_RESULT_ERROR = 1
} TEST_RESULT_T;



typedef struct STRUCT_TEST_PARAMETER
{
	unsigned int ulReturnValue;
	void *pvUserParameter;
	void *pvReturnMessage;
} TEST_PARAMETER_T;


/*--------------------------------------------------------------------------*/

TEST_RESULT_T test_main(TEST_PARAMETER_T *ptTestParameter);

/*--------------------------------------------------------------------------*/


#endif  /* __TEST_COMMON_H__ */
